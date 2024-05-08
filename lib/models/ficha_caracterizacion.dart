// To parse this JSON data, do
//
//     final fichaCaracterizacion = fichaCaracterizacionFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

FichaCaracterizacion fichaCaracterizacionFromJson(String str) =>
    FichaCaracterizacion.fromJson(json.decode(str));

String fichaCaracterizacionToJson(FichaCaracterizacion data) =>
    json.encode(data.toJson());

class FichaCaracterizacion {
  final List<Ficha> fichas;

  FichaCaracterizacion({
    required this.fichas,
  });

  factory FichaCaracterizacion.fromJson(Map<String, dynamic> json) =>
      FichaCaracterizacion(
        fichas: List<Ficha>.from(json["fichas"].map((x) => Ficha.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "fichas": List<dynamic>.from(fichas.map((x) => x.toJson())),
      };
}

class Ficha {
  final int id;
  final String ficha;
  final String nombreCurso;
  final dynamic codigoPrograma;
  final dynamic horasFormacion;
  final dynamic cupo;
  final dynamic diasDeFormacion;
  final Instructor instructor;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final String ambiente;
  final String municipio;

  Ficha({
    required this.id,
    required this.ficha,
    required this.nombreCurso,
    required this.codigoPrograma,
    required this.horasFormacion,
    required this.cupo,
    required this.diasDeFormacion,
    required this.instructor,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.ambiente,
    required this.municipio,
  });

  factory Ficha.fromJson(Map<String, dynamic> json) => Ficha(
        id: json["id"],
        ficha: json["ficha"],
        nombreCurso: json["nombre_curso"],
        codigoPrograma: json["codigo_programa"],
        horasFormacion: json["horas_formacion"],
        cupo: json["cupo"],
        diasDeFormacion: json["dias_de_formacion"],
        instructor: Instructor.fromJson(json["Instructor"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        ambiente: json["ambiente"],
        municipio: json["municipio"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ficha": ficha,
        "nombre_curso": nombreCurso,
        "codigo_programa": codigoPrograma,
        "horas_formacion": horasFormacion,
        "cupo": cupo,
        "dias_de_formacion": diasDeFormacion,
        "Instructor": instructor.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "ambiente": ambiente,
        "municipio": municipio,
      };
}

class Instructor {
  final int id;
  final String primerNombre;
  final String segundoNombre;
  final String primerApellido;
  final String segundoApellido;

  Instructor({
    required this.id,
    required this.primerNombre,
    required this.segundoNombre,
    required this.primerApellido,
    required this.segundoApellido,
  });

  factory Instructor.fromJson(Map<String, dynamic> json) => Instructor(
        id: json["id"],
        primerNombre: json["primer_nombre"],
        segundoNombre: json["segundo_nombre"],
        primerApellido: json["primer_apellido"],
        segundoApellido: json["segundo_apellido"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "primer_nombre": primerNombre,
        "segundo_nombre": segundoNombre,
        "primer_apellido": primerApellido,
        "segundo_apellido": segundoApellido,
      };
}
