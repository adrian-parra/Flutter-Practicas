import 'package:flutter/material.dart';
import 'package:practica_19/config.dart';
import 'package:practica_19/screens/details_screen.dart';

class MyListTile extends StatelessWidget {
  var titulo;
  var subtitulo;
  String? imagenFin;

  MyListTile({super.key, this.titulo ,this.subtitulo ,this.imagenFin});

  @override
  Widget build(BuildContext context) {
    return Container(

      width: double.infinity,
      height: 80,
      margin: const EdgeInsets.only(left: 10,right: 10,top: 5 ,bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        gradient: const LinearGradient(
          colors:  [
            AppConfig.colorSecundario,
            AppConfig.colorSecundario
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.25,0.90]
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(-5,5),
            blurRadius: 8
          )
        ]
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(AppConfig.paddingValue - 10),
      child: ListTile(
        tileColor: AppConfig.colorExtra,
        title: Text(titulo ,style: const TextStyle(
          color: AppConfig.colorPrincipal
        ),),
        subtitle: Text(subtitulo),
        trailing: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(imagenFin!),
        ),
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(
                datosName: titulo,
                datosGender: subtitulo,
                datosImage: imagenFin,
              )
            )
          );
        },
      ),
    );
  }
}