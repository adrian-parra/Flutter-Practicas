import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyecto_final/utils/sesion_manager.dart';
import 'package:proyecto_final/widgets/custom_elevated_button_widget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';
import '../widgets/custom_text_field_widget.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_final/utils/helper.dart';

class GenerarQrScreen extends StatelessWidget {
  final TextEditingController motivo = TextEditingController();

  bool isError = false;

  String? selectedDate;

  String? motivoSeleccionado;

  GenerarQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("yyyy-MM-dd");
    TuDropdown tuDropdown = TuDropdown(
      motivos: const [],
    );
    return Scaffold(
        backgroundColor: AppConfig.colorFondo,
        appBar: AppBar(
          title: const Text('Generar QR de acceso'),
          backgroundColor: AppConfig.colorPrincipal,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 4,
                margin: const EdgeInsets.all(AppConfig.marginValue),
                child: Container(
                  padding: const EdgeInsets.all(AppConfig.paddingValue),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const Text(
                      //   'Generar QR',
                      //   style: TextStyle(
                      //     fontSize: AppConfig.sizeTitulo,
                      //     color: AppConfig.colorPrincipal,
                      //     letterSpacing: AppConfig.letterSpacingValue,
                      //   ),
                      // ),
                      // const SizedBox(height: (AppConfig.gap * 3)),
                      // const Text(
                      //   'Ingrese motivo',
                      //   style: TextStyle(
                      //     fontSize: AppConfig.sizeDescripcion,
                      //     color: AppConfig.colorDescripcion,
                      //     letterSpacing: AppConfig.letterSpacingValue,
                      //   ),
                      // ),
                      FutureBuilder<List<String>>(
                        future: obtenerMotivosDesdeBD(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error al cargar los motivos');
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Text('No hay motivos disponibles');
                          } else {
                            List<String> motivos = snapshot.data!;
                            return Column(
                              children: [
                                TuDropdown(
                                  motivos: motivos,
                                  onMotivoSeleccionado:
                                      (String? motivoSeleccionado) {
                                    if (motivoSeleccionado != null) {
                                      this.motivoSeleccionado =
                                          motivoSeleccionado;
                                    }
                                  },
                                ),
                              ],
                            );
                          }
                        },
                      ),
                      // const SizedBox(height: AppConfig.gap),
                      // CustomTextField(
                      //   labelText: 'Motivo',
                      //   controller: motivo,
                      //   hintText: 'Ingrese motivo',
                      //   keyboardType: TextInputType.text,
                      // ),
                      const SizedBox(height: AppConfig.gap),
                      const Text(
                        'Seleccione fecha de uso',
                        style: TextStyle(
                          fontSize: AppConfig.sizeDescripcion,
                          color: AppConfig.colorDescripcion,
                          letterSpacing: AppConfig.letterSpacingValue,
                        ),
                      ),
                      const SizedBox(height: AppConfig.gap),
                      DateTimeField(
                        format: format,
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: AppConfig.paddingValue),
                          hintStyle: TextStyle(
                              color: AppConfig.colorDescripcion,
                              fontSize: AppConfig.sizeDescripcion),
                          labelText: 'Fecha',
                          labelStyle: TextStyle(
                              color: AppConfig.colorDescripcion,
                              fontSize: AppConfig.sizeDescripcion),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppConfig.colorPrincipal),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppConfig.colorFondo),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppConfig.colorPrincipal),
                          ),
                        ),
                        onShowPicker: (context, currentValue) async {
                          final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2101),
                          );
                          if (date != null) {
                            final formattedDate =
                                date.toIso8601String().substring(0, 10);

                            selectedDate = formattedDate;
                          }
                          return date;
                        },
                      ),
                      const SizedBox(height: (AppConfig.gap * 2)),
                      Row(
                        children: [
                          Expanded(
                              child: CustomButton(
                            onPressed: () async {
                              // ? VALIDAR CAMPOS DEL FORM
                              validarForm();
                              if (isError) {
                                isError = false;
                                return;
                              }

                              // ? VALIDAR SI YA HA GENERADO EL QR
                              if (await this
                                  .doesImagePathExistInSharedPreferences()) {
                                Fluttertoast.showToast(
                                  msg:
                                      'Ya ha generado un qr, solo puede generar uno por sesión',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 12,
                                  backgroundColor: AppConfig.colorInfo,
                                  textColor: AppConfig.colorSecundario,
                                );
                                return;
                              }

                              // ? GENERAR EL QR SI SI NO HAY PROBLEMAS EN FORMULARIO
                              generarQrAcceso(
                                  motivo: motivoSeleccionado,
                                  fecha: selectedDate,
                                  context: context);
                            },
                            text: 'Generar',
                          ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 0,
                  left: AppConfig.paddingValue - 5,
                  right: AppConfig.paddingValue - 5,
                  bottom: AppConfig.paddingValue - 5,
                ),
                child: Card(
                    elevation: 4,
                    child: Container(
                      padding: const EdgeInsets.all(AppConfig.paddingValue),
                      child: Text(
                        '''Aquí puedes generar tu código QR para acceder al estacionamiento.

Recuerda que:
- El código QR es único para cada sesión.
- Solo es válido para un uso y hasta la fecha seleccionada.

¡Asegúrate de utilizar el código antes de la fecha de vencimiento!''',
                        style: TextStyle(
                            fontSize: AppConfig.sizeDescripcion +
                                2, // Ajusta el tamaño de fuente según tus preferencias
                            color: AppConfig
                                .colorInfo // Ajusta el color del texto según tus preferencias
                            ),
                      ),
                    )),
              )
            ],
          ),
        ));
  }

  void generarQrAcceso(
      {String? motivo, String? fecha, required BuildContext context}) async {
    try {
      var response;
      if(SessionManager.rol == 'usuario'){
        response = await http.post(
        Uri.parse('${AppConfig.apiUrl}qrAcceso/${SessionManager.uuid}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'motivo': motivo,
          'fechaValida': '${fecha}T07:00:00.000Z',
        }),
      );
      }else{
        response = await http.post(
        Uri.parse('${AppConfig.apiUrl}qrAcceso'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'motivo': motivo,
          'fechaValida': '${fecha}T07:00:00.000Z',
        }),
      );
      }
      
      if (response.statusCode == 200) {
        // ? LIMPIAR FORMULARIO
        this.motivo.text = '';

        Map<String, dynamic> responseData = jsonDecode(response.body);
        String imagePath = responseData['body'];

        showImageModal(context, imagePath);

        SessionManager.guardarPathImageQrGenerado(imagePath);
      } else {
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
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              }
            },
            errorBuilder:
                (BuildContext context, Object error, StackTrace? stackTrace) {
              return const Icon(Icons.error);
            },
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Cerrar',
                  style: TextStyle(
                    color: AppConfig.colorDanger,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void validarForm() {
    if (motivoSeleccionado == '' || motivoSeleccionado == null) {
      isError = true;
      Fluttertoast.showToast(
        msg: 'Seleccione motivo',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: AppConfig.colorDanger,
        textColor: AppConfig.colorSecundario,
      );
    }

    if (selectedDate == '' || selectedDate == null) {
      isError = true;
      Fluttertoast.showToast(
        msg: 'Seleccione fecha de uso',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: AppConfig.colorDanger,
        textColor: AppConfig.colorSecundario,
      );
    }
  }

  // void saveImagePathToSharedPreferences(String imagePath) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('qrGenerado', imagePath);

  //   String codeQr = obtenerUUidDeCadena(imagePath);

  //   prefs.setString('codeQrGenerado', codeQr);
  // }

  Future<bool> doesImagePathExistInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('qrGenerado');
    return imagePath != null && imagePath.isNotEmpty;
  }
}

// !!!!!!!!!!!!!!!!!!!

class TuDropdown extends StatefulWidget {
  final List<String> motivos;
  final ValueChanged<String?>? onMotivoSeleccionado;

  TuDropdown({required this.motivos, this.onMotivoSeleccionado});

  @override
  _TuDropdownState createState() => _TuDropdownState();
}

class _TuDropdownState extends State<TuDropdown> {
  String? _motivoSeleccionado;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _motivoSeleccionado,
      onChanged: (String? nuevoMotivo) {
        setState(() {
          _motivoSeleccionado = nuevoMotivo;

          // Llamamos a la función de retorno de llamada en el widget padre
          if (widget.onMotivoSeleccionado != null) {
            widget.onMotivoSeleccionado!(_motivoSeleccionado);
          }
        });
      },
      items: widget.motivos.map((String motivo) {
        return DropdownMenuItem<String>(
          value: motivo,
          child: Text(motivo),
        );
      }).toList(),
      hint: Text('Selecciona un motivo'),
    );
  }
}

Future<List<String>> obtenerMotivosDesdeBD() async {
  var response = await http.get(
    Uri.parse('${AppConfig.apiUrl}motivosAcceso'),
    headers: {'Content-Type': 'application/json'},
  );
  if (response.statusCode == 200) {
    Map<String, dynamic> responseData = jsonDecode(response.body);
    List<dynamic> motivosList = responseData['body'];

    List<String> arrayDeMotivos = [];

    for (var motivoObj in motivosList) {
      if (motivoObj != null && motivoObj['nombre'] != null) {
        arrayDeMotivos.add(motivoObj['nombre']);
      }
    }

    return arrayDeMotivos;
  } else {
    print('Error: ${response.statusCode}');
    return [];
  }
}
