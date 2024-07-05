
import 'package:registro_asistencia_sena_movil/models/genero_response.dart';
import 'package:registro_asistencia_sena_movil/models/tipo_de_documentos_response.dart';
import 'package:registro_asistencia_sena_movil/services/app_services.dart';

class ParametroController{
  
  AppServices appServices = AppServices();

  Future<List<GeneroResponse>?> apiGetGeneros(String authToken) async {
    try {
      final data = await appServices.apiGetGeneros(authToken);
      return data.isNotEmpty ? data : null;
    } catch (e) {
      print("Error fetching generos: $e");
      return null;
    }
  }

  Future<List<TipoDocumentoResponse>?> apiGetTipoDocumentos(
      String authToken) async {
    try {
      final data = await appServices.apiGetTipoDocumentos(authToken);
      return data.isNotEmpty ? data : null;
    } catch (e) {
      print("Error fetching tipoDocumentos: $e");
      return null;
    }
  }
}