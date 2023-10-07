import 'package:flutter/material.dart';
import 'package:practica_11/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedScreen extends StatefulWidget {
  const SharedScreen({super.key});

  @override
  State<SharedScreen> createState() => _SharedScreenState();
}

class _SharedScreenState extends State<SharedScreen> {
  int edad = 0;
  String nombre = '';

  grabarDatos() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('edad', 33);
    preferences.setString('nombre', 'Adrian Parra');
  }

  leerDatos() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    edad = preferences.getInt('edad')!;
    nombre = preferences.getString('nombre')!;
  }

  @override
  void initState() {
    grabarDatos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.colorFondo,
      appBar: AppBar(
        title: const Text('Practica 11'),
        backgroundColor: AppConfig.colorPrincipal,
        centerTitle: true,
      ),
      body: Center(
          child: Card(
        elevation: 4,
          margin: const EdgeInsets.all(AppConfig.marginValue),

        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppConfig.paddingValue),
          child: Column(
            mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Text('Datos' ,style: TextStyle(
                color: AppConfig.colorPrincipal,
                fontSize: AppConfig.sizeSubtitulo
              ),),
              const SizedBox(height: AppConfig.gap,),
              Text('Nombre: $nombre', style: const TextStyle(
                color: AppConfig.colorDescripcion,
                fontSize: AppConfig.sizeDescripcion
              )),
              const SizedBox(height: AppConfig.gap),
              Text('Edad: $edad',style: const TextStyle(
                color: AppConfig.colorDescripcion,
                fontSize: AppConfig.sizeDescripcion
              ))
            ],
          ),
        ),
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppConfig.colorPrincipal,
        onPressed: () {
          setState(() {
            leerDatos();
          });
        },
        tooltip: 'Refrescar',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
