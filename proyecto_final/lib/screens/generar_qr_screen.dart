import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proyecto_final/widgets/custom_elevated_button_widget.dart';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../widgets/custom_text_field_widget.dart';

class GenerarQrScreen extends StatelessWidget {
  final TextEditingController motivo = TextEditingController();
  final TextEditingController fecha = TextEditingController();

  GenerarQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConfig.colorFondo,
        appBar: AppBar(
          title: const Text('QR de acceso'),
          backgroundColor: AppConfig.colorPrincipal,
        ),
        body: Center(
          child: Card(
            elevation: 4,
            margin: const EdgeInsets.all(AppConfig.marginValue),
            child: Container(
              padding: const EdgeInsets.all(AppConfig.paddingValue),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Generar QR',
                    style: TextStyle(
                      fontSize: AppConfig.sizeTitulo,
                      color: AppConfig.colorPrincipal,
                      letterSpacing: AppConfig.letterSpacingValue,
                    ),
                  ),
                  const SizedBox(height: (AppConfig.gap * 3)),
                  const Text(
                    'Ingrese motivo',
                    style: TextStyle(
                      fontSize: AppConfig.sizeDescripcion,
                      color: AppConfig.colorDescripcion,
                      letterSpacing: AppConfig.letterSpacingValue,
                    ),
                  ),
                  const SizedBox(height: AppConfig.gap),
                  CustomTextField(
                    labelText: 'Motivo',
                    controller: motivo,
                    hintText: 'Ingrese motivo',
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: AppConfig.gap),
                  const Text(
                    'Ingrese fecha',
                    style: TextStyle(
                      fontSize: AppConfig.sizeDescripcion,
                      color: AppConfig.colorDescripcion,
                      letterSpacing: AppConfig.letterSpacingValue,
                    ),
                  ),
                  const SizedBox(height: AppConfig.gap),
                  CustomTextField(
                    labelText: 'Fecha',
                    controller: fecha,
                    hintText: 'Ingrese fecha',
                    keyboardType: TextInputType.datetime,
                  ),
                  const SizedBox(height: (AppConfig.gap * 2)),
                  Row(
                    children: [
                      Expanded(
                          child: CustomButton(
                        onPressed: () async {
                          print('API response: .......');
                          // generarQrAcceso(motivo: motivo.text,fecha: fecha.text);
                          try {
                            print(fecha.text);
                            print('${AppConfig.apiUrl}qrAcceso');
                            var response = await http.post(
                              Uri.parse('${AppConfig.apiUrl}qrAcceso'),
                              headers: {'Content-Type': 'application/json'},
                              body: jsonEncode({
                                'motivo': motivo.text,
                                'fechaValida': '${fecha.text}T07:00:00.000Z',
                              }),
                            );
                            // Check if the request was successful (status code 200)
                            if (response.statusCode == 200) {
                              // Process the API response here
                              print('API response: ${response.body}');
                              Map<String, dynamic> responseData = jsonDecode(response.body);
                              String imagePath = responseData['body'];
                              
                              showImageModal(context, imagePath);

                            } else {
                              // Handle the error if the request was not successful
                              print('Error: ${response.statusCode}');
                            }
                          } catch (e) {
                            print('Exception: $e');
                          }
                        },
                        text: 'Generar',
                      ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void generarQrAcceso({String? motivo, String? fecha}) async {
    try {
      var response = await http.post(
        Uri.parse('${AppConfig.apiUrl}qrAcceso'),
        body: json.encode({
          'motivo': motivo,
          'fechaValida': '${fecha}T07:00:00.000Z',
        }),
      );
      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Process the API response here
        print('API response: ${response.body}');
      } else {
        // Handle the error if the request was not successful
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

void showImageModal(BuildContext context, String imagePath) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Image.network(
          '${AppConfig.apiHost}$imagePath',
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                      : null,
                ),
              );
            }
          },
          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
            return Icon(Icons.error);
          },
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Cerrar'),
            ),
          ),
        ],
      );
    },
  );
}

}
