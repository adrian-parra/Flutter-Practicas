import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyecto_final/screens/home_screen.dart';
import 'package:proyecto_final/utils/sesion_manager.dart';
import 'package:proyecto_final/widgets/custom_text_field_widget.dart';
import 'package:proyecto_final/config.dart';
import 'package:proyecto_final/widgets/custom_elevated_button_widget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController user = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.colorFondo,
      appBar: AppBar(
        leading: Icon(Icons.person),
        title: const Text('Iniciar sesión'),
        backgroundColor: AppConfig.colorPrincipal,
      ),
      body: Container(
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.all(AppConfig.marginValue),
          child: Container(
            padding: const EdgeInsets.all(AppConfig.paddingValue),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Text(
                //   'Iniciar sesión',
                //   style: TextStyle(
                //     fontSize: AppConfig.sizeTitulo,
                //     color: AppConfig.colorPrincipal,
                //     letterSpacing: AppConfig.letterSpacingValue,
                //   ),
                // ),
                // const SizedBox(height: (AppConfig.gap * 3)),
                const Text(
                  'Ingrese nombre de usuario',
                  style: TextStyle(
                    fontSize: AppConfig.sizeDescripcion,
                    color: AppConfig.colorDescripcion,
                    letterSpacing: AppConfig.letterSpacingValue,
                  ),
                ),
                const SizedBox(height: AppConfig.gap),
                CustomTextField(
                  labelText: 'Usuario',
                  controller: user,
                  hintText: 'Ingrese usuario',
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: AppConfig.gap),
                const Text(
                  'Ingrese contraseña',
                  style: TextStyle(
                    fontSize: AppConfig.sizeDescripcion,
                    color: AppConfig.colorDescripcion,
                    letterSpacing: AppConfig.letterSpacingValue,
                  ),
                ),
                const SizedBox(height: AppConfig.gap),
                CustomTextField(
                  labelText: 'Contraseña',
                  controller: password,
                  hintText: 'Ingrese contraseña',
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: (AppConfig.gap * 2)),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'Acceder',
                        onPressed: () {
                          setState(() {
                            if (user.text == '' || user.text == null) {
                              isError = true;
                              Fluttertoast.showToast(
                                msg: 'Ingrese su nombre de usuario',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 5,
                                backgroundColor: AppConfig.colorDanger,
                                textColor: AppConfig.colorSecundario,
                              );
                            }

                            if (password.text == '' || password.text == null) {
                              isError = true;
                              Fluttertoast.showToast(
                                msg: 'Ingrese su password',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 5,
                                backgroundColor: AppConfig.colorDanger,
                                textColor: AppConfig.colorSecundario,
                              );
                            }

                            if (isError) {
                              isError = false;
                              return;
                            }

                            authUser(user: user.text, pass: password.text);

                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => Resultado(
                            //           imc: result,
                            //           category: category,
                            //           imagenPath:imagenPath,
                            //           messageType:messageText
                            //         )));
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: (AppConfig.gap)),
                Row(
                  children: [
                    Expanded(
                        child: CustomButton(
                      onPressed: () async {

                          await SessionManager.guardarSesion(
                              nombre: '', cargo: '', uuid: '', rol: 'invitado');

                          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));

                      },
                      text: 'INVITADO',
                      color: AppConfig.colorSuccess,
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void authUser({required String user, required String pass}) async {
    try {
      var response = await http.post(
        Uri.parse('${AppConfig.apiUrl}persona/auth'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user': user,
          'pass': pass,
        }),
      );
      if (response.statusCode == 200) {
        // ? LIMPIAR FORMULARIO

        Map<String, dynamic> responseData = jsonDecode(response.body);
        String codeResponse = responseData['icon'];
        String responseTitle = responseData['title'];

        if (codeResponse == 'error') {
          Fluttertoast.showToast(
            msg: responseTitle,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 8,
            backgroundColor: AppConfig.colorDanger,
            textColor: AppConfig.colorSecundario,
          );
        } else {
          Map<String, dynamic> UserModel = responseData['body'];
          String userNombre = UserModel['nombre'];
          String userCargo = UserModel['cargo'];
          String userUuid = UserModel['uuid'];

          await SessionManager.guardarSesion(
              nombre: userNombre,
              cargo: userCargo,
              uuid: userUuid,
              rol: 'usuario');

          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));

          Fluttertoast.showToast(
            msg: responseTitle,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 10,
            backgroundColor: AppConfig.colorSuccess,
            textColor: AppConfig.colorSecundario,
          );
        }

        // print('model ' + UserModel['nombre']);
        print('code ' + codeResponse);
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }
}
