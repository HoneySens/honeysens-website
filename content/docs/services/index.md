---
title: 'Services'
date: 2025-03-10
weight: 6
---

A sensor by itself doesn't perform any tasks other than regularly polling the server for configuration updates. To gain value from a sensor, operators have to deploy *services* to add interactivity. Since HoneySens is all about building and maintaining a deception network, those services typically offer honeypot functionalities. More specifically, they are adaptions of popular open source honeypot projects. HoneySens is essentially the glue that enables operators to seamlessly integrate those honeypots into their network. This section describes how to manage the service repository on a HoneySens server and how to deploy honeypots to sensors. We assume that a [server](/docs/installation/) with at least one attached [sensor](/docs/sensors/) was set up beforehand.

### The service repository
Prior to deploying them to sensors, the services in question have to be registered on the HoneySens server first. The basic idea is to reduce the administrative overhead for operators that want to launch new honeypots on a sensor to just a few clicks. To accomplish that, the server exposes an integrated service repository (that is an ordinary container registry under the hood) to its sensors, which in turn can use standardized Docker infrastructure to run containerized services.

For operators, the service repository can be managed via the web interface. Click on the *Services* section in the sidebar to view a list of all currently registered services:

![services-overview](/images/demo-services.png)

The *Status* label in the top left indicates whether the server can communicate with the internal registry successfully. In case it isn't shown as *"Online"*, there is most likely a network-related issue or the registry service didn't start properly. In that case, please head to the [installation](/docs/installation/) guide and check the server configuration.

Similar to firmware, multiple revisions can be uploaded and registered for each service to facilitate a seamless update procedure. In addition to that, each service revision is built for a specific CPU architecture. That requirement stems from the different sensor platforms: While containerized Docker sensors typically run on hosts using the `amd64` architecture, physical sensors (the BeagleBone Black) run on `armhf`. If sensors for different platforms are attached to a HoneySens server, the operators should make sure that services for all involved platforms have been registered. Otherwise, attempting to deploy services to sensors for which there is no revision with the required architecture results in failure.

Going back to the web interface, new service revisions can be added with the *Add* button in the top right. That process is very similar to [adding firmware](/docs/sensors/#registering-firmware). In case a revision is added for a so far unknown service, a new entry will be added to the service table. If in contrary a new revision was added for an already existing service, it will be listed in the *service details* view which can be shown by clicking on the magnifying glass in the rightmost column of the table. That dialogue lists all registered revisions of a service, including their respective architectures. To view all architectures for one of the revisions, simply click the *"+"* symbol in the leftmost column:

![services-revision](/images/services-revisions.png)

The status column indicates whether a particular revision was successfully uploaded to the internal service registry. If multiple revisions of the same service have been uploaded, a global default can be set here as well (similar to firmware management).

Naturally, to remove individual revisions or entire services, use the buttons labeled *"X"*.

### Deploying services
What remains is to assign the services to sensors. In general, if architectures match, services can be freely distributed across connected sensors. However, science suggests that honeypots should blend into their surroundings by attempting to mimic services which are also offered by nearby hosts. A sophisticated selection of services is therefore recommended instead of simply enabling all services everywhere.

Service scheduling can be controlled from the sensor overview. For each registered service, the sensor list will have a column that shows the current status for a particular sensor. The cell's background is color-coded:
* **White**: Service is *not* scheduled nor deployed on that sensor.
* **Blue**: Service is scheduled, deployment is in progress.
* **Green**: Service is scheduled and has been confirmed to be running.
* **Red**: Service is scheduled, but couldn't launch successfully.

By default, the service matrix is read-only. To modify service assignments, click on *Edit services* above the table. For each sensor, checkboxes will appear in the service columns that allow operators to schedule or disable services individually. Keep in mind that - depending on the polling interval and network performance - it will take a while until a service is confirmed running after it has been scheduled. On its next polling interval, the sensor will automatically download the service image from the server's registry, then launch the service in a new container. It takes at least two polling intervals for a scheduled service to appear as *running* (green) in the web interface.

![services-matrix](/images/services-matrix.png)

### Supported services
Consult the [Service Releases](/releases/services/) page for a short overview of available services that have been adapted to HoneySens and can be downloaded right there. Refer to the [service matrix](https://github.com/HoneySens/honeysens/tree/master/sensor/services) within the project repository for further technical details.

[[Top]](#top)
