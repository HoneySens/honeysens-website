---
title: 'Updates'
date: 2025-03-12
weight: 8
---

When new HoneySens releases get published, all involved components have update paths from one version to the next. 

<!--more-->

Sensor firmware and honeypot services are the easiest to replace, since their "update" process is to simply replace one revision with another. For that, select the *Services* or *Platforms* view, show the details dialogue for the service or platform in question, then click the *Make default* buttons for the desired revision. 

![platforms-update](/images/update-platforms.png)

Sensors will discard any currently running container with the old revision, download the updated image, then start a container with the new revision. Firmware update are similar: Existing sensors will download the updated revision and replace the currently running firmware with the new one while retaining the sensor configuration. The technical requirements of enabling such unattended updates are platform-dependent, please consult the [Sensor Deployment](/docs/sensors/#sensor-installation) section for further details.

### Updating the server
In comparison to sensors and services, servers are required to follow an incremental update path that only works reliably when updating from one version to the next. The general procedure requires admins to
* Obtain the new [release](/releases/server/), either by downloading the full server distribution or just the template `docker-compose.yml` file.
* Create a [backup](https://github.com/HoneySens/honeysens/tree/master/server/services/backup).
* Temporarily shut the running server down.
* Compare changes between the new and the running `docker-compose.yml` files, then adjust the current configuration accordingly. That typically involves updating at least the service's `image` values.
* Start the server back up. On each startup, an update script will check whether changes to the database schema or data volumes are required and perform those automatically. Log into the web interface and verify in the `Info` section that the *Revision* and *Build ID* show the expected values.

When running the server on top of an orchestrator such as Kubernetes, adapt that procedure accordingly.

[[Top]](#top)
