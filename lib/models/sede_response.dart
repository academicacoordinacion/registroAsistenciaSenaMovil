// To parse this JSON data, do
//
//     final sedes = sedesFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

Sedes sedesFromJson(String str) => Sedes.fromJson(json.decode(str));

String sedesToJson(Sedes data) => json.encode(data.toJson());

class Sedes {
    final List<Sede> sedes;

    Sedes({
        required this.sedes,
    });

    factory Sedes.fromJson(Map<String, dynamic> json) => Sedes(
        sedes: List<Sede>.from(json["sedes"].map((x) => Sede.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "sedes": List<dynamic>.from(sedes.map((x) => x.toJson())),
    };
}

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
