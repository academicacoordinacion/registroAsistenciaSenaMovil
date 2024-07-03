import 'package:dio/dio.dart';
import 'package:registro_asistencia_sena_movil/models/ambiente_response.dart';
import 'package:registro_asistencia_sena_movil/models/bloque_response.dart';
import 'package:registro_asistencia_sena_movil/models/departamento_response.dart';
import 'package:registro_asistencia_sena_movil/models/entrada_salida_response.dart';
import 'package:registro_asistencia_sena_movil/models/ficha_caracterizacion_response.dart';
import 'package:registro_asistencia_sena_movil/models/genero_response.dart';
import 'package:registro_asistencia_sena_movil/models/login_response.dart';
import 'package:registro_asistencia_sena_movil/models/municipio_response.dart';
import 'package:registro_asistencia_sena_movil/models/piso_response.dart';
import 'package:registro_asistencia_sena_movil/models/sede_response.dart';
import 'package:registro_asistencia_sena_movil/models/tipo_de_documentos_response.dart';
import 'package:registro_asistencia_sena_movil/utils/constantes.dart';

class AppServices {
  final dio = Dio(BaseOptions(baseUrl: Constantes.baseUrl));

// Funcion para cargar municipios
  Future<List<Municipio>> getMunicipios(Departamento departamento) async {
    try {
      final response = await dio.get(
          "${Constantes.baseUrl}/apiCargarMunicipios",
          data: {"departamento_id": departamento.id});
      if (response.isSuccesfull()) {
        final municipios =
            (response.data as List).map((e) => Municipio.fromJson(e)).toList();
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
  Future<List<Ambiente>> getAmbientes(int regionalID, String authToken) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $authToken';
      final response = await dio.get("${Constantes.baseUrl}/apiCargarAmbientes",
          data: {'regional_id': regionalID});
      if (response.isSuccesfull()) {
        final ambientes =
            (response.data as List).map((e) => Ambiente.fromJson(e)).toList();
        // print(ambientes);
        return ambientes;
      }
      return [];
    } catch (e) {
      print("error al traer los ambientes: error: ${e}");
      return [];
    }
  }

  // funcion para cargar las fichas de caracterizacion
  Future<List<FichaCaracterizacion>> getFichasCaracterizacion(
      int instructorId, String authToken) async {
    //     print("hola mundo");
    // print("print de instructor id: ${instructorId}");
    // print("hola mundo");
    try {
      dio.options.headers['Authorization'] = 'Bearer $authToken';
      final response = await dio.get(
          "${Constantes.baseUrl}/fichaCaracterizacion/apiIndex/",
          data: {"instructor_id": instructorId});
      if (response.isSuccesfull()) {
        final fichasCaracterizacion = (response.data as List)
            .map((e) => FichaCaracterizacion.fromJson(e))
            .toList();
        // print(fichasCaracterizacion);
        return fichasCaracterizacion;
      } else {
        return [];
      }
      // return [];
    } catch (e) {
      print("error al traer las fichas de caracterizacion : error: ${e}");
      return [];
    }
  }

// Funcion para cargar los registros de entrada salida
  Future<List<EntradaSalida>> getEntradaSalida(
      String instructorId, String fichaId, String authToken) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $authToken';
      final response = await dio.get(
          "${Constantes.baseUrl}/entradaSalida/apiIndex",
          data: {"ficha_id": fichaId, "instructor_id": instructorId});
      if (response.isSuccesfull()) {
        final entradaSalida = (response.data as List)
            .map((e) => EntradaSalida.fromJson(e))
            .toList();
        return entradaSalida;
      }
      print(
          "error en la respuesta: ${response.statusCode} - ${response.statusMessage}");
      return [];
    } catch (e) {
      print("error en la solicitud: $e");
      return [];
    }
  }

  Future<bool> apiStoreEntradaSalida(
      String fichaId, String aprendiz, String instructorId, String ambienteId, String authToken) async {
        print("hola mundo. ${ambienteId}");
    try {
      dio.options.headers['Authorization'] = 'Bearer $authToken';
      final response = await dio.post(
          "${Constantes.baseUrl}/entradaSalida/apiStoreEntradaSalida",
          data: {
            "ficha_caracterizacion_id": fichaId,
            "aprendiz": aprendiz,
            "instructor_user_id": instructorId,
            "ambiente_id" : ambienteId,
          });
      if (response.isSuccesfull()) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> apiUpdateEntradaSalida(String aprendiz,String authToken ) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $authToken';
      final response = await dio.post(
          "${Constantes.baseUrl}/entradaSalida/apiUpdateEntradaSalida",
          data: {
            "aprendiz": aprendiz,
          });
      if (response.isSuccesfull()) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<LoginResponse?> updatePerfil(
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
        print("la fecha de nacimiento es: ${fechaDeNacimiento}");
    try {
      dio.options.headers['Authorization'] = 'Bearer $authToken';
      final response =
          await dio.post("${Constantes.baseUrl}/instructor/apiUpdate", data: {
        "persona_id": personaID,
        "tipo_documento": tipoDocumento,
        "numero_documento": numeroDocumento,
        "primer_nombre": primerNombre,
        "segundo_nombre": segundoNombre,
        "primer_apellido": primerApellido,
        "segundo_apellido": segundoApellido,
        "fecha_de_nacimiento": fechaDeNacimiento,
        "genero": genero,
        "email": email
      });
         
      if (response.isSuccesfull()) {
        final loginResponse = LoginResponse.fromJson(response.data);
        return loginResponse;
      }
      // return [];
    } catch (e) {
      print("error al actualizar el perfil: estes es el errorcito: ${e}");
      // return [];
    }
  }

  Future<List<TipoDocumentoResponse>> apiGetTipoDocumentos(
      String authToken) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $authToken';
      final response =
          await dio.get("${Constantes.baseUrl}/apiGetTipoDocumentos");
      if (response.isSuccesfull()) {
        final tipoDocumentoResponse = (response.data as List)
            .map((e) => TipoDocumentoResponse.fromJson(e))
            .toList();
        return tipoDocumentoResponse;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<List<GeneroResponse>> apiGetGeneros(
      String authToken) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $authToken';
      final response =
          await dio.get("${Constantes.baseUrl}/apiGetGeneros");
      if (response.isSuccesfull()) {
        final generosResponse = (response.data as List)
            .map((e) => GeneroResponse.fromJson(e))
            .toList();
        return generosResponse;
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
