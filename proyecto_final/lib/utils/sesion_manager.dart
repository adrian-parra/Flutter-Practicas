// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String KEY_NOMBRE = 'nombre';
  static const String KEY_CARGO = 'cargo';
  static const String KEY_UUID = 'uuid';
  static const String KEY_ROL = 'rol';

  static String _rol = '';

  static String get rol => _rol;

  static set rol(String rol) {
    _rol = rol;
  }

  // Guardar información de sesión
  static Future<void> guardarSesion({required String nombre, required String cargo, required String uuid, required String rol}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(KEY_NOMBRE, nombre);
    await prefs.setString(KEY_CARGO, cargo);
    await prefs.setString(KEY_UUID, cargo);
    await prefs.setString(KEY_ROL, rol);

    SessionManager.rol = rol;
  } 

  // Obtener información de sesión
  static Future<Map<String, String>> obtenerSesion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String nombre = prefs.getString(KEY_NOMBRE) ?? '';
    String cargo = prefs.getString(KEY_CARGO) ?? '';
    String uuid = prefs.getString(KEY_UUID) ?? '';
    String rol = prefs.getString(KEY_ROL) ?? '';

    return {'nombre': nombre, 'cargo': cargo,'uuid':uuid,'rol':rol};
  }

  // Borrar información de sesión
  static Future<void> borrarSesion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(KEY_NOMBRE);
    await prefs.remove(KEY_CARGO);
    await prefs.remove(KEY_UUID);
    await prefs.remove(KEY_ROL);

    await prefs.remove('qrGenerado');

  }
}
