import 'package:flutter/material.dart';
import 'package:practica_08/config.dart';
import 'package:practica_08/widgets/drawer_widget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:AppConfig.colorPrincipal ,
        centerTitle: true,
        title:const Text('Practica 08'),
      ),
      body: Container(
        color: AppConfig.colorFondo,
      ),
      drawer: const Drawer(
        child: DrawerWidget(),
      ),
    );
  }
}