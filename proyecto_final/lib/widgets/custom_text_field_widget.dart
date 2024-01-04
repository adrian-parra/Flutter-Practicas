import 'package:flutter/material.dart';
import 'package:proyecto_final/config.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final String hintText;

  const CustomTextField({super.key, 
    required this.labelText,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: AppConfig.colorPrincipal,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: const TextStyle(
        fontSize: 14.0,
        
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: AppConfig.paddingValue),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: AppConfig.colorDescripcion ,
          fontSize: AppConfig.sizeDescripcion
        ),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: AppConfig.colorDescripcion,
          fontSize: AppConfig.sizeDescripcion
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppConfig.colorPrincipal),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppConfig.colorFondo), 
        ),
        focusedBorder:const OutlineInputBorder(
          borderSide: BorderSide(color: AppConfig.colorPrincipal), 
        ),

      ),
    );
  }
}