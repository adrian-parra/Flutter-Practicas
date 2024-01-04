import 'package:flutter/material.dart';

import '../config.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.colorFondo,
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: AppConfig.colorPrincipal,
      ),
      body: null
    );
  }
}