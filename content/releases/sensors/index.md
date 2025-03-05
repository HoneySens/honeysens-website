---
title: 'Sensors'
date: 2025-03-04
weight: 2
---

Sensor firmware archives can be downloaded here, used for initial sensor deployment and registered with a deployed HoneySens server to automatically update all attached sensors.

<!--more-->
| Platform | Download                                                              | SHA1 checksum                             |
|:---------|:----------------------------------------------------------------------|:------------------------------------------|
| BeagleBone Black | [2.6.0](https://github.com/HoneySens/honeysens/releases/download/2.8.0/HoneySens-Firmware-BBB-4gb-2.6.0.tar.gz) | `8c1f6100cef50f8b46b54a0e7f24157eb3cf2b21` |
| Docker | [2.6.0](https://github.com/HoneySens/honeysens/releases/download/2.8.0/HoneySens-Firmware-dockerx86-2.6.0.tar.gz) | `4f83ba2228749d910619eca3424f4fee8c418628` |

Refer to the [sensor deployment](/docs/sensors/) documentation for instructions on how to deal with downloaded firmware files.

### Changelog
###### 2.6.0
Released in May 2023
* Base system updated

###### 2.5.0
Released in May 2022
* TLS authentication removed

###### 2.4.0
Released in April 2022
* HMAC authentication and custom DHCP hostname support

###### 2.3.0
Released in June 2021
* Fixed rare network address conflicts

###### 2.2.2
Released in October 2020
* Networking fixes

###### 2.2.1
Released in October 2020
* Enforcement of HTTP/1.1 communication

###### 2.2.0
Released in August 2020
* Networking fixes

###### 2.0.0
Released in May 2019
* Support for event caching, an adjustable service network range, new LED notification modes and USB auditing

###### 1.0.5
* Fixed a bug that prevented service downloads through proxies

###### 1.0.4
Released in March 2019
* Fixed a bug that prevented service download through proxies

###### 1.0.3
Released in February 2019
* Support for remote sensor certificate updates

###### 1.0.2
Released in January 2019
* Static DNS servers are now properly recognized; Local USB dnsmasq disabled to close port 53

###### 1.0.1
* NTLM proxy support via cntlm and disk usage reporting added. Requires server 1.0.0

###### 1.0.0
* Rebuilt image based on Debian 9 for compatibility with HoneySens Server 1.0.x

[[Top]](#top)