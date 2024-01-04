import 'package:flutter/material.dart';
import 'package:proyecto_final/config.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;

  const CustomButton({super.key, 
    required this.text,
    required this.onPressed,
    this.color = AppConfig.colorPrincipal, 
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color, 
        foregroundColor: AppConfig.colorSecundario,
      ),
      child: Text(text),
    );
  }
}