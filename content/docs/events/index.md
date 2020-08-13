---
title: 'Events and Filters'
date: 2020-08-13
weight: 7
---

In its primary role HoneySens sensors act as an early-warning system that provide fake *honeypot services* to attract and report potential network-based attacks, called *events*. This document will show how collected events can be examined and how the event list can be kept clean by filtering out false positives.

At this point, we assume a working HoneySens installation with a server and at least one sensor connected to it. For further details, please refer to [Installation](/docs/installation) and [Sensor Deployment](/docs/sensors).

### Examining events
Sensor by themselves won't generate any potential security events. Instead, evaluating and responding to network traffic is the responsibility of [*services*](/docs/services) that can be deployed to sensors. Most of these services act as honeypots, which practically means they emulate various network services that could be potential targets for malware or intruders. It's up to the service implementation what gets reported as an event to the server: Some services thoroughly report every single network connection made to them, while others first classify connections and only alert in case they witness an actual attack.Since services are largely adaptions of Open Source honeypots, the actual behavior might vary from one service to another. That's why HoneySens events should always be taken with a grain of salt: After all, it's just an early-warning system that can indicate that something fishy might be going on, but can't guarantee that. Due diligence is key.

To have a look at reported events, switch to the *Events* section in the sidebar. An extensive list with all events that have been collected so far will be shown, with the newest event at the top:

![events-list](/images/events-list.png)

Each row represents a single event that was reported to the server by a service running on one of the attached sensors. The columns should be mostly self-explanatory:
* **ID**: Internal event ID
* **Timestamp**: Date and time of the specific event. In the case of a lengthy network connection, this date specifies the arrival time of the very first packet at the sensor.
* **Sensor**: The sensor that recorded the event.
* **Classification**: The classification determines the color of an event row and comprises three possible values: *Connection attempt*, *Portscan* and *Honeypot*. It's up to the service implementation how a specific event will be classified. Currently, the *recon* service reports connection attempts and portscans, while all other services are reported as honeypot alert.
* **Source**: IP address of the event's source (the potential attacker).
* **Details**: A brief event summary, heavily depends on the service that reports an event. The number in parentheses indicates the number of detailed records available for the event. Those can be shown by clicking on the *"Show details"* button (see below).
* **Status**: This flag can be used by operators to indicate that an event is currently under investigation or can be ignored. Also includes a comment field that can be freely utilized to record additional information about a particular incident. This column is just a support utility to annotate events with additional data, it has no functional value beyond that.
* **Actions**: One button shows detailed information about an event, the other one removes an event from the database (be warned: there is no way to restore or archive it).

In addition to the properties shown in the table, each event can have more data attached to it, such as the interaction history with the reporting service. That data can be shown by with a click on the *"Show details"* button. In that dialogue window, below a short summary of the event properties (taken from the table), a click on *"Sensor interaction"* or *"Packets"* reveals additional data that highly depends on the reporting service:

![events-details](/images/events-details.png)

In the example, we observe an SSH connection reported by the *cowrie* honeypot service from `192.168.3.200`, TCP port `58452`. The attacker logs into the honeypot successfully as `root` with the password `test` and issues two commands to the fake shell offered by cowrie to explore basic system properties.

The event list can also be sorted: Just click multiple times on a column header to order the events either ascending or descending by that column's attribute. Furthermore, the list can be filtered and search through with the controls located above the table.

### Filtering out false positives
In addition to the basic filter mechanisms of the event table, it's also possible to register filter rules on the server that drop all incoming events that match a set of rules. The intended purpose is to reduce the amount of "noise" one typically observes when operating honeypots: Even though in theory only suspicious actors inside a network should trigger events, reality has shown that production networks are full of legitimate and legacy services that for various reasons can trigger alerts unintentionally. Specifying rules to filter out such alerts helps with minimizing the mass of incoming events to just relevant ones.

To manage *filters*, click on the respective entry in the sidebar. A list of filter rules will be shown, which can also be filtered according to their respective group assignment. In general, filter rules apply *only* to sensors that are within the same group. To add a new filter, click the *"Add"* button on the top right. Each filter rule has to be assigned to a group and should be given a unique name. The actual conditions that make up a filter rule are then specified in the lower half of the dialogue:

![events-filters-add](/images/events-filters-add.png)

Again with the *"Add"* button, multiple conditions can be attached to the rule. For each condition, one first has to select an attribute that is used for comparison (such as matching on the *source* of an event or its *classification*), followed by individual settings that depend on the attribute. In the example, we specified that all *port scan* events coming from IP address `192.168.3.5` should be matched. An event will be discarded by the server only if **all** conditions match. Click *"Save"* to register a rule on the server and return to the previous view.

To verify a filter rule, again have a look at the filter list:

![events-filters-list](/images/events-filters-list.png)

Each time the server encounters and discards an event that matches one of the filter rules, the value in the *counter* column will be increased by one. That way operators can quickly assert that their rules are effective.

### Event notifications
Constantly watching the event list for new incidents - even though it automatically updates itself - would be a rather time-consuming and unpopular task. As an alternative, the HoneySens server can send out push notifications via E-Mail in case new events appear. To activate that feature, switch to the *"System"* page in the sidebar, click on *"E-Mail Notifications"* and specify the SMTP server and credentials that are necessary to automatically send E-Mails. There's also a button that enables you to send a test mail to verify the SMTP configuration. If that works, click on *"Deactivated"* in the top right of the configuration panel to enable the configuration:

![events-notification](/images/events-notification.png)

As a last step, at least one receiver for E-Mail notifications is required. Similarly to filter rules, for each group you can define one or more *contacts* that should receive notifications from the group's sensors. Switch to the *"Users and Groups"* module in the sidebar and edit the group in question. In the lower part of the form, new contacts can be added with the *"Add"* button. Each contact can either be one of the users registered on the server (which have an E-Mail address attached to them) or just any E-Mail address (to notify external contacts). In addition to that, for each contact you can decide whether they should receive push notifications about all events, just *critical* ones (those are by definition events classified as *"Honeypot"*) or weekly summaries (these are sent every Monday):

![events-notification-contacts](/images/events-notification-contacts.png)


[[Top]](#top)
