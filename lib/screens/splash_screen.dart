import 'dart:async';

import 'package:app_invensibles/screens/home_screens.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MedaiaDetailScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 1.0,
              child: Image.asset(
                'assets/images/invensible_splashaScree.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Center(
          //   child: Image.asset(
          //     'assets/images/image-Photoroom.png',
          //     height: 350,
          //     width: 350,
          //   ),
          // ),
        ],
      ),
    );
  }
}
