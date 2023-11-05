import 'package:flutter/material.dart';
import 'package:practica_18/config.dart';

class RectangleLarge extends StatelessWidget {
  const RectangleLarge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      decoration: const BoxDecoration(
        color: AppConfig.colorDanger
      ),
    );
  }
}