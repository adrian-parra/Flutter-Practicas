import 'package:flutter/material.dart';
import 'package:practica_10/screens/listview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Practica 10',
      debugShowCheckedModeBanner: false,
      home: ListViewScreen(),
    );
  }
}

