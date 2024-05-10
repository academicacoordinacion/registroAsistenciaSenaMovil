// To parse this JSON data, do
//
//     final municipios = municipiosFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

Municipios municipiosFromJson(String str) =>
    Municipios.fromJson(json.decode(str));

String municipiosToJson(Municipios data) => json.encode(data.toJson());

class Municipios {
  final List<Municipio> municipios;

  Municipios({
    required this.municipios,
  });

  factory Municipios.fromJson(Map<String, dynamic> json) => Municipios(
        municipios: List<Municipio>.from(
            json["municipios"].map((x) => Municipio.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "municipios": List<dynamic>.from(municipios.map((x) => x.toJson())),
      };
}

class Municipio {
  final int id;
  final String municipio;
  final int departamentoId;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Municipio({
    required this.id,
    required this.municipio,
    required this.departamentoId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Municipio.fromJson(Map<String, dynamic> json) => Municipio(
        id: json["id"],
        municipio: json["municipio"],
        departamentoId: json["departamento_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "municipio": municipio,
        "departamento_id": departamentoId,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
