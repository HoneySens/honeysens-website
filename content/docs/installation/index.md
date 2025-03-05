---
title: 'Installation'
date: 2020-08-13
weight: 4
---

This section describes the initial steps necessary to deploy HoneySens in your IT infrastructure. We will set up, prepare and configure the server components. Please consult [Preparation](/docs/preparation) first as a checklist and to understand how a HoneySens deployment could look like in practice. You should then be armed with a base system for the server, a domain name, (ideally) TLS certificate and key for said domain and a rough idea of where your server and sensors should be located.

To get a new server up and running, start by downloading the latest distribution from the [Release Page](/releases), then unpack the archive into any target directory. This results in the following directory structure (obviously, `<release>` should be replaced with the current release number):
~~~
$ tar xf HoneySens-CE-Server-<release>.tar.bz2
$ cd HoneySens-Server-<release>
$ ls -l
-rw-r--r-- 1 user user        824 Jul  2 15:12 docker-compose.yml
-rw------- 1 user user 1541223424 Jul  2 15:12 server-<release>.tar
~~~
The single archive contains the server's Docker image that can now be registered with `docker load -i server-<release>.tar`.

**Caution:** We haven't published official release HoneySens images on Docker Hub, yet (this might change at some point). Please don't confuse the distribution from the [Release Page](/releases) with the images for the demo system (see [Tour](/docs/tour)), which are indeed [available](https://hub.docker.com/u/honeysens/) on Docker Hub. The latter images are **only** meant for demonstration purposes and should **never** be used in production!

### Configuration
At this point, take a look at `docker-compose.yml`. Upon service startup, that file will instruct Docker Compose which containers (called *"services"* here) to start and how they should be configured. For details on available options, consult the official [Compose file reference](https://docs.docker.com/compose/compose-file/). Currently, the HoneySens server defines two services: `honeysens` and `honeysens-registry`. Let's start with the former:
~~~
honeysens:
  image: honeysens/server:<release>
  container_name: honeysens-server
  restart: always
  ports:
    - 80:80
    - 443:443
  networks:
    - honeysens
  #environment:
    #- TLS_AUTH_PROXY=172.0.0.1
  volumes:
    - honeysens_data:/opt/HoneySens/data
    - honeysens_db:/var/lib/mysql
    #- <path to https.chain.crt>:/opt/HoneySens/data/https.chain.crt
    #- <path to https.key>:/opt/HoneySens/data/https.key
~~~
That container bundles all essential components, including a database and a job queue. In the future, those will be separated into their own containers. For now, focus on the `volumes` section. By default, volumes will be mounted into the container at `/opt/HoneySens/data` (for uploads and configuation data) and `/var/lib/mysql` (the database). The labels `honeysens_data` and `honeysens_db` refer to the [named volumes](https://success.docker.com/article/different-types-of-volumes) as defined in the `volumes` section further below. Named volumes generally have the drawback that their contents are by default stored somewhere in `/var/lib/docker` (this depends on the specific flavor of Linux). However, many operators prefer to use a specific predetermined location instead, such as `/srv/honeysens/`. To accomplish that, modify the volume statements accordingly, e.g.
~~~
  volumes:
    - /srv/honeysens/data:/opt/HoneySens/data
    - /srv/honeysens/db:/var/lib/mysql
~~~
As mentioned in [Preparation](/docs/preparation), we strongly recommend to supply your own TLS key and certificate pair for the domain the server is supposed to run at. To mount those into the server container, they can be specified as volume mounts as well. Simply uncomment and adjust the two additional volume lines in the Compose template, such as
~~~
    - /srv/honeysens/https.chain.crt:/opt/HoneySens/data/https.chain.crt
    - /srv/honeysens/https.key:/opt/HoneySens/data/https.key
~~~
When adjusting the volume statements, **only ever** modify the part ahead of the colon. The second part after that refers to paths within the server container.

**Note:** The environment variable `TLS_AUTH_PROXY` should usually be left commented out. It's only ever used in case there's a proxy in front of the HoneySens server that terminates and relays all incoming HTTPS connections as HTTP. Since that would break TLS client authentication, one can specify the trusted IP address of said proxy as environment variable. As a result, TLS client authentication would then be performed on the proxy, which is expected to relay the results as additional HTTP headers `HTTP_SSL_CLIENT_VERIFY` (`SUCCESS` or `FALSE`) and `HTTP_SSL_CLIENT_S_DN_CN` (common name of the client certificate). For verification, the HoneySens server's internal CA certificate can be extracted from `/opt/HoneySens/data/CA/ca.crt` (within the container). Keep in mind to update the certificate on the frontend proxy whenever the internal CA certificate is renewed.

The second service, `honeysens-registry`, utilizes the official [Docker Registry](https://hub.docker.com/_/registry) image from Docker Hub. That internal registry primarily stores honeypot services and is transparently accessed by sensors. Again, if you don't want to make use of named volumes, adjust the `volumes` section to point to some local path, such as
~~~
    - /srv/honeysens/registry:/var/lib/registry
~~~
It's usually sufficient to modify the volume configuration and keep the defaults for everything else. That will open TCP ports 80 (HTTP) and 443 (HTTPS), although the HTTP port simply forwards to port 443. If you're familiar with Compose files, feel free to further adjust the supplied template to your needs (please don't modify the service names - those are currently hardcoded).

### Startup
When the required Docker images are registered and the configuration file was adjusted accordingly, the server can be launched by executing `docker compose up -d` from within the same directory where `docker-compose.yml` resides. It may be beneficial to omit daemonization `-d` for the first start or in the presence of errors, which will dump log output to the console (use `STRG+C` to shut everything down again). If all components could be started properly, the server's web interface should now be available on your intended domain. From the same host, you can point your browser to `https://localhost`. You should be greeted by the installation assistant:

![install-greeting](/images/install-greeting.png)

Select the first option and follow the instructions on screen. You'll have to provide credentials for the administrative account as well as the domain name of the server. The latter should be identical to the *Common Name* of the supplied TLS certificate, in case of a self-signed certificate this will default to the hostname of the container. For the last step you then have to supply a group name for the initial group of users that will be created on your behalf (that name can be changed later, though).

After successful completion of the setup procedure, the login screen will be shown:

![install-login](/images/demo-login.png)

Authenticate as `admin` with the password you specified earlier. Then, in the sidebar on the left side, click `Services` and verify that the *Servicy-Registry* is shown as *Online*:

![install-verify](/images/install-verify.png)

The server is now prepared. Next steps involve the upload of sensor firmware and honeypot services, as well as the registration of sensors.

[[Top]](#top)
