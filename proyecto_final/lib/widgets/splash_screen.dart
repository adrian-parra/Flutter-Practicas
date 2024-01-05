import 'package:flutter/material.dart';
import 'package:proyecto_final/screens/home_screen.dart';
// import 'package:proyecto_final/screens/home_screen.dart';
import 'package:proyecto_final/screens/login_screen.dart';
import 'package:proyecto_final/config.dart';

import '../utils/sesion_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 5000),
      ()=> verificarSesion()
    );
    super.initState();
    
  }

   Future<void> verificarSesion() async {
    // Esperar a que se obtenga la información de sesión
    Map<String, String> sesion = await SessionManager.obtenerSesion();

    // Comprobar si hay información de sesión
    if (sesion['rol']!.isNotEmpty) {
      // Si hay información de sesión, redirigir a la pantalla de inicio
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      // Si no hay información de sesión, redirigir a la pantalla de inicio de sesión
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.colorSecundario,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/universidad.png'),
            Text('LOAL SOFT',
            style: TextStyle(
              color: AppConfig.colorPrincipal,
              fontSize: AppConfig.sizeSubtitulo
              ),
              ),
            const SizedBox(height: (AppConfig.gap * 2)),
            const CircularProgressIndicator(
              backgroundColor: AppConfig.colorFondo,
              color: AppConfig.colorPrincipal,
            )
          ],
        ),
      ),
    );
  }
}