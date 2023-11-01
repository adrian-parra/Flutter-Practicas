import 'package:flutter/material.dart';
import 'package:practica_16/config.dart';

class TweenScreen extends StatefulWidget {
  const TweenScreen({super.key});

  @override
  State<TweenScreen> createState() => _TweenScreenState();
}

class _TweenScreenState extends State<TweenScreen> {
  double font = 25;

  Tween<double> escalaTween = Tween<double>(begin: 0, end: 1);

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tween'),
        centerTitle: true,
      ),
      body: Center(
        child: TweenAnimationBuilder(
          tween: escalaTween,
          curve: Curves.elasticOut,
          duration: Duration(milliseconds: 1800),
          builder: (BuildContext context, double escala, Widget? hijo) {
            return Transform.scale(
              scale: escala,
              child: hijo,
            );
          },
          child: Container(
            width: 200,
            height: 200,
            color: AppConfig.colorWarning,
            child: Center(
              child: Text(
                'HOLA',
                style:
                    TextStyle(fontSize: font, color: AppConfig.colorSecundario),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
