import 'package:flutter/material.dart';
import 'package:practica_18/config.dart';
import 'package:practica_18/widgets/rectangle_large.dart';
import 'package:practica_18/widgets/rectangle_medium.dart';
import 'package:practica_18/widgets/rectangle_small.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.colorFondo,
      appBar: AppBar(
        title: const Text('Practica 18 - orientation'),
        backgroundColor: AppConfig.colorPrincipal,
      ),
      body: Center(
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: const {

          },
          children: const [
            TableRow(
              children: [
                RectangleLarge(),
                RectangleMedium(),
                RectangleSmall()
              ]
            ),
            TableRow(
              children: [
                RectangleSmall(),
                 RectangleLarge(),
                RectangleMedium(),

              ]
            ),
            TableRow(
              children: [
                 RectangleMedium(),
                RectangleSmall(),
                RectangleLarge()
              ]
            )
          ],
        ),
      ),
    );
  }
}