import 'package:flutter/material.dart';
import 'package:mini_proyecto_01/config.dart';

class Resultado extends StatelessWidget {
  final double imc;
  final String category;
  final String imagenPath;
  final String messageType;

  const Resultado(
      {super.key,
      required this.imc,
      required this.category,
      required this.imagenPath,
      required this.messageType });

    static const Map<String, Color> messageColors = {
    'success': AppConfig.colorSuccess,
    'warning': AppConfig.colorWarning,
    'info': AppConfig.colorInfo,
    'danger': Colors.red,
  };

  Color getColorForMessageType() {
    return messageColors[messageType] ?? Colors.black;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.colorFondo,
      appBar: AppBar(
        title: const Text('Resultado'),
        backgroundColor: AppConfig.colorPrincipal,
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
                Center(
                  child: Image.asset(
                    'assets/$imagenPath',
                    width: 150.0, // Ancho de la imagen
                    height: 150.0, // Alto de la imagen
                  ),
                ),
                const SizedBox(
                  height: AppConfig.gap,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'IMC: ',
                      style: TextStyle(
                          color: AppConfig.colorPrincipal,
                          fontSize: AppConfig.sizeSubtitulo),
                    ),
                    Text(
                      imc.toStringAsFixed(2),
                      style: const TextStyle(
                          color: AppConfig.colorDescripcion,
                          fontSize: AppConfig.sizeSubtitulo),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppConfig.gap,
                ),
                Center(
                  child: Text(
                    category,
                    style: TextStyle(
                        color: getColorForMessageType(),
                        fontSize: AppConfig.sizeSubtitulo),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
