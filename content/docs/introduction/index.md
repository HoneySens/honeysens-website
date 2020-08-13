---
title: 'Introduction'
date: 2020-08-13
weight: 1
---

Traditional defenses in IT security try to detect and mitigate threats as fast and efficient as possible in an attempt to reduce damage to infrastructure, assets and confidential data. Anti-virus software and Intrusion Detection Systems are widespread examples for that. However, there exists another and - at the first look - quite contrary approach: deception. Instead of combating potential intruders with full force, one could try to lure them into attacking seemingly vulnerable systems that are in fact heavily monitored and may give away the intentions and practices of an attacker. Such systems are simply called *honeypots* in remembrance of bears that are typically drawn to honey. 

As a logical conclusion, honeypots aren't meant to be operated as an all-embracing security solution. However, they are a valuable tool that can be installed as an addition to existing security tools (such as firewalls or intrusion detection systems). The operation of honeypots in production network has proven their value as early-warning systems which are able to report suspicious network behavior or even zero-day attacks that are yet unknown to signature-based threat detection solutions.

HoneySens aims to minimize the management overhead that is necessarily introduced when operating honeypots. For that, we deploy established and freely available open source honeypots on so-called *sensors*, which are meant to be distributed throughout our network. Each sensor has an internal IP address of whatever production-grade network he's installed in and offers a selection of honeypot services to potential attackers. Suspicious activity is then reported upstream to a central HoneySens server, which is also the sole interaction point for operators to manage their honeypot network and evaluate the incidents.

![Concept](/images/concept.svg)

As can be seen in the graphic, sensors are our first-class citizens: They are deployed throughout a network and host a selection of [low-interaction](https://en.wikipedia.org/wiki/Honeypot_(computing)) honeypot services such as *cowrie* (fake SSH) and *dionaea* (fake SMB). While it is possible to expose those sensors to the internet via public IP addresses (or forward such traffic to them), this typically just overloads operators with thousands of mostly irrelevant alerts. After all, it's well known that public IP addresses are subject to constant abuse. Instead, our intention for sensors is to be positioned deeply within production infrastructure, such as in firewalled office or server networks. The dangers lingering there, such as virulent malware introduced via E-Mail attachments and USB sticks or even insider threats, are often outside the detection capabilities of intrusion detection systems that only monitor traffic directed toward the Internet.

If you're interested, give HoneySens a try by taking the [tour](/docs/tour) or head over to the [preparation](/docs/preparation) chapter which explains the system architecture and installation requirements in further detail.

[[Top]](#top)
