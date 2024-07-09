import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:registro_asistencia_sena_movil/models/login_response.dart';
import 'package:registro_asistencia_sena_movil/utils/constantes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionServices {
  final dio = Dio(BaseOptions(baseUrl: Constantes.baseUrl));

  Future<LoginResponse?> login(String email, String password) async {
    try {
      final response = await dio.post("${Constantes.baseUrl}/authenticate",
          data: {'email': email, 'password': password});
      if (response.isSuccesfull()) {
        final loginResponse = LoginResponse.fromJson(response.data);
        return loginResponse;
      }
      return null;
    } catch (e) {
      print("Error en la autenticacion: ${e}");
      return null;
    }
  }

  Future<bool> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Comprobación previa del loginResponse
    String? loginResponse = prefs.getString('loginResponse');

    await prefs.remove('loginResponse');

    // Comprobación posterior del loginResponse
    loginResponse = prefs.getString('loginResponse');
    if (loginResponse == null) {
      try {
        final response = await dio.post("${Constantes.baseUrl}/logout");
        if (response.isSuccesfull()) {
          return true;
        }
        return false;
      } catch (e) {
        // Manejo de errores
        print("No es posible cerrar sesión. Error: $e");
        return false;
      }
    } else {
      return false;
    }
  }
}

extension ResponseExt on Response {
  bool isSuccesfull() {
    final status = statusCode ?? 400;
    return (status >= 200 && status < 300);
  }
}
