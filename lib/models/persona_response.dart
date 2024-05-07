// import 'package:meta/meta.dart';
import 'dart:convert';

class Persona {
    final int id;
    final String tipoDocumento;
    final String numeroDocumento;
    final String primerNombre;
    final String segundoNombre;
    final String primerApellido;
    final String segundoApellido;
    final DateTime fechaDeNacimiento;
    final String genero;
    final String email;
    final DateTime createdAt;
    final DateTime updatedAt;

    Persona({
        required this.id,
        required this.tipoDocumento,
        required this.numeroDocumento,
        required this.primerNombre,
        required this.segundoNombre,
        required this.primerApellido,
        required this.segundoApellido,
        required this.fechaDeNacimiento,
        required this.genero,
        required this.email,
        required this.createdAt,
        required this.updatedAt,
    });

    Persona copyWith({
        int? id,
        String? tipoDocumento,
        String? numeroDocumento,
        String? primerNombre,
        String? segundoNombre,
        String? primerApellido,
        String? segundoApellido,
        DateTime? fechaDeNacimiento,
        String? genero,
        String? email,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Persona(
            id: id ?? this.id,
            tipoDocumento: tipoDocumento ?? this.tipoDocumento,
            numeroDocumento: numeroDocumento ?? this.numeroDocumento,
            primerNombre: primerNombre ?? this.primerNombre,
            segundoNombre: segundoNombre ?? this.segundoNombre,
            primerApellido: primerApellido ?? this.primerApellido,
            segundoApellido: segundoApellido ?? this.segundoApellido,
            fechaDeNacimiento: fechaDeNacimiento ?? this.fechaDeNacimiento,
            genero: genero ?? this.genero,
            email: email ?? this.email,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Persona.fromRawJson(String str) => Persona.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Persona.fromJson(Map<String, dynamic> json) => Persona(
        id: json["id"],
        tipoDocumento: json["tipo_documento"],
        numeroDocumento: json["numero_documento"],
        primerNombre: json["primer_nombre"],
        segundoNombre: json["segundo_nombre"],
        primerApellido: json["primer_apellido"],
        segundoApellido: json["segundo_apellido"],
        fechaDeNacimiento: DateTime.parse(json["fecha_de_nacimiento"]),
        genero: json["genero"],
        email: json["email"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo_documento": tipoDocumento,
        "numero_documento": numeroDocumento,
        "primer_nombre": primerNombre,
        "segundo_nombre": segundoNombre,
        "primer_apellido": primerApellido,
        "segundo_apellido": segundoApellido,
        "fecha_de_nacimiento": "${fechaDeNacimiento.year.toString().padLeft(4, '0')}-${fechaDeNacimiento.month.toString().padLeft(2, '0')}-${fechaDeNacimiento.day.toString().padLeft(2, '0')}",
        "genero": genero,
        "email": email,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}