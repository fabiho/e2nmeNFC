# SwiftUI NFC Prototyp – Standortbasierte Zeiterfassung

Dieser Prototyp wurde im Rahmen einer Bachelorarbeit an der IU Internationale Hochschule in Kooperation mit der e2n GmbH entwickelt. Ziel ist die prototypische Umsetzung einer standortgebundenen Zeiterfassung mit NFC-Technologie in einer mobilen App. 

Die Anwendung zeigt, wie Mitarbeitende ihre Arbeitszeit über ein NFC-Tag starten und beenden können. Dabei werden zentrale Anforderungen aus der Praxis wie Verständlichkeit, Benutzerfreundlichkeit und Akzeptanz berücksichtigt. 

---

## Features

- **Arbeitszeit beginnen**  
  - Start über Button *„Arbeitszeit erfassen“*  
  - NFC-Scan als Authentifizierung  
  - Success-Meldung und Bestätigungsdialog mit Timer  

- **Arbeitszeit beenden**  
  - Anzeige der aktuellen Dauer der Arbeitszeit auf dem Button  
  - NFC-Scan als Bestätigung  
  - Success-Meldung und Dialog mit Timer zur Beendigung  

- **MVVM-Architektur**  
  - Klare Trennung von Datenmodell, Logik und UI  
  - State-Management mit SwiftUI  

- **NFC-Integration**  
  - NFC-Scan (NDEF) via CoreNFC  
  - Authentifizierung im Prototyp über UUID-Whitelist + statisches Secret  
  - Optionales Deep-Link-Öffnen per URL und UUID + Secret  

---

## Screenshots

*Screenshots der App einfügen (z. B. Startscreen, NFC-Scan, Dialoge, Timer).*  

---

## Demo-Video

[▶️ In der App](https://github.com/fabiho/e2nmeNFC/blob/main/NFCinApp.MP4)
[▶️ DeepLink](https://github.com/fabiho/e2nmeNFC/blob/main/NFCdeeplink.MP4)
[▶️ Not Authorised](https://github.com/fabiho/e2nmeNFC/blob/main/NFCnotAuthorised.MP4)


---

## Architektur

Die App basiert auf dem **Model-View-ViewModel (MVVM)** Architekturmuster:  

- **Model:** Später für die Verwaltung der Arbeitszeitdaten und Stempelungen  
- **ViewModel:** Business-Logik, State-Management, NFC-Handling  
- **View:** Darstellung der Benutzeroberfläche mit SwiftUI  

---

## Installation

1. Repository klonen  
   ```bash
   git clone https://github.com/<USERNAME>/<REPOSITORY>.git
   cd <REPOSITORY>

2. Projekt in Xcode öffnen:  
   open e2nmeNFC.xcodeproj

5. App auf Simulator oder physischem iPhone starten  
   *(Hinweis: NFC-Scan ist nur auf physischen Geräten verfügbar)*

---

## Anforderungen

- Xcode 15 oder höher
- iOS 17 oder höher
- Physisches iPhone mit NFC-Unterstützung
- NFC-Tags

---

## Lizenz

Dieses Projekt ist ausschließlich zu Demonstrationszwecken im Rahmen einer Bachelorarbeit entstanden. Eine kommerzielle Nutzung ist nicht vorgesehen.
