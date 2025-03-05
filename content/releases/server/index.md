---
title: 'Server'
date: 2025-03-04
weight: 1
---

A HoneySens server is composed of multiple containerized services. These can be either downloaded here or from a public container registry.

<!--more-->
Latest release: **2.8.0**  
Latest build: **20241218**

New builds are created from time to time to address potential vulnerabilities in 3rd party dependencies. All builds of a single release are identical feature-wise.

Click [here](/download/releases/HoneySens-Server-2.8.0-20241218.tar.gz) (SHA1 `d728f9b144b3efc9187eee82c850bc1fd11fa49d`) to download the server distribution, which contains a Docker Compose file as well as prebuilt project-specific images for deploying a HoneySens server. Follow the [installation docs](/docs/installation/) for further instructions. Some additional third party dependencies such as Redis or MySQL are not contained in this archive and will be downloaded from a public container registry automatically upon initiating the deployment.

Alternatively, all images can be obtained automatically from public container registries. To go that route, download our [docker-compose.yml](/download/releases/docker-compose.yml) and follow the *Configuration* and *Startup* steps in the [installation docs](/docs/installation/#configuration).

### Changelog
###### 2.8.0
Released in December 2024
* Backend migration to PHP8
* Revision of all API authorization checks

###### 2.7.0
Released in January 2024
* Rudimentary system load monitoring to address issues during high utilization
* Distribution of e-mail notifications in case of high system load
* Improved performance when retrieving event data
* Fixed various permission-related bugs
* Fixed issues related to the renewal of self-signed TLS certificates

###### 2.6.1
Released in May 2023
* Added configuration option to limit the number of task worker processes

###### 2.6.0
Released in December 2022
* Added sensor configuration download to sensor overview
* Automatic detection of expired user sessions or loss of connection to the server
* Revised optional permission restrictions for the Manager role
* Added group membership info and e-mail addresses to user details
* Numerous UI bug fixes, specifically for the presentation of tooltips and service labels

###### 2.5.0
Released in May 2022
* Unprivileged server containers for secure operation as an orchestrated microservice
* Removed TLS client authentication for sensors - replaced by HMAC as default
* Support for TLS 1.3

###### 2.4.0
Released in April 2022
* **Bridge Release**: Base requirement for updates to later revisions
* Event archive for the long-term storage of event data
* Customizable e-mail templates for automatically distributed system messages
* Event filters can now be activated/deactivated
* Visualization of new incoming events by means of a counter in the sidebar
* Extended event list status filter to include frequently required status combinations
* Added column with group assignment to the event, filter and sensor overviews
* Integrated status display in services overview
* The host name sent to the DHCP server is now optional and freely selectable
* Dialogs revised, e.g. the 'Remove firmware' dialog now lists affected sensors that do not run the global standard firmware
* E-mail notifications about connection attempt events now include a package overview
* Password change enforceable at next or first login
* Added administrative e-mail address as mandatory field for new deployment
* Process for integrating own TLS certificates revised for compatibility with alternative container runtimes
* Bugfixes in frontend and backend, specifically in the areas of session handling, caching and server-side validation
* Sensor authentication via HMAC

###### 2.3.0
Released in June 2021
* Server-side sensor status tracking; up/downtime status display adapted accordingly
* Event notifications extended to include notifications for sensor timeouts and CA certificate expirations
* Event list supplemented with status filter and counter for new events (per sensor)
* Added functions for simultaneously editing and removing all events in the event list
* Optional API activity log for administrators
* Added description field for whitelist entries
* Special permissions extended with additional mandatory fields
* Error corrections in frontend and backend, especially in relation to privileges and event filters

###### 2.2.0
Released in August 2020
* Integrated comprehensive fully automated backup system
* Support for EAPOL/IEEE802.1X authentication for sensors (beta status)
* Implemented support for automatic event forwarding to external syslog servers
* Moved event processing to a separate dialog
* Component division revised: Database, background processes and backups separated
* Implemented numerous hardening measures within the web application

###### 2.1.0
Released in August 2019
* Events can be exported in CSV format
* Support user authentication via an external LDAP directory service
* Integrated process management for visualization of user background processes
* Updated hashing method for user passwords
* Manual configuration update after system updates is no longer necessary
* Sidebar can now be permanently collapsed
* Added options to restrict user roles
* Standardized behavior of numerous web frontend forms

###### 2.0.0
Released in May 2019
* Additional search, filter and sort functions in the event overview
* Internal network range for honeypot services is now freely definable
* Client-side form validation revised
* Status of services is now shown in the sensor overview
* Short maintenance documentation integrated into the server distribution archive
* Firmware release notes added to the frontend
* Countless bug fixes in the frontend and backend

###### 1.0.4
Released in March 2019
* Services reconfiguration in the sensor overview can now be locked
* Automatic e-mail dispatch bugfixes

###### 1.0.3
Released in February 2019
* Imprint adjustments

###### 1.0.2
Released in January 2019
* Added procedure for renewing the certificate infrastructure
* Mail configuration now allows free determination of the SMTP port to use
* Integrated imprint and privacy policy
* Documentation updated

###### 1.0.1
* Conversion of certificates to use SHA-256
* Observer UI expanded to include event comments and sensor configuration
* Fixed various display errors in the frontend and several minor bugs

###### 1.0.0
* Support for orchestration services, countless bug fixes and detail improvements

###### 0.9.0
* Implementation of multi-platform and multi-service concepts

[[Top]](#top)