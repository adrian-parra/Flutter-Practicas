import 'package:flutter/material.dart';
import 'package:practica_09/config.dart';

class ListViewScreen extends StatelessWidget {
  const ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.colorFondo,
      appBar: AppBar(
        title: const Text('Practica 09'),
        centerTitle: true,
        backgroundColor: AppConfig.colorDanger,
      ),
      body: ListView(
        children: generateListTiles([
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
        ]),
      ),
    );
  }

  List<ListTile> generateListTiles(List<String> titles) {
    List<ListTile> listTiles = [];
    int i = 0;

    for (String title in titles) {
      i++;
      listTiles.add(
        ListTile(
          contentPadding:
              const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 0.0),
          title: Text('$i- $title'),
          leading: const CircleAvatar(
            radius: 22.0,
            backgroundImage: NetworkImage(
                'https://img1.freepng.es/20171220/kqw/pokeball-png-5a3a4a7e247ce7.9167778215137695981495.jpg'),
          ),
          trailing: const Icon(Icons.arrow_right),
          onTap: () {},
        ),
      );
    }

    return listTiles;
  }
}
