---
title: 'Services'
date: 2025-03-04
weight: 3
---

Honeypot services that simulate network services and detect conspicuous behavior can be downloaded from here.

<!--more-->
Each service is available for two different architectures: *amd64* for dockerized and *armhf* for BeagleBone Black sensors. To verify downloads, please always review their [SHA1 checksums](/download/releases/sha1sums).

| Name | Description                                                                                           | Download                                                                                                                       |
|:-----|:------------------------------------------------------------------------------------------------------|:-------------------------------------------------------------------------------------------------------------------------------|
| Conpot | ICS/SCADA honeypot, configured to simulate a Siemens web dashboard                                    | [amd64-2.3.0](/download/releases/HoneySens-conpot-amd64-2.3.0.tar.gz) [armhf-2.3.0](/download/releases/HoneySens-conpot-armhf-2.3.0.tar.gz)       |
| Cowrie | SSH server designed to log brute-force attacks and offer a pseudo-interactive shell to attackers      | [amd64-2.6.0](/download/releases/HoneySens-cowrie-amd64-2.6.0.tar.gz) [armhf-2.6.0](/download/releases/HoneySens-cowrie-armhf-2.6.0.tar.gz)       |
| Dionaea | SMB server that recognizes various exploitable CVEs                                                   | [amd64-2.7.0](/download/releases/HoneySens-dionaea-amd64-2.7.0.tar.gz) [armhf-2.7.0](/download/releases/HoneySens-dionaea-armhf-2.7.0.tar.gz)     |
| Glastopf | Simple HTTP server that lures attackers with randomly generated sites full of exploitable keywords    | [amd64-2.7.0](/download/releases/HoneySens-glastopf-amd64-2.7.0.tar.gz) [armhf-2.7.0](/download/releases/HoneySens-glastopf-armhf-2.7.0.tar.gz)   |
| Heralding | Multi-protocol credentials catching honeypot server                                                   | [amd64-2.3.0](/download/releases/HoneySens-Heralding-amd64-2.3.0.tar.gz) [armhf-2.3.0](/download/releases/HoneySens-Heralding-armhf-2.3.0.tar.gz) |
| miniprint | Honeypot that acts like a network printer                                                             | [amd64-2.3.0](/download/releases/HoneySens-miniprint-amd64-2.3.0.tar.gz) [armhf-2.3.0](/download/releases/HoneySens-miniprint-armhf-2.3.0.tar.gz) |
| RDPy | RDP server, configured to show a Windows Server login prompt                                          | [amd64-2.2.0](/download/releases/HoneySens-RDPy-amd64-2.2.0.tar.gz) [armhf-2.2.0](/download/releases/HoneySens-RDPy-armhf-2.2.0.tar.gz)           |
| Recon | Recon is a small daemon that responds to and logs any incoming TCP or UDP request on arbitrary ports. | [amd64-2.2.0](/download/releases/HoneySens-recon-amd64-2.2.0.tar.gz) [armhf-2.2.0](/download/releases/HoneySens-recon-armhf-2.2.0.tar.gz)         |

Refer to our [service matrix](https://github.com/HoneySens/honeysens/tree/master/sensor/services) for further technical details.