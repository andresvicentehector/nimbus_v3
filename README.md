NIMBUS
Nimbus is a Flutter coded app that controls LED lights by sending an array to an ESP32 microcontroller. This app provides an easy-to-use interface to switch ON/OFF and adjust the color and brightness of the LED lights.

Requirements
To use this app, you will need the following components:

ESP32 microcontroller
LED lights
Breadboard
Jumper wires
Installation
Clone the repository to your local machine.

Open the project in your preferred IDE.

Connect your ESP32 microcontroller to your computer via USB cable.

Install the necessary dependencies by running the following command:

csharp
Copy code
flutter pub get
Connect the LED lights to your ESP32 microcontroller according to the schematic provided in the project.

Compile and upload the code provided in the ESP32_Code folder to your ESP32 microcontroller.

Run the app on your device by running the following command:

flutter run
Usage
Open the app and connect to the ESP32 microcontroller.

Turn the LED lights on or off by tapping the power button.

Adjust the brightness and color of the LED lights by moving the corresponding sliders.

Press the save button to save the current settings.

Press the reset button to reset the LED lights to their default settings.

Contributing
Contributions are welcome! Please feel free to submit a pull request.

License
This project is licensed under the MIT License. See the LICENSE file for details.




