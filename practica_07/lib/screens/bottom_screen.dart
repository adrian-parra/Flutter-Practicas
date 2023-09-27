import 'package:flutter/material.dart';
import 'package:practica_07/config.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreen();
}

class _BottomNavigationScreen extends State<BottomNavigationScreen> {
  int _currentIndex = 0;

  final tabs = [
    const Center(
      child: Text('Mapa',style: TextStyle(color: AppConfig.colorDescripcion ,fontSize: AppConfig.sizeTitulo),),
    ),
    const Center(
      child: Text('E-mail',style: TextStyle(color: AppConfig.colorDescripcion ,fontSize: AppConfig.sizeTitulo),),
    ),
    const Center(
      child: Text('Alarma',style: TextStyle(color: AppConfig.colorDescripcion ,fontSize: AppConfig.sizeTitulo),),
    )
    
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.colorFondo,
      appBar: AppBar(
        backgroundColor: AppConfig.colorPrincipal,
        title: const Text('Practica 07'),
        centerTitle: true,
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppConfig.colorPrincipal,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'E-mail'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: 'Alarma'
          )
        ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}