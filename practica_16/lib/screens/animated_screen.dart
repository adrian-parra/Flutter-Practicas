import 'package:flutter/material.dart';
import 'package:practica_16/config.dart';


class AnimatedScreen extends StatefulWidget {
  const AnimatedScreen({super.key});

  @override
  State<AnimatedScreen> createState() => _AnimatedScreenState();
}

class _AnimatedScreenState extends State<AnimatedScreen> {
  double height = 150;
  double width = 150;
  double font = 25;

  void updateState(){
    setState(() {
      height = 300;
      width = 300;
      font = 50;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated'),
        centerTitle: true,
      ),
      body: Center(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 900),
          curve: Curves.bounceOut,
          width: width,
          height: height,
          color: AppConfig.colorPrincipal,
          child: Center(
            child: Text(
              'HOLA',
              style: TextStyle(
                fontSize: font,
                color: AppConfig.colorSecundario
              ),
              ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          updateState();
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}