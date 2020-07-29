---
title: 'Sensor Deployment'
date: 2019-02-24T19:27:37+10:00
weight: 5
---

This document describes the deployment of both dockerized and "physical" sensors. We assume that the [server instance](/docs/installation-server) was set up beforehand and is running properly. Deploying new sensors generally involves the following steps, which will be explained more thoroughly in the following chapters:
1. Upload firmware to the server (in case that specific firmware revision hasn't been registred yet): This enables the server to distribute new firmware as update to already attached sensors.
2. Using the web interface, configure a new sensor and obtain the automatically generated sensor configuration archive.
3. Perform sensor installation on site (platform-specific).

### Registering Firmware
As preparation for deployment of new sensors, we first have to upload appropriate firmware to the server. This step is required so that already attached sensors can obtain firmware updates directly from the server, enabling transparent remote updates. In HoneySens terminology, *"firmware"* refers to a software package that contains all necessary components to run a sensor, usually targeting a specific platform. Currently, HoneySens supports two such platforms:
* **Docker**: *Dockerized* sensors are provided as Docker images which contain all required dependencies and software components to spawn new sensors on most hardware platforms.
* **BeagleBone Black**: Shortened as *BBB*, these low-cost [development boards](https://beagleboard.org/black) are our representation for "hardware" sensors which can be preconfigured and distributed to any site that wants to include sensors into their networks. They have proven quite reliable and due to remote management capabilities via the HoneySens server can simply be forgotten after initial installation.

Regardless of the chosen platform, HoneySens sensor software is built to execute full remote system updates without the need to touch sensors on the spot. That capability is essential when managing a fleet of sensors distributed across different buildings or even company sites.

Firmware for the different platforms can be obtained as tarball from the [Releases](/releases/ce) page. Each archive primarily contains the actual firmware package, which precise format is dependent on the specific platform. In addition, each archive also contains some XML metadata (`metadata.xml`) and further platform-specific files such as a Compose file in the case of dockerized sensors.

**Note**: The following steps are only required once per firmware revision. If the intended firmware is already registered on the server, you **don't** have to repeat these steps and can move straight on to sensor configuration.

To upload new firmware to the server, log in to the HoneySens web interface and select *Platforms* in the sidebar on the left. This will list all currently supported platforms accompanied by the specific revisions already registered on the server (those can be shown with a click on the magnifying glass on the right side). A newly installed server will still list all platforms, but doesn't come with firmware preinstalled. To initiate the upload of a new archive, click the *"Upload Firmware*" button on the top right, select the firmware archive as downloaded from the [Release](/releases/ce) page (it's not necessary to unpack it)  and follow the on-screen instructions. Successful firmware upload and verification results in the following screen:

![sensor-firmware-upload](/images/sensor-firmware-upload.png)

Afterwards, the new firmware revision will appear as a new entry in the details for that specific platform (magnifying glass).

### Sensor Configuration


[[Top]](#top)
