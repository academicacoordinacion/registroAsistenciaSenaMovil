// To parse this JSON data, do
//
//     final ambientes = ambientesFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

Ambientes ambientesFromJson(String str) => Ambientes.fromJson(json.decode(str));

String ambientesToJson(Ambientes data) => json.encode(data.toJson());

class Ambientes {
    final List<Ambiente> ambientes;

    Ambientes({
        required this.ambientes,
    });

    factory Ambientes.fromJson(Map<String, dynamic> json) => Ambientes(
        ambientes: List<Ambiente>.from(json["ambientes"].map((x) => Ambiente.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ambientes": List<dynamic>.from(ambientes.map((x) => x.toJson())),
    };
}

class Ambiente {
    final int id;
    final String title;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int pisoId;
    final int userCreateId;
    final int userEditId;
    final int status;

    Ambiente({
        required this.id,
        required this.title,
        required this.createdAt,
        required this.updatedAt,
        required this.pisoId,
        required this.userCreateId,
        required this.userEditId,
        required this.status,
    });

    factory Ambiente.fromJson(Map<String, dynamic> json) => Ambiente(
        id: json["id"],
        title: json["title"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pisoId: json["piso_id"],
        userCreateId: json["user_create_id"],
        userEditId: json["user_edit_id"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "piso_id": pisoId,
        "user_create_id": userCreateId,
        "user_edit_id": userEditId,
        "status": status,
    };
}
