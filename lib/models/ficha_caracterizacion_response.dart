// To parse this JSON data, do
//
//     final fichaCaracterizacion = fichaCaracterizacionFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

List<FichaCaracterizacion> fichaCaracterizacionFromJson(String str) =>
    List<FichaCaracterizacion>.from(
        json.decode(str).map((x) => FichaCaracterizacion.fromJson(x)));

String fichaCaracterizacionToJson(List<FichaCaracterizacion> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FichaCaracterizacion {
  final int id;
  final String ficha;
  final String nombreCurso;
  final dynamic codigoPrograma;
  final dynamic horasFormacion;
  final dynamic cupo;
  final dynamic diasDeFormacion;
  final UserCreateId userCreateId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final String regional;

  FichaCaracterizacion({
    required this.id,
    required this.ficha,
    required this.nombreCurso,
    required this.codigoPrograma,
    required this.horasFormacion,
    required this.cupo,
    required this.diasDeFormacion,
    required this.userCreateId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.regional,
  });

  factory FichaCaracterizacion.fromJson(Map<String, dynamic> json) =>
      FichaCaracterizacion(
        id: json["id"],
        ficha: json["ficha"],
        nombreCurso: json["nombre_curso"],
        codigoPrograma: json["codigo_programa"],
        horasFormacion: json["horas_formacion"],
        cupo: json["cupo"],
        diasDeFormacion: json["dias_de_formacion"],
        userCreateId: UserCreateId.fromJson(json["user_create_id"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        regional: json["regional"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ficha": ficha,
        "nombre_curso": nombreCurso,
        "codigo_programa": codigoPrograma,
        "horas_formacion": horasFormacion,
        "cupo": cupo,
        "dias_de_formacion": diasDeFormacion,
        "user_create_id": userCreateId.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "regional": regional,
      };
}

class UserCreateId {
  final String primerNombre;
  final String segundoNombre;
  final String primerApellido;
  final String segundoApellido;

  UserCreateId({
    required this.primerNombre,
    required this.segundoNombre,
    required this.primerApellido,
    required this.segundoApellido,
  });

  factory UserCreateId.fromJson(Map<String, dynamic> json) => UserCreateId(
        primerNombre: json["primer_nombre"],
        segundoNombre: json["segundo_nombre"],
        primerApellido: json["primer_apellido"],
        segundoApellido: json["segundo_apellido"],
      );

  Map<String, dynamic> toJson() => {
        "primer_nombre": primerNombre,
        "segundo_nombre": segundoNombre,
        "primer_apellido": primerApellido,
        "segundo_apellido": segundoApellido,
      };
}
