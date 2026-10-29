import 'package:flutter/material.dart';
import 'screens/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DEVMOB Librairie Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      // On définit l'écran d'inscription comme point de départ
      home: const SignupScreen(),
    );
  }
}
