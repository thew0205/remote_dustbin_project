# 🗑️ Embedded Dustbin Control System

Remotely open and close a dustbin lid using a **Flutter mobile app** and an **ESP32 microcontroller** over **WebSocket**. The project combines embedded firmware, real-time communication, and mobile development to create a practical, IoT-enabled waste management system.

---

## 🎥 Project Demo

https://github.com/thew0205/remote_dustbin_project/1688755511331.mp4

<details>
<summary>Can't view the embedded video? Download it <a href="./1688755511331.mp4">here</a>.</summary>
</details>

---

## 📦 Features

- 🚀 Wireless control of dustbin lid
- 🔗 Real-time communication via WebSocket
- ⚙️ Servo-based lid movement
- 💡 LED feedback for system state
- 📱 Clean and simple Flutter mobile interface

---

## 🔧 Hardware Components

| Component         | Description                                               |
|------------------|-----------------------------------------------------------|
| **ESP32**         | Central controller handling WebSocket + motor control     |
| **MG996R Servo**  | Rotates the dustbin lid based on remote commands          |
| **LED**           | Blinks to indicate system state (e.g., connection status) |
| **Modified Bin**  | Physically adapted to mount and link the servo motor      |

---

## 📱 Flutter App

The Flutter app provides the interface to control the dustbin wirelessly.

### 🚀 How to Run

```bash
git clone https://github.com/thew0205/remote_dustbin_project.git
cd remote_dustbin_project/dustbin_app_flutter
flutter pub get
flutter run
