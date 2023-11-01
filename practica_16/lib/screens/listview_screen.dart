import 'package:flutter/material.dart';
import 'package:practica_16/screens/animated_screen.dart';
import 'package:practica_16/screens/tween_screen.dart';

class ListViewScreen extends StatelessWidget {
  const ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practica 16 - Animaciones'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Animated'),
            trailing: const Icon(Icons.arrow_right),
            onTap: (){
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => const AnimatedScreen()));
            },
          ),
          ListTile(
            title: const Text('Tween'),
            trailing: const Icon(Icons.arrow_right),
            onTap: (){
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => const TweenScreen()));
            },
          )
        ],
      ),
    );
  }
}