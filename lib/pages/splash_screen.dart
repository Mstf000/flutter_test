import 'package:flutter/material.dart';
import 'dart:async';
import 'package:chat_app/pages/auth_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500), // Increased speed of animation
      vsync: this,
      lowerBound: 0.7,
      upperBound: 1.0,
    )..repeat(reverse: true); // Continuous breathing effect

    _animation = CurvedAnimation(parent: _controller!, curve: Curves.easeInOut);

    // Timer to navigate to the AuthPage after 5 seconds
    Timer(Duration(seconds: 7), navigateToHomePage);
  }

  void navigateToHomePage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => AuthPage()));
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF649173), Color(0xFFDBD5A4)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeTransition(
                  opacity: _animation!,
                  child: Text(
                    'BraveSpeak',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                ScaleTransition(
                  scale: _animation!,
                  child: Text(
                    'AR',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontFamily: 'LuckiestGuy', // Ensure the font is added to your pubspec.yaml
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Image.asset('images/logo-no-background.png', height: 30), // Smaller logo at the bottom
            ),
          ],
        ),
      ),
    );
  }
}
