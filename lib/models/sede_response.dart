// To parse this JSON data, do
//
//     final sede = sedeFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

List<Sede> sedeFromJson(String str) => List<Sede>.from(json.decode(str).map((x) => Sede.fromJson(x)));

String sedeToJson(List<Sede> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sede {
    final int id;
    final String sede;
    final String direccion;
    final int userCreateId;
    final int userEditId;
    final int status;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int municipioId;

    Sede({
        required this.id,
        required this.sede,
        required this.direccion,
        required this.userCreateId,
        required this.userEditId,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.municipioId,
    });

    Sede copyWith({
        int? id,
        String? sede,
        String? direccion,
        int? userCreateId,
        int? userEditId,
        int? status,
        DateTime? createdAt,
        DateTime? updatedAt,
        int? municipioId,
    }) => 
        Sede(
            id: id ?? this.id,
            sede: sede ?? this.sede,
            direccion: direccion ?? this.direccion,
            userCreateId: userCreateId ?? this.userCreateId,
            userEditId: userEditId ?? this.userEditId,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            municipioId: municipioId ?? this.municipioId,
        );

    factory Sede.fromJson(Map<String, dynamic> json) => Sede(
        id: json["id"],
        sede: json["sede"],
        direccion: json["direccion"],
        userCreateId: json["user_create_id"],
        userEditId: json["user_edit_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        municipioId: json["municipio_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "sede": sede,
        "direccion": direccion,
        "user_create_id": userCreateId,
        "user_edit_id": userEditId,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "municipio_id": municipioId,
    };
}