
import 'package:registro_asistencia_sena_movil/models/ambiente_response.dart';
import 'package:registro_asistencia_sena_movil/services/app_services.dart';

class AmbienteController{
  AppServices appServices = AppServices();

  Future<List<Ambiente>> getAmbientes(String regionalId, String authToken) async{
    final data = await appServices.getAmbientes(regionalId, authToken);
    if (data.isNotEmpty){
      return data;
    }
    return data;
  }
}