import 'package:flutter/material.dart';
import 'package:proyecto_final/config.dart';
import 'package:proyecto_final/widgets/drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConfig.colorPrincipal,
        title: const Text('Inicio'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Lógica al presionar el ícono de inicio de sesión
            },
          ),
        ],
      ),
      body: 
      Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/car_background.png'),
              fit: BoxFit.scaleDown,
            ),
            color: AppConfig.colorSecundario.withOpacity(0.7),
          ),
          child: Column(
            children: [
                Container(
                margin: const EdgeInsets.all(AppConfig.marginValue),
                //  padding: const EdgeInsets.all(AppConfig.paddingValue),
                child:Card(
                  elevation: 4,
                  child:Container(
                     padding: const EdgeInsets.all(AppConfig.paddingValue),
                     child: const Text(
                    'Genera QR de acceso para el estacionamiento de la Universidad Autónoma de Sinaloa.',
                    style: TextStyle(color: AppConfig.colorInfo,fontSize: AppConfig.sizeDescripcion + 2),
                    ),
                  )
                  
                )
                 

              ),
              
            ],
          )),
      drawer: const Drawer(
        child: DrawerWidget(),
      ),
    );
  }
}
