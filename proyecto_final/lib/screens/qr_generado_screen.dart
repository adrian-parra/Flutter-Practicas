import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyecto_final/config.dart';
import 'package:proyecto_final/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QrGenerado extends StatelessWidget {
  const QrGenerado({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.colorFondo,
      appBar: AppBar(
        title: Text('Qr generado'),
        backgroundColor: AppConfig.colorPrincipal,
      ),
      body: Center(
        child: Card(
          elevation: 4,
          child: Container(
              padding: const EdgeInsets.all(AppConfig.paddingValue),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<String?>(
                    future: getImagePathFromSharedPreferences(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Text(
                              'Error al obtener la ruta de la imagen');
                        }

                        final imagePath = snapshot.data;

                        if (imagePath != null && imagePath.isNotEmpty) {
                          return Column(
                            children: [
                              Image.network(
                                '${AppConfig.apiHost}$imagePath',
                                // Ajusta las propiedades de la imagen según tus necesidades
                              ),
                              const SizedBox(height: (AppConfig.gap)),
                              ElevatedButton(
                                onPressed: () {
                                  // Lógica para realizar acciones al presionar el botón
                                  clearImagePathInSharedPreferences();
                                  Fluttertoast.showToast(
                                    msg:
                                        'QR eliminado,ya puede generar uno nuevo',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 12,
                                    backgroundColor: AppConfig.colorSuccess,
                                    textColor: AppConfig.colorSecundario,
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(
                                        AppConfig.paddingValue),
                                    backgroundColor: AppConfig.colorDanger),
                                child: const Icon(Icons.delete),
                              ),
                            ],
                          );
                        } else {
                          return const Text('No hay QR generado, Genera uno ahora',style: TextStyle(
                            color: AppConfig.colorInfo
                          ),);
                        }
                      } else {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Future<String?> getImagePathFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('qrGenerado');
  }

  Future<void> clearImagePathInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('qrGenerado');
  }
}
