import 'package:flutter/material.dart';

import '../config.dart';


class ListViewScreen extends StatelessWidget {

  ListViewScreen({super.key});

  final List<String> _clasesPokemon = [
    'Normal',
    'Fighting',
    'Flying',
    'Poison',
    'Ground',
    'Rock',
    'Bug',
    'Ghost',
    'Steel',
    'Fire',
    'Water',
    'Grass',
    'Electric',
    'Psychic',
    'Ice',
    'Dragon',
    'Dark',
    'Fairy',
    'Unknown',
    'Shadow'
  ];



  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: AppConfig.colorFondo,
      appBar: AppBar(
        title: const Text('Practica 09 - Pokedex'),
        centerTitle: true,
        backgroundColor: AppConfig.colorDanger,
      ),
      body: ListView.builder(
        itemCount: _clasesPokemon.length,
        itemBuilder: (BuildContext context,int index){
          return ListTile(
            onTap: (){},
            title: Text(_clasesPokemon[index]),
            leading: const CircleAvatar(
            radius: 22.0,
            backgroundImage: NetworkImage(
                'https://img1.freepng.es/20171220/kqw/pokeball-png-5a3a4a7e247ce7.9167778215137695981495.jpg'),
          ),
          trailing: const Icon(Icons.arrow_right),
          );
        }
      )
    );
  }
}
