// To parse this JSON data, do
//
//     final bloque = bloqueFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

List<Bloque> bloqueFromJson(String str) => List<Bloque>.from(json.decode(str).map((x) => Bloque.fromJson(x)));

String bloqueToJson(List<Bloque> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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

    Bloque copyWith({
        int? id,
        String? bloque,
        int? sedeId,
        int? userCreateId,
        int? userEditId,
        int? status,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Bloque(
            id: id ?? this.id,
            bloque: bloque ?? this.bloque,
            sedeId: sedeId ?? this.sedeId,
            userCreateId: userCreateId ?? this.userCreateId,
            userEditId: userEditId ?? this.userEditId,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

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