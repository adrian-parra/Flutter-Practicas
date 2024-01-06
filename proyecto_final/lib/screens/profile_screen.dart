import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proyecto_final/utils/sesion_manager.dart';

import '../config.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  // final List<String> imagenes = [
  //   '${AppConfig.apiHost}uploads/cd3a5983-c580-454b-be86-b79991d39d97/g1.png', // Ruta o URL de la primera imagen
  //   '${AppConfig.apiHost}uploads/cd3a5983-c580-454b-be86-b79991d39d97/g2.png', // Ruta o URL de la segunda imagen
  //   '${AppConfig.apiHost}uploads/cd3a5983-c580-454b-be86-b79991d39d97/g2.png', // Ruta o URL de la tercera imagen
  //   // Agrega más imágenes según sea necesario
  // ];
  String nombre = '';
  String edad = '';
  String cargo = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConfig.colorFondo,
        appBar: AppBar(
          title: const Text('Perfil'),
          backgroundColor: AppConfig.colorPrincipal,
        ),
        body: Container(
          padding: const EdgeInsets.all(AppConfig.paddingValue),
          child: Card(
            elevation: 4,
            child: Container(
                padding: const EdgeInsets.all(AppConfig.paddingValue),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<Map<String, dynamic>>(
                        future: obtenerDatosDesdeBackend(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(
                              color: AppConfig.colorPrincipal,
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            Map<String, dynamic> responseData =
                                snapshot.data ?? {};
                            String nombre = responseData['nombre'] ?? '';
                            String cargo = responseData['cargo'] ?? '';
                            int edad = responseData['edad'] ?? 0;
                            Map<String, dynamic> horario =
                                responseData['horario'];
                            String tipoHorario = horario['tipo'];

                            List<dynamic> fotosDynamic = responseData['fotos'];

// Realizar una conversión explícita a List<Map<String, dynamic>>
                            List<Map<String, dynamic>> imagenesArray =
                                List<Map<String, dynamic>>.from(fotosDynamic);

                            // Lista de imágenes que se llenará con las rutas de las imágenes
                            List<String> imagenes = [];

                            // Llenar la lista de imágenes con las rutas provenientes del JSON
                            for (var dato in imagenesArray) {
                              imagenes
                                  .add('${AppConfig.apiHost}${dato["ruta"]}');
                            }

                            return Column(
                              children: [
                                Text(
                              '''
Bienvenido al perfil de usuario. Aquí puedes ver tu información personal.

$nombre

- $cargo
- Horario $tipoHorario
- $edad años

Imágenes para reconocimiento facial del estacionamiento:

''',
                              style: TextStyle(
                                  fontSize: AppConfig.sizeDescripcion +
                                      2, // Ajusta el tamaño de fuente según tus preferencias
                                  color: AppConfig
                                      .colorInfo // Ajusta el color del texto según tus preferencias
                                  ),
                            ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: imagenes.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: EdgeInsets.only(bottom: AppConfig.marginValue),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image.network(
                                          imagenes[index],
                                          height: 200.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );


                          }
                        },
                      ),
                      // ListView.builder(
                      //   shrinkWrap: true,
                      //   itemCount: imagenes.length,
                      //   itemBuilder: (context, index) {
                      //     return Image.network(imagenes[
                      //         index]); // Utiliza Image.network para cargar imágenes desde URL
                      //   },
                      // ),
                      // ListView.builder(
                      //   shrinkWrap: true,
                      //   itemCount: imagenes.length,
                      //   itemBuilder: (context, index) {
                      //     return Container(
                      //       margin: EdgeInsets.only(
                      //           bottom: AppConfig
                      //               .marginValue), // Ajusta el espacio horizontal entre imágenes
                      //       child: ClipRRect(
                      //         borderRadius: BorderRadius.circular(
                      //             10.0), // Ajusta el radio del borde
                      //         child: Image.network(
                      //           imagenes[
                      //               index], // Ajusta el ancho de la imagen según sea necesario
                      //           height:
                      //               200.0, // Ajusta la altura de la imagen según sea necesario
                      //           fit: BoxFit
                      //               .cover, // Ajusta cómo se ajusta la imagen dentro del contenedor
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),
                    ],
                  ),
                )),
          ),
        ));
  }

  Future<Map<String, dynamic>> obtenerDatosDesdeBackend() async {
    try {
      var response = await http.get(
        Uri.parse('${AppConfig.apiUrl}persona/${SessionManager.uuid}'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Error: ${response.statusCode}');
        return {'error': 'Error al obtener datos'};
      }
    } catch (e) {
      print('Exception: $e');
      return {'error': 'Excepción al obtener datos'};
    }
  }
}
