import 'package:flutter/material.dart';
import 'package:proyecto_final/config.dart';
import 'package:proyecto_final/widgets/drawer_widget.dart';


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
        title:const Text('Inicio'),
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