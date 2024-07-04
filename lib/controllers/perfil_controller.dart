

import 'package:registro_asistencia_sena_movil/models/login_response.dart';
import 'package:registro_asistencia_sena_movil/services/app_services.dart';

class PerfilController{
  final AppServices appServices = AppServices();
  

  Future<LoginResponse?> apiUpdatePerfil(
      String personaID,
      String tipoDocumento,
      String numeroDocumento,
      String primerNombre,
      String? segundoNombre,
      String primerApellido,
      String? segundoApellido,
      String fechaDeNacimiento,
      String genero,
      String email,
      String authToken) async {
    try {
      final data = await appServices.updatePerfil(
          personaID,
          tipoDocumento,
          numeroDocumento,
          primerNombre,
          segundoNombre,
          primerApellido,
          segundoApellido,
          fechaDeNacimiento,
          genero,
          email,
          authToken);
      return data;
    } catch (e) {
      print("Error en la actualizacion:  ${e}");
    }
  }
}