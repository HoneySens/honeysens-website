---
title: 'Taking the tour'
date: 2020-08-13
weight: 2
---

For a first glance on what HoneySens has to offer we prepared a bunch of preconfigured Docker images that can be utilized to quickly set up a demo environment. Please be aware that these images should **never be used in production**! In case you like what you're seeing, please go ahead and work your way through the [Installation Guide](/docs/installation) for instructions on how to set up a proper HoneySens deployment.

The demo environment is composed of server containers (one for the API and web interface, another running an internal registry) and one "*dockerized*" sensor, running two simple honeypot services.

### Requirements
The demo is offered as a bunch of Docker images which were published on [Docker Hub](https://hub.docker.com/u/honeysens/). To run it, any Linux distribution and recent versions of [Docker Engine](https://docs.docker.com/engine/install/) and [Docker Compose](https://docs.docker.com/compose/install/) are required. Please make sure that those are installed, e.g. by looking at the output of `docker version` and `docker-compose version`, which both should list details about the installed Docker binaries.

### Preparing a Compose File
Next, switch to an empty directory and create a new Compose file named `docker-compose.yml` with the following contents:
```
version: "3"
services:

  server:
    image: honeysens/demo-server:20.01.01
    networks:
      - honeysens
    ports:
      - 80:80
      - 443:443

  honeysens-registry:
    environment:
      - REGISTRY_STORAGE_DELETE_ENABLED=true
    image: honeysens/demo-registry:20.01.01
    networks:
      - honeysens

  sensor:
    environment:
      - IFACE=eth0
    image: honeysens/demo-sensor:20.01.01
    networks:
      - honeysens
    privileged: true

networks:
  honeysens
```
This file defines a Compose project out of three containers, which constitute a minimal working HoneySens deployment. In a real configuration, the sensor(s) would not run alongside the server, but would be deployed within various production networks that should be monitored. In this demo case, however, we deploy both of them together to illustrate their basic functionality. All three images are preconfigured so that the sensor is already registered on the server and some basic honeypot services can be immediately deployed to it right after it starts. The `ports` directive of the server container forwards your local TCP ports 80 (`HTTP`) and 443 (`HTTPS`) to the HoneySens web interface. In case those ports are already taken by other applications, feel free to change those. Since all containers are run within their own user-defined network (called `honeysens` here), they shouldn't interfere with other applications or containers.

**Note**: The sensor requires the `privileged` attribute for proper operation. The reason for that is that the honeypot services are deployed as Docker containers as well, which leads to a nested Docker-in-Docker setup. To run another Docker daemon within an existing Docker container, extended privileges are required.

### Starting the demo environment
From the same directory the aforementioned project file `docker-compose.yml` was created in, the demo environment can be brought up with `docker-compose up`. After a few seconds (as soon as the amount of console output starts to slow down), all required components should be ready and you can access the web interface via [https://localhost](https://localhost) (or `https://localhost:<port>` in case you modified the default port configuration). If nothing wrent wrong, you should be greeted by the login screen:

![demo-login](/images/demo-login.png)

Here you can authenticate as user `admin` with password `honeysens`. After a successful login, the dashboard will be shown which displays the amount of events captured so far over different time periods. The web frontend is structured into different modules such as sensor management, event list or user management, which can all be accessed via the sidebar on the left side.

### Having a look around
We'll now have a look at a few important modules one will frequently come in contact with when managing a HoneySens deployment. First, we want to get an overview over registered sensors and their current status. For that, move the mouse cursor over the taskbar for automatic expansion and click on *Sensors*.

![demo-sensors](/images/demo-sensors.png)

The demo environment comes with a single sensor attached to it, which is called simply *sensor1*, reports the IP address `192.168.32.4` and has two honeypot services enabled: *cowrie*  and *recon*. By default, sensors poll the server every five minutes to send status reports and update their own configuration. According to the *Status* column in the screenshot, our sensor did its last polling successfully one minute ago and is healthy, as indicated by the green cell color. The columns with angled text show which honeypot services are enabled on which sensors: In our case, both services are active and running. If you see a blue background here, the services aren't ready yet (they will be automatically deployed to the sensor on startup). In that case, simply wait a few minutes until the boxes turn green. Obviously, red background color indicates that something has gone wrong.

Now, click on the pencil icon within the *Actions* column to show the current sensor configuration. This ranges from basic settings such as sensor name, location and group assignment to the server connection, update interval and sensor network configuration to more advanced topics such as proxy traversal or custom sensor firmware settings. For now, simply close the dialogue via *Cancel*.

Next up is the overview of registered honypot services, which can be opened with a click on *Services*:

![demo-services](/images/demo-services.png)

In HoneySens terminology, *services* are the actual honeypots, that is container images that offer various fake services to attackers. These honeypots are for the most part freely available Open Source honeypots that were slightly modified for integration into our architecture. Two such services are preinstalled on the demo instance: [cowrie](https://github.com/cowrie/cowrie), a popular SSH honeypot as well as *recon*, which is a simple fallback daemon that responds to and records any TCP and UDP session. More services archives (that adhere to our custom service specification) can be uploaded to the server with the *Add* button on the top right. When a new service was uploaded, a new column will be added to the sensor list which allows scheduling of that particular service (as we have seen previously). When a new services is scheduled, sensors will download and start the service automatically during their next polling interval.

Apart from running sensors as docker containers, the sensor platform itself can vary: HoneySens initially started out with just hardware-based sensors, namely the [BeagleBone Black](https://beagleboard.org/black) (BBB) from Texas Instruments. This platform is still supported, with more platforms planned for the future. If you have a look at the *Platforms* module, an overview over supported platforms will be shown:

![demo-platforms](/images/demo-platforms.png)

This interface is quite similar to the services module. We call the sensor software that runs on each platform *Firmware*. In the case of dockerized sensors, that term simply denotes the sensor Docker image and some accompanying metadata. In the case of BeagleBones, that firmware encompasses a whole SD card image with an installer used to provision new hardware sensors.

Apart from the already discussed modules, there's also a *System* module for general system configuration and management as well as a user and group management area. Sensors and their respective events always belong to a specific group, which allows to share a single HoneySens server with multiple clients or user groups. However, we will now move on to the most important topic when operating honeypots: events.

### Simulated attacks
In this section, we'll now contact the honeypot services that are currently running on our demo sensor. Since honeypots by default are meant to just passively offer services which under normal circumstances would never be contacted by real clients, any connection attempt to a honeypot could indicate a potential attack and might therefore be reported as an *event*. However, what network traffic the sensor actually reports heavily depends on the selection of honeypot services running there.

Our demo sensor has two active services: the *cowrie* honeypot which offers a fake SSH service at TCP port 22 as well as the *recon* catch-all service, which will record and answer any TCP or UDP packet sent to the sensor's IP address. While it might seem sensible at first to respond to any suspicious connection attempt, such a host looks very suspicious to attackers as well. As soon as an intruder realizes that she's just talking to a honeypot, we gain no more valuable data about her behaviour and practices. Insofar one should carefully consider the selection of honeypot services to run on a given sensor. In fact, it's a recommended honeypot practice to simulate the services offered by nearby real systems as close as possible.

For now, we'll connect to both services running on our honeypot to generate a bunch of events. We start by connecting via SSH to the sensor IP as we've previously discovered in the sensor overview (in our case that's `192.168.32.4`, but yours may vary):
```
$ ssh root@192.168.32.4
root@192.168.32.4's password:
The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
root@s4:~#
```
We are now connected to the fake SSH service offered by the *cowrie* honeypot, which allows us to log in as `root` with any password. On that shell, we're free to explore the (simulated) vulnerable Linux system with commands such as `uname -a` or `cat /proc/cpuinfo`. If you're done exploring, simple close the connection with `Strg+D`.

Next, we'll briefly send a few TCP and UDP packets to a random port so that the *recon* service catches them. Using netcat, we start with a simple TCP connection on port 80 and sending the string `TEST`:
```
$ nc -v 192.168.32.4 80
Connection to 192.168.32.4 80 port [tcp/http] succeeded!
TEST
```
The *recon* service will accept that connection, record the first package it receives and then close the connection again. This behaviour enables us to examine the first data packet of any TCP connection, even if there's no suitable honeypot available for the service that was requested by a client. In the case of UDP, the *recon* service will simply log the packet without responding at all:
```
$ nc -u 192.168.32.4 1338
asdf
```
Now that we generated a few events, we'll have a look at what exactly was recorded by our sensor.

### Examining events
After selecting the *Events* item in the sidebar, the event list will be shown. This list can be searched, filtered and ordered according to various parameters. Each time one of the honeypot services running on one of our sensors reports an event, it will be catalogued here for further examination and classification. Apart from a basic classification which depends on the service that reports an event, no further processing is done by the server. It's up to the user to assess the risk of each event individually. After all, HoneySens is just an early-warning system that tries to support administrators in spotting spurious network events.

![demo-events](/images/demo-events.png)

By default, the youngest received event will be shown at the top. If you closely followed the guide, that list will consist of exactly three events: The first two being the UDP and TCP connection attempts recorded by the *recon* service, the third one our fake SSH session. For each event, the table will show when it happend, which sensor recorded it, an internal classification (which also determines the color - red meaning a specialized honeypot service was contacted, SSH in this case), the source IP of the attacker as well as a short summary that depends on the service which generated the event. In the *Details* column, the number in parentheses indicates that there's further event data available. With a click on the *View Details* button on the right of each event more details will be shown:

![demo-tcp-event](/images/demo-tcp-event.png)

Please note that the packet overview first has to be extended by clicking on the white text *Packet overview (4)*. The top part of that dialogue again summarizes the event, while in the lower half more specific details as reported by the service will be shown. In the case of the TCP connection (screenshow above), we see a list of all the TCP packages the *recon* service received in the context of that connection. After the initial handshake we can see the cleartext representation of the `TEST` string we sent earlier via netcat.

In a similar vein, the SSH event doesn't list individual packets, but instead the actual interaction with our fake SSH service:

![demo-ssh-event](/images/demo-ssh-event.png)

Here, we clearly see how the connection was initiated, a login as root without password succeeded, followed by a few shell commands.

### Next steps
That concludes our short tour through the demo system. Even though you should **never run the demo containers in a production environment**, it's still a fully functional deployment that can be useful for toying around with. You can upload firmware, add additional sensors and services. There are also a few more features that assist in day-to-day honeypot operation, such as the ability to whitelist recurring (harmless) events via the *Filter* module as well as E-Mail notifications for events.

In case you're interested to set up your own HoneySens deployment, have a look at the [Installation Guide](/docs/installation), which will lead you through all required steps.

[[Top]](#top)
