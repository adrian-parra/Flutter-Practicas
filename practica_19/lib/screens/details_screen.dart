import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:practica_19/config.dart';
import 'package:practica_19/screens/pdf_preview_screen.dart';
import 'package:practica_19/widgets/details_container.dart';
import 'package:practica_19/widgets/head_container.dart';

import 'package:permission_handler/permission_handler.dart';

class DetailsScreen extends StatelessWidget {
  var datosName;
  var datosGender;
  String? datosImage;
  String? path;
  DetailsScreen({super.key,this.datosName,this.datosGender,this.datosImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.colorFondo,
      appBar: AppBar(
        title: Text(datosName + ' Details'),
        backgroundColor: AppConfig.colorPrincipal,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: AppConfig.colorFondo,
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            MyHeadContainer(imagerec: datosImage,),
            MyDetailContainer(nom: datosName,sexo: datosGender,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppConfig.colorDanger,
        child: const Icon(Icons.print_outlined),
        onPressed: () {
            downloadImageL();

          // Future.delayed(
          //   Duration(milliseconds: 3000),
          //   () => Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => PdfScreen(
          //       nombre: datosName,
          //       genero: datosGender,
          //       imagenUrl: path,
          //     ))
          //    )
          // );
        },
      ),
    );


  }

  downloadImageL() async{
    // try {
  // Saved with this method.
//   var imageId = await ImageDownloader.downloadImage("https://raw.githubusercontent.com/wiki/ko2ic/image_downloader/images/flutter.png");
//   if (imageId == null) {
//     return;
//   }

//   // Below is a method of obtaining saved image information.
//   var fileName = await ImageDownloader.findName(imageId);
//   var path = await ImageDownloader.findPath(imageId);
//   var size = await ImageDownloader.findByteSize(imageId);
//   var mimeType = await ImageDownloader.findMimeType(imageId);
// } catch (error) {
//   print('loal '+ error.toString());
// }
    // try {
    //   print('loal1 '+ datosImage.toString());
    //   var imageId = await ImageDownloader.downloadImage(datosImage!.toString());
    //   path = await ImageDownloader.findPath(imageId!);
    //   print(path);
    // } catch (e) {
    //   print('loal '+ e.toString());
    // }

    try {
  // Solicitar permisos de almacenamiento
  var status = await Permission.storage.request();
  if (status.isGranted) {
    print('Permiso de almacenamiento concedido.');
    
    // Código para descargar la imagen
    var imageId = await ImageDownloader.downloadImage(datosImage!.toString());
    
    // Código para obtener la ruta del archivo descargado
    path = await ImageDownloader.findPath(imageId!);
    
    print('Ruta del archivo descargado: $path');
  } else {
    print('Permiso de almacenamiento denegado.');
  }
} catch (e) {
  
    print('Error general: $e');
  
}
  }
}