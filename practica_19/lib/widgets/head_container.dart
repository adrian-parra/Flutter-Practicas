import 'package:flutter/material.dart';
import 'package:practica_19/config.dart';

class MyHeadContainer extends StatelessWidget {

  String? imagerec;


  MyHeadContainer({super.key,this.imagerec});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 30,
        left: 30,
        right: 30,
        bottom: 15
      ),
      height: 160,
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            AppConfig.colorDanger,
            AppConfig.colorWarning
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.25,0.90]
          
        ),
        boxShadow: const [
          BoxShadow(
            color: AppConfig.colorExtra,
            offset: Offset(-12, 12),
            blurRadius: 8
          )
        ]
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(AppConfig.paddingValue),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            imagerec!,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}