import 'package:flutter/material.dart';
import 'package:mini_proyecto_02/config.dart';
import '../screens/game_screen.dart';
import 'custom_elevated_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DifficultySelection extends StatefulWidget {
  @override
  _DifficultySelectionState createState() => _DifficultySelectionState();
}

class _DifficultySelectionState extends State<DifficultySelection> {
  String selectedDifficulty = "easy"; // Valor inicial

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.colorFondo,
      appBar: AppBar(
        title: const Text("Selección de dificultad"),
        backgroundColor: AppConfig.colorPrincipal,
      ),
      body: Column(
        children: <Widget>[
          const ListTile(
            title: Text(
              "Elige tu desafío",
              style: TextStyle(
                  color: AppConfig.colorDescripcion,
                  fontWeight: FontWeight.w600),
            ),
          ),
          RadioListTile(
            title: const Text(
              "Fácil (4 Pares)",
              style: TextStyle(
                  color: AppConfig.colorSuccess, fontWeight: FontWeight.bold),
            ),
            subtitle: FutureBuilder<int>(
              future: obtenerTiempoFinalizacionJuego("Easy"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                   if(snapshot.data == 0) return const Text('Sin record aun');
                  return Text('Record: ${snapshot.data.toString()} seg.');
                } else {
                  return const Text("Cargando...");
                }
              },
            ),
            value: "easy",
            groupValue: selectedDifficulty,
            onChanged: (value) {
              setState(() {
                selectedDifficulty = value!;
              });
            },
          ),
          RadioListTile(
            title: const Text(
              "Medio (5 Pares)",
              style: TextStyle(
                  color: AppConfig.colorWarning, fontWeight: FontWeight.bold),
            ),
            subtitle: FutureBuilder<int>(
              future: obtenerTiempoFinalizacionJuego("Medium"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                   if(snapshot.data == 0) return const Text('Sin record aun');
                  return Text('Record: ${snapshot.data.toString()} seg.');
                } else {
                  return const Text("Cargando...");
                }
              },
            ),
            value: "medium",
            groupValue: selectedDifficulty,
            onChanged: (value) {
              setState(() {
                selectedDifficulty = value!;
              });
            },
          ),
          RadioListTile(
            title: const Text(
              "Difícil (6 Pares)",
              style: TextStyle(
                  color: AppConfig.colorDanger, fontWeight: FontWeight.bold),
            ),
            subtitle: FutureBuilder<int>(
              future: obtenerTiempoFinalizacionJuego("Hard"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if(snapshot.data == 0) return const Text('Sin record aun');
                  return Text('Record: ${snapshot.data.toString()} seg.');
                } else {
                  return const Text("Cargando...");
                }
              },
            ),
            value: "hard",
            groupValue: selectedDifficulty,
            onChanged: (value) {
              setState(() {
                selectedDifficulty = value!;
              });
            },
          ),
          const SizedBox(height: AppConfig.gap),
          Container(
            padding: const EdgeInsets.all(AppConfig.paddingValue),
            width: double.infinity,
            child: CustomButton(
              text: 'Jugar',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          GameScreen(difficulty: selectedDifficulty)),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Future<int> obtenerTiempoFinalizacionJuego(String dificultad) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int tiempoFinal = prefs.getInt('tiempoFinalizacion$dificultad') ??
        0; // Valor predeterminado si no se encuentra
    return tiempoFinal;
  }
}
