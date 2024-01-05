import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyecto_final/screens/home_screen.dart';
import 'package:proyecto_final/widgets/custom_text_field_widget.dart';
import 'package:proyecto_final/config.dart';
import 'package:proyecto_final/widgets/custom_elevated_button_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController peso = TextEditingController();
  final TextEditingController estatura = TextEditingController();
  bool isError = false;
  double result = 0.0;
  String category = '';
  String imagenPath = '';
  String messageText = '';

  void calculateIMC() {
    double weight = double.tryParse(peso.text) ?? 0.0;
    double height = double.tryParse(estatura.text) ?? 0.0;

    if (weight > 0 && height > 0) {
      double imc = weight / (height * height);
      result = imc;
      String imcCategory = '';
      if (imc < 18) {
        imcCategory = 'Peso Bajo. Necesario valorar signos de desnutrición';
        imagenPath = 'normal.png';
        messageText = 'info';
      } else if (imc >= 18 && imc <= 24.9) {
        imcCategory = 'Normal';
        imagenPath = 'normal.png';
        messageText = 'success';
      } else if (imc >= 25 && imc <= 26.9) {
        imcCategory = 'Obesidad';
        imagenPath = 'preobeso.png';
        messageText = 'warning';
      } else if (imc >= 27 && imc <= 29.9) {
        imcCategory =
            'Obesidad grado I. Riesgo relativo para desarrollar enfermedades cardiovasculares.';
        imagenPath = 'obeso_tipo_1.png';
        messageText = 'danger';
      } else if (imc >= 30 && imc <= 39.9) {
        imcCategory =
            'Obesidad grado II. Riesgo relativo muy alto para el desarrollo de enfermedades cardiovasculares.';
        imagenPath = 'obeso_tipo_2.png';
        messageText = 'danger';
      } else {
        imcCategory =
            'Obesidad grado III (Extrema o mórbida). Riesgo relativo extremadamente alto para el desarrollo de enfermedades cardiovasculares.';
        imagenPath = 'obeso_tipo_3.png';
        messageText = 'danger';
      }
      category = imcCategory;
    }
  }

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
                  controller: peso,
                  hintText: 'Ingrese usuario',
                  keyboardType: TextInputType.number,
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
                  controller: estatura,
                  hintText: 'Ingrese contraseña',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: (AppConfig.gap * 2)),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'Acceder',
                        onPressed: () {
                          setState(() {
                            if (peso.text == '' || peso.text == null) {
                              isError = true;
                              Fluttertoast.showToast(
                                msg: 'Ingrese su peso en kilogramos',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 5,
                                backgroundColor: AppConfig.colorDanger,
                                textColor: AppConfig.colorSecundario,
                              );
                            }

                            if (estatura.text == '' || estatura.text == null) {
                              isError = true;
                              Fluttertoast.showToast(
                                msg: 'Ingrese su estatura en metros',
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

                            // ? CALCULAR IMC
                            calculateIMC();

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
                      onPressed: () {
                        setState(() {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(),));
                        });
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
}
