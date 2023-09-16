import 'package:flutter/material.dart';
import 'package:practica_03/src/datos_recibidos.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ctrlnom = TextEditingController();
  final data = Data(nombre: '', sexo: '');
  int? valor = null;
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Practica 03'),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 10,left: 0,bottom: 10,right: 10),
                  margin: const EdgeInsets.only(bottom: 30),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      //color: Colors.white,
                      //borderRadius: BorderRadius.circular(10),
                      border: Border(
                        // bottom: BorderSide(color: Colors.blue),
                      ),
                      ),
                  child: const Text(
                    'Datos del usuario',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: const BoxDecoration(
                      //color: Colors.white,
                      //borderRadius: BorderRadius.circular(10),
                      //border: Border.all(color: Colors.blue),
                      ),
                  child: const Text(
                    'Cual es su  nombre?',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                TextField(
                  controller: ctrlnom,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: 'Ingrese el nombre',
                    labelText: 'Nombre',
                    labelStyle: TextStyle(fontSize: 18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      ),

                    contentPadding: const EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 10),
                        prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButton<int>(
                    isExpanded: true,
                    value: valor,
                    items: const [
                      DropdownMenuItem<int>(
                        value: null,
                        child: Text(
                          'Seleccione su género',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                          )
                        ),
                      ),
                      DropdownMenuItem<int>(
                        value: 1,
                        child: Text('Mujer'),
                      ),
                      DropdownMenuItem<int>(
                        value: 2,
                        child: Text('Hombre'),
                      )
                    ],
                    onChanged: (int? selected) {
                      if (selected != null) {
                        setState(() {
                          valor = selected;
                        });
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: const Text(
                    'Enviar',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        fontSize: 17),
                  ),
                  onPressed: () {
                    setState(() {
                      if (ctrlnom.text == null || ctrlnom.text == '') {
                        isError = true;
                        Fluttertoast.showToast(
                          msg: 'Ingrese su nombre',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 5,
                          backgroundColor: Colors.red, 
                          textColor: Colors.white,
                        );
                      }

                      if (valor == null || valor == 0) {
                        isError = true;
                        Fluttertoast.showToast(
                          msg: 'Por favor, seleccione su género',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 5,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
                      }

                      if(isError){
                        isError = false;
                        return;
                      }

                      

                      data.nombre = ctrlnom.text;

                      if (valor == 1) {
                        data.sexo = 'Mujer';
                      } else {
                        data.sexo = 'Hombre';
                      }
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DatosPage(data: data)));
                    });
                  },
                )
              ],
            ),
          ),
        ));
  }
}

class Data {
  String nombre;
  String sexo;

  Data({required this.nombre, required this.sexo});
}
