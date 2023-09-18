import 'package:flutter/material.dart';
import 'package:mini_proyecto_01/widgets/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'Practica 04',
      home: SplashScreen());
  }
}