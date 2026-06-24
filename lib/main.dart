import 'package:app_invensibles/screens/home_screens.dart';
import 'package:app_invensibles/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'INVINCIBLE',
      // home: SafeArea(child: MedaiaDetailScreen()),
      home: SafeArea(child: SplashScreen()),
    );
  }
}
