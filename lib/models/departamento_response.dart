// To parse this JSON data, do
//
//     final departamento = departamentoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Departamento> departamentoFromJson(String str) => List<Departamento>.from(json.decode(str).map((x) => Departamento.fromJson(x)));

String departamentoToJson(List<Departamento> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Departamento {
    final int id;
    final String departamento;
    final int paisId;
    final int status;
    final DateTime createdAt;
    final DateTime updatedAt;

    Departamento({
        required this.id,
        required this.departamento,
        required this.paisId,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    Departamento copyWith({
        int? id,
        String? departamento,
        int? paisId,
        int? status,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Departamento(
            id: id ?? this.id,
            departamento: departamento ?? this.departamento,
            paisId: paisId ?? this.paisId,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Departamento.fromJson(Map<String, dynamic> json) => Departamento(
        id: json["id"],
        departamento: json["departamento"],
        paisId: json["pais_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "departamento": departamento,
        "pais_id": paisId,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}