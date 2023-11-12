import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:practica_19/config.dart';
import 'package:practica_19/widgets/list_tile.dart';

class ListViewScreen extends StatelessWidget {
  var datos;
  ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.colorFondo,
      appBar: AppBar(
        title: const Text('Practica 19 - API'),
        centerTitle: true,
        backgroundColor: AppConfig.colorPrincipal,
      ),body: FutureBuilder(
        future: llamarUrl(),
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot<List> snapshot){
          try {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context,int index){
                var datos = snapshot.data![index];
                return MyListTile(
                  titulo: datos['name'],
                  subtitulo: datos['gender'],
                  imagenFin: datos['image'],
                );
              },
            );
          } catch (e) {
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }

  Future<List> llamarUrl() async {
    var url = 'https://rickandmortyapi.com/api/character/1,2,3,4,5,6,7,8,9,10,20,183';

    final respuesta = await get(Uri.parse(url));
    final respuestaJson = jsonDecode(respuesta.body);

    return respuestaJson;
  }
}