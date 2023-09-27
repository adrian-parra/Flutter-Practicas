import 'package:flutter/material.dart';
import 'package:practica_08/config.dart';

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
                backgroundImage: NetworkImage(
                  'https://www.facebook.com/images/fb_logo/app-facebook-circle-bp.png'
                ),
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
          onTap: (){},
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
          onTap: (){},
          leading: const Icon(
            Icons.inbox ,
            color: AppConfig.colorExtra,
          ),
          title: const Text(
            'Mensajería',
            style: TextStyle(
              color: AppConfig.colorDescripcion
            ),
            )
          ,
        ),
        ListTile(
          onTap: (){},
          leading: const Icon(
            Icons.dashboard ,
            color: AppConfig.colorExtra,
          ),
          title: const Text(
            'Dashboard',
            style: TextStyle(
              color: AppConfig.colorDescripcion
            ),
          ),
        ),
        ListTile(
          onTap: (){},
          leading: const Icon(
            Icons.settings ,
            color: AppConfig.colorExtra,
          ),
          title: const Text(
            'Configuración',
            style: TextStyle(
              color: AppConfig.colorDescripcion
            ),
            ),
        )
      ],
    );
  }
}
