

import 'package:registro_asistencia_sena_movil/models/login_response.dart';
import 'package:registro_asistencia_sena_movil/services/session_services.dart';

class LoginController{
  final SessionServices sessionServices = SessionServices();

  Future<LoginResponse?> login(String email, String password) async{
    final data = await sessionServices.login(email, password);
    if(data != null){
      return data;
    }
    return null;
  }

}