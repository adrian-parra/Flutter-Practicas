import 'package:flutter/material.dart';
import 'package:mini_proyecto_02/config.dart';
import 'package:mini_proyecto_02/widgets/nivel_dificultad_widget.dart';

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
        context,MaterialPageRoute(builder: (context) => DifficultySelection())
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
          children: const [
            Text(
              "MEMORAMA GAME",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AppConfig.sizeTitulo,
                color: AppConfig.colorPrincipal
              ),
              ),
            SizedBox(height: 50),
            CircularProgressIndicator(
              color: AppConfig.colorPrincipal,
            )
          ],
        ),
      ),
    );
  }
}