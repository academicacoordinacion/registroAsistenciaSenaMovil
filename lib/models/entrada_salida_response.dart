// To parse this JSON data, do
//
//     final entradaSalida = entradaSalidaFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<EntradaSalida> entradaSalidaFromJson(String str) =>
    List<EntradaSalida>.from(
        json.decode(str).map((x) => EntradaSalida.fromJson(x)));

String entradaSalidaToJson(List<EntradaSalida> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EntradaSalida {
  final int id;
  final DateTime fecha;
  final int instructorUserId;
  final String aprendiz;
  final String entrada;
  final dynamic salida;
  final DateTime createdAt;
  final dynamic updatedAt;
  final int fichaCaracterizacionId;
  final dynamic listado;
  final int ambienteId;

  EntradaSalida({
    required this.id,
    required this.fecha,
    required this.instructorUserId,
    required this.aprendiz,
    required this.entrada,
    required this.salida,
    required this.createdAt,
    required this.updatedAt,
    required this.fichaCaracterizacionId,
    required this.listado,
    required this.ambienteId,
  });

  factory EntradaSalida.fromJson(Map<String, dynamic> json) => EntradaSalida(
        id: json["id"],
        fecha: DateTime.parse(json["fecha"]),
        instructorUserId: json["instructor_user_id"],
        aprendiz: json["aprendiz"],
        entrada: json["entrada"],
        salida: json["salida"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        fichaCaracterizacionId: json["ficha_caracterizacion_id"],
        listado: json["listado"],
        ambienteId: json["ambiente_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fecha":
            "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
        "instructor_user_id": instructorUserId,
        "aprendiz": aprendiz,
        "entrada": entrada,
        "salida": salida,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
        "ficha_caracterizacion_id": fichaCaracterizacionId,
        "listado": listado,
        "ambiente_id": ambienteId,
      };
}
