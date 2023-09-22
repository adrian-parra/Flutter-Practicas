import 'package:flutter/material.dart';
import 'package:practica_05/config.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({super.key});

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  double valor = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.colorFondo,
      appBar: AppBar(
        title: const Text('Slider Screen'),
        centerTitle: true,
        backgroundColor: AppConfig.colorPrincipal,
        elevation: 0.0,
      ),
      body: Card(
        elevation: 4,
        margin: const EdgeInsets.all(AppConfig.marginValue),
        child: Column(
          children: [
            Container(
              height: 50,
              width: 400,
              child: Slider(
                value: valor,
                min: 0,
                max: 400,
                activeColor: AppConfig.colorPrincipal,
                inactiveColor: AppConfig.colorFondo,
                label: valor.round().toString(),
                divisions: 100,
                onChanged: (double value) {
                  setState(() => {valor = value});
                },
              ),
            ),
            Expanded(
              child: Container(
                width: 400,
                child: Center(
                  child: Image(
                    image: const AssetImage('assets/logo400x400.png'),
                    height: valor,
                    width: valor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
