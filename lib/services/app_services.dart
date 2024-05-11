import 'package:dio/dio.dart';
import 'package:registro_asistencia_sena_movil/models/ambiente_response.dart';
import 'package:registro_asistencia_sena_movil/models/piso_response.dart';
import 'package:registro_asistencia_sena_movil/utils/constantes.dart';

class AppServices {
  final dio = Dio(BaseOptions(baseUrl: Constantes.baseUrl));

  Future<List<Ambiente>> getAmbientes(Piso piso) async {
    try {
      final response = await dio.get("${Constantes.baseUrl}/apiCargarAmbientes",
          data: {'piso_id': piso.id});
          
      if (response.statusCode == 200) {
        final ambientes = (response.data as List).map((e) => Ambiente.fromJson(e)).toList();
        return ambientes;
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
