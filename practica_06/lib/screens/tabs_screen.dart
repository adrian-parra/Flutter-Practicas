import 'package:practica_06/config.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({super.key});

  static const double sizeIcons = 100.0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        backgroundColor: AppConfig.colorFondo,
        appBar: AppBar(
          backgroundColor: AppConfig.colorPrincipal,
          title: const Text('Tabs Screen'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.accessibility_new)),
              Tab(icon: Icon(Icons.mail)),
              Tab(icon: Icon(Icons.map)),
              Tab(icon: Icon(Icons.access_alarm)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Card(
                elevation: 4,
                margin: const EdgeInsets.all(AppConfig.marginValue),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Accessibility',
                        style: TextStyle(
                            fontSize: AppConfig.sizeTitulo,
                            color: AppConfig.colorDescripcion)),
                    Icon(Icons.accessibility_new,
                        size: sizeIcons,
                        color: AppConfig.colorPrincipal,
                        semanticLabel: 'Accesibilidad'),
                  ],
                )),
            Card(
                elevation: 4,
                margin: const EdgeInsets.all(AppConfig.marginValue),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Mail',
                        style: TextStyle(
                            fontSize: AppConfig.sizeTitulo,
                            color: AppConfig.colorDescripcion)),
                    Icon(Icons.mail,
                        size: sizeIcons, color: AppConfig.colorPrincipal),
                  ],
                )),
            Card(
                elevation: 4,
                margin: const EdgeInsets.all(AppConfig.marginValue),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Map',
                        style: TextStyle(
                            fontSize: AppConfig.sizeTitulo,
                            color: AppConfig.colorDescripcion)),
                    Icon(Icons.map,
                        size: sizeIcons, color: AppConfig.colorPrincipal),
                  ],
                )),
            Card(
                elevation: 4,
                margin: const EdgeInsets.all(AppConfig.marginValue),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Alarm',
                        style: TextStyle(
                            fontSize: AppConfig.sizeTitulo,
                            color: AppConfig.colorDescripcion)),
                    Icon(Icons.access_alarm,
                        size: sizeIcons, color: AppConfig.colorPrincipal),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
