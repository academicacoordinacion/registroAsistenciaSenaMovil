
import 'package:dio/dio.dart';
import 'package:registro_asistencia_sena_movil/models/login_response.dart';
import 'package:registro_asistencia_sena_movil/utils/constantes.dart';

class SessionServices{
  final dio = Dio(BaseOptions(baseUrl: Constantes.baseUrl));


  Future<LoginResponse?> login(String email, String password) async {
    try {
      final response = await dio.post("${Constantes.baseUrl}/authenticate",
          data: {'email': email, 'password': password});
      if (response.isSuccesfull()) {
        final loginResponse = LoginResponse.fromJson(response.data);
        print("si llego a session services");
        return loginResponse;
      }
      return null;
    } catch (e) {
      print("Error en la autenticacion: ${e}");
      return null;
    }
  }
}


extension ResponseExt on Response {
  bool isSuccesfull() {
    final status = statusCode ?? 400;
    return (status >= 200 && status < 300);
  }
}
