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

<p align="center">
  <img width="30%" src="https://github.com/user-attachments/assets/8871c302-5890-4aaa-a74a-0a0d8ca9902a" />
  <img width="30%" src="https://github.com/user-attachments/assets/6cabc3a6-e6b1-4b24-9d1e-b43cdad83a7c" />
  <img width="30%" src="https://github.com/user-attachments/assets/8eed9d29-b1fe-4018-8790-3d87dd1cf420" />
</p>

<p align="center">
  <img width="30%" src="https://github.com/user-attachments/assets/15f784bd-6b85-4805-9dbe-fb514149ca3d" />
  <img width="30%" src="https://github.com/user-attachments/assets/6a4fdcc1-dc24-433d-acf4-6be1dff17491" />
  <img width="30%" src="https://github.com/user-attachments/assets/e732faf3-2c85-45f7-9f04-ae5c9797db21" />
</p>

---


## Demo-Video

- [▶️ In der App](https://github.com/user-attachments/assets/7b0861e4-ed04-4444-9a9f-6713a3a6dd4f)
- [▶️ DeepLink](https://github.com/user-attachments/assets/855c747b-8e89-4b2e-a1ab-868d49dfc72e)
- [▶️ Not Authorised](https://github.com/user-attachments/assets/51e292fe-79f4-46f5-b0a8-242dafa01e13)


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
