// To parse this JSON data, do
//
//     final bloques = bloquesFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

Bloques bloquesFromJson(String str) => Bloques.fromJson(json.decode(str));

String bloquesToJson(Bloques data) => json.encode(data.toJson());

class Bloques {
    final List<Bloque> bloques;

    Bloques({
        required this.bloques,
    });

    factory Bloques.fromJson(Map<String, dynamic> json) => Bloques(
        bloques: List<Bloque>.from(json["bloques"].map((x) => Bloque.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "bloques": List<dynamic>.from(bloques.map((x) => x.toJson())),
    };
}

class Bloque {
    final int id;
    final String bloque;
    final int sedeId;
    final int userCreateId;
    final int userEditId;
    final int status;
    final DateTime createdAt;
    final DateTime updatedAt;

    Bloque({
        required this.id,
        required this.bloque,
        required this.sedeId,
        required this.userCreateId,
        required this.userEditId,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Bloque.fromJson(Map<String, dynamic> json) => Bloque(
        id: json["id"],
        bloque: json["bloque"],
        sedeId: json["sede_id"],
        userCreateId: json["user_create_id"],
        userEditId: json["user_edit_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "bloque": bloque,
        "sede_id": sedeId,
        "user_create_id": userCreateId,
        "user_edit_id": userEditId,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
