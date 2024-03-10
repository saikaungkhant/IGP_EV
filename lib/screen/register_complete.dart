import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'home_map.dart'; // Assuming you have a home_page.dart file with a HomePage widget

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration Complete',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const RegistrationCompleteScreen(),
      debugShowCheckedModeBanner: false, // to remove the debug banner
    );
  }
}

class RegistrationCompleteScreen extends StatelessWidget {
  const RegistrationCompleteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color(0xFFB3C5C8);
    const Color buttonColor = Color(0xFF29353C);

    return Scaffold(
      body: Container(
        color: backgroundColor, // Your preferred background color
        width: double.infinity, // Ensure the container fills the width of the screen
        height: double.infinity, // Ensure the container fills the height of the screen
        padding: const EdgeInsets.all(30.0), // Your desired padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Icon(
              Icons.check_circle_outline,
              size: 120.0,
              color: Colors.green, // Icon color from theme
            ),
            const SizedBox(height: 24.0),
            const Text(
              'User Registration Complete',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Please proceed to your Car Registration',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: buttonColor, // Button background color
                onPrimary: Colors.white, // Button text color
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // TODO: Implement car registration logic
              },
              child: const Text(
                'Register Your Car',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 30.0),
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'Proceed to ',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontFamily: 'Roboto', // Replace with your desired font family
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Home Page',
                      style: TextStyle(
                        color: Colors.blue[700],
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HomeMap()),
                                (Route<dynamic> route) => false,
                          );
                        },

                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
