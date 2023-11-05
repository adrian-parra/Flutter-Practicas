import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:practica_17/config.dart';
import 'package:practica_17/data/movies.dart';

class ListViewScreen extends StatefulWidget {
  const ListViewScreen({super.key});

  @override
  State<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  List<Map<String, dynamic>> pelis = [...movies];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.colorFondo,
      appBar: AppBar(
        title: const Text('Practica 17 - Dismissed'),
        backgroundColor: AppConfig.colorPrincipal,
      ),
      body: ListView.builder(
        itemCount: pelis.length,
        itemBuilder: (BuildContext context,int index){
          final item = pelis[index];
          return Slidable(child: ListTile(
            title: Text(item['title_name']),
            subtitle: Text(item['genres']),
          ), actionPane: const SlidableDrawerActionPane(),
          actions: [
            IconSlideAction(
              caption: 'Agregar',
              color: AppConfig.colorSuccess,
              icon: Icons.library_add,
              onTap: () => onDismissed(index ,'Agregar') ,
            )
          ],
          secondaryActions: [
            IconSlideAction(
              caption: 'Eliminar',
              color: AppConfig.colorDanger,
              icon: Icons.library_add,
              onTap: () => onDismissed(index ,'Eliminar') ,
            )
          ],
          );
        },
      ),
    );
  }
  
  onDismissed(int index, String accion) {
    setState(() {
      final snackBar = SnackBar(content: Text('Acción: $accion'));
      pelis.removeAt(index);


      switch(accion){
        case'Agregar':
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;
        case'Eliminar':
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;
      }

    });
  }
}