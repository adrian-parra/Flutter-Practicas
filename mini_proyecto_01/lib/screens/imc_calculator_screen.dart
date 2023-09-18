import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mini_proyecto_01/widgets/custom_text_field.dart';
import 'package:mini_proyecto_01/config.dart';
import 'package:mini_proyecto_01/widgets/custom_elevated_button.dart';
import 'package:mini_proyecto_01/widgets/imc_resultado.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        title: const Text('IMC CALCULATOR'),
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
                  'Formulario',
                  style: TextStyle(
                    fontSize: AppConfig.sizeTitulo,
                    color: AppConfig.colorPrincipal,
                    letterSpacing: AppConfig.letterSpacingValue,
                  ),
                ),
                const SizedBox(height: (AppConfig.gap * 3)),
                const Text(
                  'Cuanto pesa?',
                  style: TextStyle(
                    fontSize: AppConfig.sizeDescripcion,
                    color: AppConfig.colorDescripcion,
                    letterSpacing: AppConfig.letterSpacingValue,
                  ),
                ),
                const SizedBox(height: AppConfig.gap),
                CustomTextField(
                  labelText: 'Peso',
                  controller: peso,
                  hintText: 'Ingrese peso en kilogramos',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: AppConfig.gap),
                const Text(
                  'Cuanto mide?',
                  style: TextStyle(
                    fontSize: AppConfig.sizeDescripcion,
                    color: AppConfig.colorDescripcion,
                    letterSpacing: AppConfig.letterSpacingValue,
                  ),
                ),
                const SizedBox(height: AppConfig.gap),
                CustomTextField(
                  labelText: 'Estatura',
                  controller: estatura,
                  hintText: 'Ingrese su estatura en metros',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: (AppConfig.gap * 2)),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'Calcular',
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

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Resultado(
                                      imc: result,
                                      category: category,
                                      imagenPath:imagenPath,
                                      messageType:messageText
                                    )));
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
