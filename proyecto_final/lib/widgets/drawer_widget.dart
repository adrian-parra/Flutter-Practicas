import 'package:flutter/material.dart';
import 'package:proyecto_final/config.dart';
import 'package:proyecto_final/screens/generar_qr_screen.dart';
import 'package:proyecto_final/screens/profile_screen.dart';
import 'package:proyecto_final/screens/qr_generado_screen.dart';

import '../utils/sesion_manager.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: AppConfig.paddingValue * 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: AppConfig.colorSecundario,
                backgroundImage: AssetImage('assets/profile_male.png'),
              ),
              const SizedBox(
                height: AppConfig.gap,
              ),
              FutureBuilder<Map<String, String>>(
                future: SessionManager.obtenerSesion(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      String? nombre = snapshot.data!['nombre'];
                      String? cargo = snapshot.data!['cargo'];
                      String? rol = snapshot.data!['rol'];

                      if (rol == 'invitado') {
                        nombre = 'INVITADO';
                        cargo = 'ANÓNIMO';
                      }

                      return Column(
                        children: [
                          Text(
                            nombre!,
                            style: const TextStyle(
                              fontSize: AppConfig.sizeTitulo,
                              color: AppConfig.colorExtra,
                            ),
                          ),
                          const SizedBox(
                            height: AppConfig.gap,
                          ),
                          Text(
                            cargo!,
                            style: const TextStyle(
                              fontSize: AppConfig.sizeSubtitulo,
                              color: AppConfig.colorDescripcion,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Text('Error al obtener la sesión');
                    }
                  } else {
                    return const CircularProgressIndicator(); // O cualquier indicador de carga
                  }
                },
              ),
              const SizedBox(
                height: AppConfig.gap,
              ),
            ],
          ),
        ),
        Visibility(
          visible: SessionManager.rol == 'usuario',
          child: ListTile(
            onTap: () {
              Navigator.pop(context); // Cerrar el Drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            leading: const Icon(
              Icons.person,
              color: AppConfig.colorExtra,
            ),
            title: const Text(
              'Perfil',
              style: TextStyle(color: AppConfig.colorDescripcion),
            ),
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.pop(context); // Cerrar el Drawer
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GenerarQrScreen()),
            );
          },
          leading: const Icon(
            Icons.qr_code,
            color: AppConfig.colorExtra,
          ),
          title: const Text(
            'Generar QR',
            style: TextStyle(color: AppConfig.colorDescripcion),
          ),
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
          onTap: () {
            Navigator.pop(context); // Cerrar el Drawer
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const QrGenerado()),
            );
          },
          leading: const Icon(
            Icons.qr_code_2_sharp,
            color: AppConfig.colorExtra,
          ),
          title: const Text(
            'QR generado',
            style: TextStyle(color: AppConfig.colorDescripcion),
          ),
        )
      ],
    );
  }
}
