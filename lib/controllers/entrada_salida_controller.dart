import 'package:registro_asistencia_sena_movil/models/entrada_salida_response.dart';
import 'package:registro_asistencia_sena_movil/services/app_services.dart';

class EntradaSalidaController {
  AppServices appServices = AppServices();

  Future<List<EntradaSalida>> apiIndex(String instructorId, String fichaId, String authToken) async
  {
    final data = await appServices.getEntradaSalida(
        instructorId,
        fichaId,
        authToken);
    if (data.isNotEmpty) {
      return data;
    }
    return [];
  }
  Future<bool> listarEntradaSalida(String instructorId, String fichaCaracterizacionId, String ambienteId, String authToken) async {
    try {
      final response = await appServices.apiListarEntradaSalida(instructorId, fichaCaracterizacionId, ambienteId, authToken);
      if (response != false) {
        return true;
      }
      return false;
    } catch (e) {
      // Manejo de excepciones, puedes imprimir el error o registrar en algún lugar.
      print('Error al listar entrada y salida: $e');
      return false;
    }
  }
  
  Future<bool> apiStoreEntradaSalida(String fichaId, String aprendiz,
      String instructorId, String ambienteId, String authToken) async {
    final data = await appServices.apiStoreEntradaSalida(
        fichaId, aprendiz, instructorId, ambienteId, authToken);
    if (data) {
      return true;
    }
    return false;
  }

  Future<bool> apiUpdateEntradaSalida(String aprendiz, String authToken) async {
    final data = await appServices.apiUpdateEntradaSalida(aprendiz, authToken);
    if (data) {
      return true;
    }
    return false;
  }
}
