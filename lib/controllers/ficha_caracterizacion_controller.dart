import 'package:registro_asistencia_sena_movil/models/ficha_caracterizacion_response.dart';
import 'package:registro_asistencia_sena_movil/services/app_services.dart';

class FichaCaracterizacionController {
  final AppServices appServices = AppServices();

  Future<List<FichaCaracterizacion>> getFichasCaracterizacion(
      String instructorId, String authToken) async {
        final data = await appServices.getFichasCaracterizacion(instructorId, authToken);
        if(data.isNotEmpty){
          return data;
        }
        return [];
      }
}
