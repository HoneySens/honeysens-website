---
title: 'Services'
date: 2019-02-24T19:27:37+10:00
weight: 6
---

A sensor by itself doesn't perform any tasks other than regularly polling the server for configuration updates. To gain value from a sensor, operators have to deploy *services* to add custom functionality. Since HoneySens is all about building and maintaining a deception network, those services typically offer honeypot functionalities. More specifically, they are adaptions of popular OpenSource honeypot projects. HoneySens is essentially the glue that enables operators to seamlessly integrate those honeypots into their network. This documents describes how to manage the service repository on a HoneySens server as well as how to deploy honeypots to sensors. We assume that a [server](/docs/installation) with at least one attached [sensor](/docs/sensors) was set up beforehand.

### The service repository
All services that are to be deployed on sensors have to be registered on the HoneySens server first. The underlying idea is to reduce the administrative overhead for operators that want to launch new honeypots on a sensor to just a few clicks. For that, the server transparently exposes an integrated service repository (that is just an ordinary Docker repository) to its sensors, which in turn can use standardized Docker infrastructure to execute containerized services.

For operators, the service repository can be comfortably managed via the web interface. Just click on the *Services* section in the sidebar to view a list of all currently registered services:

![services-overview](/images/demo-services.png)

The *Service Registry* label in the top left indicates whether the internal registry could be accessed successfully. In case it isn't shown as *"Online"*, there is an issue in the communication between server and registry containers. In that case, please head to the [installation](/docs/installation) guide and check the server configuration.

Similar to firmware, multiple revisions can be uploaded and registered for each service to facilitate a seamless update procedure. In addition to that, each service revisions is built for a specific software architecture. That requirement stems from the different sensor platforms: While containerized Docker sensors typically run on hosts using the `amd64` architecture, physical sensors (via the BeagleBone Black) utilize `armhf`. If sensors for different platforms are attached to a HoneySens server, the operators have to ensure that services for all involved platforms are available there. Otherwise, attempting to deploy services to sensors for which there is no suitable architecture available is doomed to fail.

Going back to the web interface, new service revisions can be added with the *Add* button in the top right. That process is very similar to [adding firmware](/docs/sensors). In case a revision is added for a so far unknown service, a new entry will be added to the service table. If in contrary a new revision was added for an already existing service, it will be visible in the *service details* view which can be shown by clicking on the magnifying glass on the right side of the table. That dialogue lists all registered revisions of the selected service, including their respective architectures. To display all architectures for one of the revisions, simply click the *"+"* symbol in the leftmost column:

![services-revision](/images/services-revisions.png)

The status column indicates whether a particular revision was successfully uploaded to the internal service registry. If you look at this list directly after a new revision has been added, it will take a while until the internal upload process to the registry has been completed. During that time, the status column will show an error message. If multiple revisions were uploaded for one service, a global default can be chosen with here as well (similar to firmware management).

Naturally, to remove individual revisions or entire services, use the buttons labeled *"X"*.

### Deploying services
What remains is to assign the services to sensors. In general, if architectures match, services can be freely distributed across the available sensors. However, science suggests that honeypots should blend into their surroundings by attempting to mimic services which are also offered by nearby hosts. A sophisticated selection of services is therefore recommended instead of simply enabling all services everywhere.

Service scheduling can be controlled from the sensor overview. For each registered service, the sensor list will have a column that shows the current status for a particular sensor. The cell's background is color-coded:
* **White**: Service is *not* scheduled nor deployed on that sensor.
* **Blue**: Service is scheduled, deployment is in progress.
* **Green**: Service is scheduled and has been confirmed to be running.
* **Red**: Service is scheduled, but couldn't launch successfully.

By default, the service matrix is read-only. To modify service assignments, click the *Edit Services* above the table. For each sensor, checkboxes will appear in the service columns that allow operators to schedule or disable services at will. Keep in mind that - depending on the polling interval and network speeds - it will take a while until a service is finally after it has been scheduled. On its next polling interval, the sensor will automatically download the service image from the server's registry, then launch the service in a separate container. It typically takes two polling intervals for a scheduled service to appear as *running* (green) in the web interface.

![services-matrix](/images/services-matrix.png)

### Service list
Currently, the HoneySens Community Edition offers a rather limited selection of services. However, we're actively working on improving the situation and also encourage the community to submit additional services. Consult the table below for an overview over available services that can be downloaded from the CE [releases](/releases/ce) page.

| Name         | Description                                                                                                                                     | Website                                           |
| :----------- | :---------------------------------------------------------------------------------------------------------------------------------------------- | :--------------------------------------------     |
| Recon        | Recon is a small daemon that responds to and logs any incoming TCP or UDP request on arbitrary ports.                                           | (part of the HoneySens project)                   |
| Cowrie       | Cowrie is a medium interaction SSH and Telnet honeypot designed to log brute force attacks and the shell interaction performed by the attacker. | [on GitHub](https://github.com/cowrie/cowrie)     |
| Dionaea      | Dionaea is a low interaction honeypot with support for various protocols, notably SMB.                                                          | [on GitHub](https://github.com/DinoTools/dionaea) |

[[Top]](#top)
