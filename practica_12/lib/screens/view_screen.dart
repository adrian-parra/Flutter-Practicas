import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:practica_12/config.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({super.key});

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practica 12 - Leer JSON'),
        centerTitle: true,
        backgroundColor: AppConfig.colorPrincipal,
      ),
      body: Center(
        child: FutureBuilder(
          future:
              DefaultAssetBundle.of(context).loadString('assets/pokedex.json'),
          initialData: const [],
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            var showData = json.decode(snapshot.data.toString());
            return ListView.builder(
              itemCount: showData.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: (() {}),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(showData[index]['name']),
                        subtitle: Text(showData[index]['type']),
                        trailing: const Icon(Icons.arrow_forward,
                            color: AppConfig.colorPrincipal),
                      ),
                      const Divider(
                        color: AppConfig.colorDescripcion,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
