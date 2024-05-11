// To parse this JSON data, do
//
//     final piso = pisoFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

List<Piso> pisoFromJson(String str) => List<Piso>.from(json.decode(str).map((x) => Piso.fromJson(x)));

String pisoToJson(List<Piso> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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

    Piso copyWith({
        int? id,
        String? piso,
        int? bloqueId,
        int? userCreateId,
        int? userEditId,
        int? status,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Piso(
            id: id ?? this.id,
            piso: piso ?? this.piso,
            bloqueId: bloqueId ?? this.bloqueId,
            userCreateId: userCreateId ?? this.userCreateId,
            userEditId: userEditId ?? this.userEditId,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

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