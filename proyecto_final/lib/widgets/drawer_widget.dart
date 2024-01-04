import 'package:flutter/material.dart';
import 'package:proyecto_final/config.dart';
import 'package:proyecto_final/screens/generar_qr_screen.dart';
import 'package:proyecto_final/screens/profile_screen.dart';
import 'package:proyecto_final/screens/qr_generado_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top:AppConfig.paddingValue * 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              CircleAvatar(
                radius: 50,
                backgroundColor: AppConfig.colorSecundario,
                backgroundImage: AssetImage('assets/profile_male.png'),
              ),
              SizedBox(
                height: AppConfig.gap,
              ),
              Text(
                'Adrian Parra',
                style: TextStyle(
                  fontSize: AppConfig.sizeTitulo,
                  color: AppConfig.colorExtra
                ),
              ),
              SizedBox(
                height: AppConfig.gap,
              ),
              Text(
                'Alumno',
                style: TextStyle(
                  fontSize: AppConfig.sizeSubtitulo,
                  color: AppConfig.colorDescripcion
                ),
              ),
              SizedBox(
                height: AppConfig.gap,
              ),
            ],
          ),
        ),
        ListTile(
          onTap: (){
            Navigator.pop(context); // Cerrar el Drawer
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          },
          leading: const Icon(
            Icons.person ,
            color: AppConfig.colorExtra,
          ),
            title: const Text(
              'Perfil',
              style: TextStyle(
                color: AppConfig.colorDescripcion
              ),
              ),
        ),
        ListTile(
          onTap: (){
             Navigator.pop(context); // Cerrar el Drawer
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GenerarQrScreen()),
            );
          },
          leading: const Icon(
            Icons.qr_code ,
            color: AppConfig.colorExtra,
          ),
          title: const Text(
            'QR de acceso',
            style: TextStyle(
              color: AppConfig.colorDescripcion
            ),
            )
          ,
        ),
        // ListTile(
        //   onTap: (){},
        //   leading: const Icon(
        //     Icons.dashboard ,
        //     color: AppConfig.colorExtra,
        //   ),
        //   title: const Text(
        //     'Dashboard',
        //     style: TextStyle(
        //       color: AppConfig.colorDescripcion
        //     ),
        //   ),
        // ),
        ListTile(
          onTap: (){
            Navigator.pop(context); // Cerrar el Drawer
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const QrGenerado()),
            );
          },
          leading: const Icon(
            Icons.qr_code_2_sharp ,
            color: AppConfig.colorExtra,
          ),
          title: const Text(
            'QR generado',
            style: TextStyle(
              color: AppConfig.colorDescripcion
            ),
            ),
        )
      ],
    );
  }
}