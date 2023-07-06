# Embedded Dustbin Control System

This repository contains the source code and documentation for an embedded systems project that enables remote control of a dustbin using a Flutter app and an ESP32 microcontroller. The system utilizes a servo motor (MG996r) to control the movement of the dustbin lid. The ESP32 establishes a WebSocket connection with the Flutter app, allowing seamless communication between the two.

## Hardware Components

- ESP32 microcontroller: The ESP32 acts as the central controller for the system. It is responsible for receiving commands from the Flutter app and controlling the servo motor accordingly. Additionally, it indicates the state of the dustbin through an LED connected to it.
- Servo Motor (MG996r): The servo motor is connected to the dustbin lid and enables controlled opening and closing of the lid. It receives commands from the ESP32 to adjust its position accordingly.
- LED Indicator: An LED is connected to the ESP32 and serves as an indicator for the state of the dustbin. The LED blinks at different rates to represent different states, providing visual feedback to the user.

## Flutter App

The Flutter app is designed to provide a user-friendly interface for remotely controlling the dustbin. It establishes a WebSocket connection with the ESP32 to send commands for opening and closing the lid. The app also receives updates from the ESP32 about the current state of the dustbin.

To run the Flutter app, follow these steps:

1. Clone the repository: `git clone https://github.com/thew0205/embedded-dustbin.git`
2. Navigate to the `app` directory: `cd embedded-dustbin/app`
3. Install the dependencies: `flutter pub get`
4. Connect your device or start an emulator.
5. Launch the app: `flutter run`

Make sure to update the WebSocket connection details in the app code (`lib/main.dart`) to match the ESP32's IP address and port.

## ESP32 Firmware

The ESP32 firmware is responsible for controlling the servo motor and establishing a WebSocket server for communication with the Flutter app. It uses the Arduino framework for ESP32 development.

To flash the ESP32 firmware, follow these steps:

1. Clone the repository: `git clone https://github.com/your-username/embedded-dustbin.git`
2. Open the `esp32` directory in the Arduino IDE or your preferred ESP32 development environment.
3. Connect your ESP32 board to your computer via USB.
4. Select the appropriate board and port in the Arduino IDE.
5. Compile and upload the sketch to the ESP32 board.

Ensure that you have the necessary libraries installed for ESP32 development. The required libraries are specified in the sketch's dependencies.

## Dustbin Modification

The dustbin is modified to accommodate the servo motor for lid control. The servo motor is connected to the lid using appropriate linkages or mechanical components. When the servo motor receives commands from the ESP32, it adjusts its position, thereby opening or closing the lid of the dustbin.

Ensure that the dustbin modification is done carefully and securely to ensure proper functioning and safety.

## Contributing

Contributions to this project are welcome. If you find any issues or have improvements to suggest, please feel free to open an issue or submit a pull request. Be sure to follow the existing code style and conventions when contributing.

## License

This project is licensed under the [MIT License](LICENSE). You are free to modify, distribute, and use the code in accordance with the terms of the license. See the [LICENSE](LICENSE) file for more details.

## Acknowledgments

We would like to thank the open-source community for their contributions and support in building this project. Special thanks to the creators and maintainers of the Flutter framework, ESP32 Arduino library, and