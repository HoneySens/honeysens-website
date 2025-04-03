---
title: 'Installation'
date: 2025-04-03
weight: 4
---

This section describes the initial steps necessary to deploy HoneySens in any IT infrastructure. We will set up, prepare and configure the server components. Please consult [Preparation](/docs/preparation/) first as a checklist and to understand how a HoneySens deployment could look like in practice. You should prepare a base OS for the server, a domain name, (ideally) TLS certificate and key for said domain and a rough idea of where your server and sensors should be located.

To get a new server up and running, start by downloading the latest distribution from the [Release Page](/releases/server/), then unpack the archive into any target directory. This results in the following directory structure (obviously, `<release>` should be replaced with the current release number and build ID):
~~~
$ tar xf HoneySens-Server-<release>.tar.bz2
$ cd HoneySens-Server-<release>
$ ls -l
-rw-r--r-- 1 user user <size> <date> docker-compose.yml
-rw-r--r-- 1 user user <size> <date> Readme.txt
-rw-r--r-- 1 user user <size> <date> backup-<release>.tar
-rw-r--r-- 1 user user <size> <date> tasks-<release>.tar
-rw-r--r-- 1 user user <size> <date> web-<release>.tar
~~~
The tar archives contain Docker images for various server components and can be registered with `docker load -i <file>.tar`. To load all at once, use `for i in *.tar; do docker load -i $i; done`.

Some mandatory third-party dependencies such as Redis and MySQL will be automatically downloaded from a public registry once the server is started.

As an alternative to downloading the release distribution and registering Docker images, it's also possible to take the shortcut of downloading just a template `docker-compose.yml` from the [Release Page](/releases/server/). It is configured to obtain *all* server components from public registries.

In case deployment is planned with an orchestrator such as Kubernetes, refer to [the repository](https://github.com/HoneySens/honeysens/tree/master/server/deployment/k8s) for a configuration template.

### Configuration
Start by examining the contents of `docker-compose.yml`. Upon service startup, that file will instruct Docker Compose which containers (called *"services"*) to start and how they should be configured. For details on available options, consult the official [Compose file reference](https://docs.docker.com/reference/compose-file/). Each HoneySens server is made up of the following components:
* **backup**: Creates and restores backups; Can reset a deployment to post-installation state.
* **broker**: A volatile key-value store, used as temporary storage and communication channel by other components.
* **database**: SQL-based backend database, used by most other components.
* **registry**: Container registry, distributes and service Docker images to sensors. The registry is managed via the web frontend.
* **tasks**: Services an internal task queue handling long-running and background tasks.
* **web**: Serves both a REST API and web frontend, used by both sensors and users.

Let's discuss the `web` service first:
~~~
web:
  image: honeysens/web:<release>
  restart: unless-stopped
  ports:
    - "80:8080"
    - "443:8443"
  networks:
    - honeysens
  environment:
    - ACCESS_LOG=false
    - API_LOG=false
    - DOMAIN=server
    - HS_DB_PASSWORD=honeysens
    - HS_DB_ROOT_PASSWORD=secret
    - PLAIN_HTTP_API=false
    - TLS_FORCE_12=false
  volumes:
    - honeysens_data:/opt/HoneySens/data
    #- <path to server.chain.crt>:/srv/tls/server.crt
    #- <path to server.key>:/srv/tls/server.key
~~~
The `environment` variables should be reviewed and adjusted as necessary. While most defaults can be kept, **always** change the database credentials `HS_DB_PASSWORD` and `HS_DB_ROOT_PASSWORD` to different unique password strings and save the DNS domain name your server will use in `DOMAIN`. In the `environment` block of the `database` service, make sure `MYSQL_ROOT_PASSWORD` matches `HS_DB_ROOT_PASSWORD` and `MYSQL_PASSWORD` matches `HS_DB_PASSWORD`. In a similar vein, synchronize `HS_DB_PASSWORD` of the `backup`, `web` and `tasks` services.

According to the `volumes` section, a data volume will be mounted into the `web` container at `/opt/HoneySens/data`. The label `honeysens_data` refers to a [named volume](https://docs.docker.com/engine/storage/volumes/#named-and-anonymous-volumes) as defined in the `volumes` section further below. Named volumes generally have the drawback that their contents are stored somewhere in `/var/lib/docker` (the exact path is Linux distribution-dependent). However, many server operators prefer to use a specific predetermined location on the host system instead, such as `/srv/honeysens/data`. To accomplish that, modify the volume statement accordingly, e.g.
~~~
  volumes:
    - /srv/honeysens/data:/opt/HoneySens/data
~~~
When replacing the `honeysens_data` volume like that, supply *the same path* also to the `backup` and the `tasks` services. The remaining volumes `honeysens_backup`, `honeysens_db` and `honeysens_registry` should be treated similarly.

**Caution:** When modifying volume blocks, **only ever** modify the part ahead of the colon. The second part after that refers to static paths within the container and shouldn't be touched.

As mentioned in [Preparation](/docs/preparation/), we strongly recommend to supply your own TLS key and certificate pair for the domain the server is supposed to serve. To mount those into the web container, they can be specified as volume mounts in a similar manner. Simply uncomment and adjust the two additional volume lines in the Compose template, such as
~~~
    - /srv/honeysens/https.chain.crt:/srv/tls/server.crt
    - /srv/honeysens/https.key:/srv/tls/server.key
~~~
The remaining default configuration will open TCP ports 80 (HTTP) and 443 (HTTPS), whereas the HTTP port simply redirects to HTTPS. If you're familiar with Compose files, feel free to further adjust the supplied template to your needs.

#### Optional environment variables
The remaining variables of the `web` service are defined as follows:
* `ACCESS_LOG`: If set to `true`, all HTTP(S) requests sent to the web frontend or API will be logged on the container's stdout.
* `API_LOG`: If set to `true`, all API actions will be logged accompanied by which users performed then and when for auditing purposes. The API log can be accessed only by admin users via a separate *Logging* component in the frontend (sidebar).
* `PLAIN_HTTP_API`: If set to `true`, the container will serve the HTTP API and frontend via unencrypted HTTP on port TCP 8080, which is forwarded to the host on TCP port 80 by default (see `ports` section). This might be required in case there's another TLS-terminating proxy in front of the web container. If set to `false`, HTTP requests to TCP port 80 will be redirected to HTTPS. The web container will *always* serve frontend and API via HTTPS on TCP port 8443, regardless of this setting.
* `TLS_FORCE_12`: If set to `true`, the container will enforce the usage of TLS 1.2 or newer for HTTPS connections.

The `tasks` container exposes a `HS_WORKER_COUNT` setting that defaults to `auto`. It specifies the number of spare worker processes to spawn to handle incoming requests, such as exporting events to CSV or generating sensor configuration archives. The higher this value, the more requests can be processed in parallel. When set to `auto`, the resulting worker count will be a multiple of the number of CPU cores. On systems with a high CPU core count, the resulting hundreds of worker processes might be undesired. In that case, set `HS_WORKER_COUNT` to a fixed number of processes (`4` or `8` should be sufficient for most use cases).

The `backup` container can be instructed to periodically create system backups on the `honeysens_backup` volume (mounted at `/srv/backup` within the container) via the following environment variables:
* `CRON_ENABLED`: If set to `true`, periodic backups are enabled. By default, periodic backups are disabled.
* `CRON_CONDITION`: A cron condition string that defines when backups should be taken. For example, `0 3 * * *` would create a backup every day at 3am (UTC).
* `CRON_DBONLY`: If set to `true`, the backup archives will only contain data stored in the database. Useful in case data on the remaining volumes is part of a separate backup mechanism.
* `CRON_KEEP`: If set to a value greater than zero, old backups will be automatically deleted so that only ever `CRON_KEEPo` backups remain.
* `CRON_TEMPLATE`: A file name template for each newly created backup archive without a suffix (%s will be substituted with the current date and time). 

### Startup
After the configuration file was adjusted accordingly, the server can be launched by executing `docker compose up -d` from within the same directory where `docker-compose.yml` resides. It may be beneficial to omit the daemonizing `-d` for the first start or in the presence of errors, which will dump log output to the console (use `STRG+C` to shut everything down again). If all components could be started properly, the server's web interface should be available on your intended domain. On the same host, you can also point your browser to `https://localhost`. You should be greeted by the setup assistant:

![install-greeting](/images/install-greeting.png)

Follow the instructions on screen. You'll have to provide credentials for the administrative account and the domain name of the server. The latter should be identical to the *Common Name* of the supplied TLS certificate, in case of a self-signed certificate this will default to the `DOMAIN` environment variable of the `web` service. For the last step you then have to supply a group name for the initial group of users that will be created on your behalf (that name can be changed later, though).

After successful completion of the setup procedure, the login screen will be shown:

![install-login](/images/demo-login.png)

Authenticate as `admin` with the password you specified earlier. Then, in the sidebar on the left side, click `Services` and verify that the *Servicy-Registry* is shown as *Online*:

![install-verify](/images/install-verify.png)

The server is now prepared. [Next steps](/docs/sensors/) involve the upload of sensor firmware and honeypot services, as well as the registration of sensors.

[[Top]](#top)
