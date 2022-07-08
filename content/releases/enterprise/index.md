---
title: 'Enterprise Edition'
date: 2020-08-13
weight: 1
---

The commercial edition is available from [T-Systems Multimedia Solutions](https://www.honeysens.de/).

### Changelog

###### 2.5.0
Released in May 2022
* Unprivilegierte Server-Container für den sicheren Betrieb als orchestrierter Microservice
* TLS-Client-Authentifizierung für Sensoren entfernt und durch HMAC als Standardverfahren ersetzt
* Unterstützung für TLS 1.3

###### 2.4.0
Released in April 2022
* **Brücken-Release**: Mindestvoraussetzung für Updates auf spätere Revisionen
* Ereignisarchiv für die Langzeitaufbewahrung von Ereignisdaten
* Individualisierbare E-Mail-Templates für alle automatisch versandten Systemnachrichten
* Ereignisfilter können nun gezielt aktiviert/deaktiviert werden
* Visualisierung neu eintreffender Ereignisse mittels Zähler in der Sidebar
* Status-Filter der Ereignisliste um häufig benötigte Kombinationen erweitert
* Spalte mit Gruppenzuordnung zur Ereignis-, Filter- und Sensor-Übersichten hinzugefügt
* Übersichts-Statusanzeige in Dienste-Verzeichnis integriert
* Der zum DHCP-Server gesendete Hostname ist nun optional und frei wählbar
* Dialoge überarbeitet, bspw. listet der "Firmware Entfernen"-Dialog jetzt betroffene Sensoren auf, die nicht den Systemstandard nutzen
* E-Mail-Benachrichtigungen über Verbindungsversuch-Ereignisse beinhalten nun eine Paketübersicht
* Passwortänderung bei nächstem oder erstmaligen Login erzwingbar
* Administrative E-Mail-Adresse als Pflichtfeld für Neuinstallationen eingefügt
* Prozess zum Einbinden eigener TLS-Zertifikate für die Kompatibilität mit alternativen Container-Runtimes überarbeitet
* Fehlerkorrekturen in Front- und Backend, speziell in den Bereichen Session-Handling, Caching und serverseitive Validierung
* Sensor-Authentifikation via HMAC

###### 2.3.0
Released in June 2021
* Serverseitiges Tracking des Sensor-Zustands, Darstellung von Up-/Downtime entsprechend angepasst
* Ereignisbenachrichtigungen um Notifikationen bei Sensor-Timeouts und CA-Zertifikatsablauf erweitert
* Ereignisliste um Status-Filter und Zähler für neue Ereignisse (pro Sensor) ergänzt
* Funktionen zum simultanen Bearbeiten und Entfernen aller Ereignisse der Ereignisliste
* Optional aktivierbares API-Aktitätslog für Administratoren
* Beschreibungs-Freitextfeld für Whitelist-Einträge hinzugefügt
* Sonderbrechtigungen um zusätzliche Pflichtfelder erweitert
* Fehlerkorrekturen im Front- und Backend, insbesondere im Zusammenhang mit Privilegien und Filterkriterien

###### 2.2.0 
Released in August 2020
* Umfassendes und bei Bedarf vollautomatisches Backupkonzept integriert
* Unterstützung von EAPOL/IEEE802.1X-Authentifizierung für Sensoren (Beta-Status)
* Unterstützung der automatischen Ereignisweiterleitung an externe Syslog-Server implementiert
* Ereignisbearbeitung in separaten Dialog ausgelagert
* Komponentenaufteilung überarbeitet: Datenbank, Hintergrundprozesse und Backups separiert
* Zahlreiche Härtungsmaßnahmen innerhalb der Webanwendung umgesetzt

###### 2.1.0 
Released in August 2019
* Ereignisse können im CSV-Format exportiert werden
* Nutzerauthentifikation über einen externen LDAP-Verzeichnisdienst ist nun möglich
* Prozessverwaltung zur Visualisierung von Hintergrundprozessen fü Benutzer integriert
* Hashverfahren für Nutzerpasswörter aktualisiert
* Manuelles Aktualisieren der Konfiguration nach Updates ist nicht mehr notwendig
* Sidebar kann nun auf Wunsch dauerhaft ausgeklappt werden
* Option zur Restriktion von Benutzerrollen hinzugefügt
* Verhalten zahlreicher Formulare im Web-Frontend vereinheitlich

###### 2.0.0
Released in May 2019
* Zusätzliche Such-, Filter und Sortierfunktionen für die Ereignisübersicht
* Interner Netzbereich für Honeypot-Services ist nun frei definierbar
* Überarbeitung der clientseitigen Formularvalidierung
* Status von Diensten wird nun in der Sensorübersicht dargestellt
* Wartungs-Kurzdoku ist nun Teil der Server-Distribution
* Firmware-Release-Notes im Frontend hinterlegt
* Unzählige Fehlerkorrekturen in Front- und Backend

###### 1.0.4
Released in March 2019
* Dienste-Refkonfiguration in der Sensorübersicht ist jetzt global sperrbar
* Fehlerkorrektur im Zusammenhang mit dem automatischen Mailversand

###### 1.0.3
Released in February 2019
* Anpassung des Impressums

###### 1.0.2
Released in January 2019
* Verfahren zur Verlängerung der Zertifikatinfrastruktur hinzugefügt
* Mail-Konfiguration erlaubt nun die freie Bestimmung des zu nutzenden SMTP-Ports
* Impressum und Datenschutzerklärung eingebunden
* Dokumentation aktualisiert

###### 1.0.1
* Umstellung der Zertifikate auf SHA-256
* Erweiterung der Ansicht für Beobachter um Ereigniskommentare und Sensorkonfiguration
* verschiedene Darstellungsfehler im Frontend sowie mehrere kleinere Fehler behoben

###### 1.0.0
* Unterstützung für Orchestrierungsdienste, unzählige Bugfixes und Detailverbesserungen

###### 0.9.0
* Umsetzung der Multi-Plattform- und Multi-Service-Konzepte
