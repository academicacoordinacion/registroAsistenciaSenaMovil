// To parse this JSON data, do
//
//     final pisos = pisosFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

Pisos pisosFromJson(String str) => Pisos.fromJson(json.decode(str));

String pisosToJson(Pisos data) => json.encode(data.toJson());

class Pisos {
    final List<Piso> pisos;

    Pisos({
        required this.pisos,
    });

    factory Pisos.fromJson(Map<String, dynamic> json) => Pisos(
        pisos: List<Piso>.from(json["pisos"].map((x) => Piso.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "pisos": List<dynamic>.from(pisos.map((x) => x.toJson())),
    };
}

class Piso {
    final int id;
    final String piso;
    final int bloqueId;
    final int userCreateId;
    final int userEditId;
    final int status;
    final DateTime createdAt;
    final DateTime updatedAt;

    Piso({
        required this.id,
        required this.piso,
        required this.bloqueId,
        required this.userCreateId,
        required this.userEditId,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Piso.fromJson(Map<String, dynamic> json) => Piso(
        id: json["id"],
        piso: json["piso"],
        bloqueId: json["bloque_id"],
        userCreateId: json["user_create_id"],
        userEditId: json["user_edit_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "piso": piso,
        "bloque_id": bloqueId,
        "user_create_id": userCreateId,
        "user_edit_id": userEditId,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
