import 'package:flutter/material.dart';

class RectangleSmall extends StatelessWidget {
  const RectangleSmall({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: const BoxDecoration(
        color: Colors.yellow
      ),
    );
  }
}