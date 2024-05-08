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
  final int instructorAsignado;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final int ambienteId;

  Ficha({
    required this.id,
    required this.ficha,
    required this.nombreCurso,
    required this.codigoPrograma,
    required this.horasFormacion,
    required this.cupo,
    required this.diasDeFormacion,
    required this.instructorAsignado,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.ambienteId,
  });

  factory Ficha.fromJson(Map<String, dynamic> json) => Ficha(
        id: json["id"],
        ficha: json["ficha"],
        nombreCurso: json["nombre_curso"],
        codigoPrograma: json["codigo_programa"],
        horasFormacion: json["horas_formacion"],
        cupo: json["cupo"],
        diasDeFormacion: json["dias_de_formacion"],
        instructorAsignado: json["instructor_asignado"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        ambienteId: json["ambiente_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ficha": ficha,
        "nombre_curso": nombreCurso,
        "codigo_programa": codigoPrograma,
        "horas_formacion": horasFormacion,
        "cupo": cupo,
        "dias_de_formacion": diasDeFormacion,
        "instructor_asignado": instructorAsignado,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "ambiente_id": ambienteId,
      };
}
