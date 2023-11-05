import 'package:flutter/material.dart';
import 'package:practica_18/config.dart';

class RectangleMedium extends StatelessWidget {
  const RectangleMedium({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: const BoxDecoration(
        color: AppConfig.colorSuccess
      ),
    );
  }
}