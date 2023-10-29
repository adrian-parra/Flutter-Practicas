import 'package:flutter/material.dart';
import 'dart:math';

import 'package:practica_15/config.dart';

class SliverScreen extends StatelessWidget {
  SliverScreen({super.key});

  final rnd = Random();

  final List<Color> colores = [
    Colors.black,
    Colors.white,
    Colors.amber,
    Colors.brown,
    Colors.cyan,
    Colors.green,
    Colors.grey,
    Colors.orange,
    Colors.pink,
    Colors.purple,
    Colors.lime
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(
      70,
      (index) => Container(
        height: 100,
        color: colores[rnd.nextInt(colores.length)],
        width: double.infinity,
      ),
    );
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // title: const Text('Practica 15 - Slivers'),
            centerTitle: true,
            floating: true,
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: Image.asset('assets/yt_1200.png', fit: BoxFit.cover),
          ),
          SliverList(
            delegate: SliverChildListDelegate(items),
          )
        ],
      ),
    );
  }
}
