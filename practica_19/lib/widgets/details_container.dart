import 'package:flutter/material.dart';
import 'package:practica_19/config.dart';

class MyDetailContainer extends StatelessWidget {
  String? sexo;
  String? nom;

  MyDetailContainer({super.key ,this.nom,this.sexo});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30,right: 30,top: 10),
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color(0xffff422c),
            Color(0xffff9003)
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.25,0.90]
        ),
        boxShadow: const [
          BoxShadow(
            color:AppConfig.colorExtra,
            offset: Offset(-12,12),
            blurRadius: 8,

          ),
        ]
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(AppConfig.paddingValue * 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text('Nombre ',
            style: TextStyle(
              fontSize: 25,
              color: AppConfig.colorSecundario,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal
            ),
          ),
          const SizedBox(height: AppConfig.gap),
          Center(
            child: Text('$nom ',
            style: const TextStyle(
              fontSize: 25,
              color: AppConfig.colorSecundario,
              fontWeight: FontWeight.w200,
              fontStyle: FontStyle.italic
            ),
            ),
          ),
          const SizedBox(
            height: AppConfig.gap,
          ),
          const Text(
            'Genero: ',
            style: TextStyle(
              fontSize: 25,
              color: AppConfig.colorSecundario,
              fontStyle: FontStyle.normal
            ),
          ),
          const SizedBox(height: AppConfig.gap,),
          Center(
            child: Text('$sexo ',
              style: const TextStyle(
                fontSize: 25,
                color: AppConfig.colorSecundario,
                fontWeight: FontWeight.w200,
                fontStyle: FontStyle.italic
              ),
            ),
          )
        ],
      ),
    );
  }
}