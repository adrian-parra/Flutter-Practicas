import 'package:flutter/material.dart';
import 'package:mini_proyecto_01/screens/imc_calculator_screen.dart';
import 'package:mini_proyecto_01/config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 3000),
      ()=> Navigator.pushReplacement(
        context,MaterialPageRoute(builder: (context) => const HomeScreen())
      )
    );
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.colorFondo,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png'),
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