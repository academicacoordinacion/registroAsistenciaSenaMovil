// To parse this JSON data, do
//
//     final ambiente = ambienteFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

List<Ambiente> ambienteFromJson(String str) => List<Ambiente>.from(json.decode(str).map((x) => Ambiente.fromJson(x)));

String ambienteToJson(List<Ambiente> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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

    Ambiente copyWith({
        int? id,
        String? title,
        DateTime? createdAt,
        DateTime? updatedAt,
        int? pisoId,
        int? userCreateId,
        int? userEditId,
        int? status,
    }) => 
        Ambiente(
            id: id ?? this.id,
            title: title ?? this.title,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            pisoId: pisoId ?? this.pisoId,
            userCreateId: userCreateId ?? this.userCreateId,
            userEditId: userEditId ?? this.userEditId,
            status: status ?? this.status,
        );

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