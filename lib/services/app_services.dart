import 'package:dio/dio.dart';
import 'package:registro_asistencia_sena_movil/models/ambiente_response.dart';
import 'package:registro_asistencia_sena_movil/models/bloque_response.dart';
import 'package:registro_asistencia_sena_movil/models/departamento_response.dart';
import 'package:registro_asistencia_sena_movil/models/municipio_response.dart';
import 'package:registro_asistencia_sena_movil/models/piso_response.dart';
import 'package:registro_asistencia_sena_movil/models/sede_response.dart';
import 'package:registro_asistencia_sena_movil/utils/constantes.dart';

class AppServices {
  final dio = Dio(BaseOptions(baseUrl: Constantes.baseUrl));

// Funcion para cargar municipios
  Future<List<Municipio>> getMunicipios(Departamento departamento) async {
    try {
      final response = await dio.get(
          "${Constantes.baseUrl}/apiCargarMunicipios",
          data: {"departamento_id" : departamento.id});
      if (response.isSuccesfull()) {
        final municipios = (response.data as List).map((e) => Municipio.fromJson(e)).toList();
        // print("primer ");
        // print(municipios);
        return municipios;
      }
      return [];
    } catch (e) {
      // print(e);
      return [];
    }
  }

// Funcion para cargar sedes
  Future<List<Sede>> getSedes(Municipio municipio) async {
    try {
      final response = await dio.get("${Constantes.baseUrl}/apiCargarSedes",
          data: {"municipio_id": municipio.id});
      if (response.isSuccesfull()) {
        final sedes =
            (response.data as List).map((e) => Sede.fromJson(e)).toList();
        return sedes;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

// Funcion para cargar los bloques
  Future<List<Bloque>> getBloques(Sede sede) async {
    try {
      final reponse = await dio.get("${Constantes.baseUrl}/apiCargarBloques",
          data: {"sede_id": sede.id});
      if (reponse.isSuccesfull()) {
        final bloques =
            (reponse.data as List).map((e) => Bloque.fromJson(e)).toList();
        return bloques;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

// Function para cargar los pisos
  Future<List<Piso>> getPisos(Bloque bloque) async {
    try {
      final response = await dio.get("${Constantes.baseUrl}/apiCargarPisos",
          data: {'bloque_id': bloque.id});
      if (response.isSuccesfull()) {
        final pisos =
            (response.data as List).map((e) => Piso.fromJson(e)).toList();
        return pisos;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

// function para cargar los ambientes
  Future<List<Ambiente>> getAmbientes(Piso piso) async {
    try {
      final response = await dio.get("${Constantes.baseUrl}/apiCargarAmbientes",
          data: {'piso_id': piso.id});

      if (response.isSuccesfull()) {
        final ambientes =
            (response.data as List).map((e) => Ambiente.fromJson(e)).toList();
        return ambientes;
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}

extension ResponseExt on Response {
  bool isSuccesfull() {
    final status = statusCode ?? 400;
    return (status >= 200 && status < 300);
  }
}
