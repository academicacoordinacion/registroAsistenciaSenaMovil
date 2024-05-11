// To parse this JSON data, do
//
//     final municipio = municipioFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

List<Municipio> municipioFromJson(String str) => List<Municipio>.from(json.decode(str).map((x) => Municipio.fromJson(x)));

String municipioToJson(List<Municipio> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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

    Municipio copyWith({
        int? id,
        String? municipio,
        int? departamentoId,
        int? status,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Municipio(
            id: id ?? this.id,
            municipio: municipio ?? this.municipio,
            departamentoId: departamentoId ?? this.departamentoId,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

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