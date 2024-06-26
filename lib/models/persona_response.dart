class Persona {
  final int id;
  final String tipoDocumento;
  final String numeroDocumento;
  final String primerNombre;
  final String? segundoNombre;
  final String? primerApellido;
  final String? segundoApellido;
  final DateTime? fechaDeNacimiento;
  final String genero;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int instructorId;
  final int regionalId;

  Persona({
    required this.id,
    required this.tipoDocumento,
    required this.numeroDocumento,
    required this.primerNombre,
    this.segundoNombre,
    this.primerApellido,
    this.segundoApellido,
    this.fechaDeNacimiento,
    required this.genero,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.instructorId,
    required this.regionalId,
  });

  factory Persona.fromJson(Map<String, dynamic> json) => Persona(
        id: json["id"],
        tipoDocumento: json["tipo_documento"],
        numeroDocumento: json["numero_documento"],
        primerNombre: json["primer_nombre"],
        segundoNombre: json["segundo_nombre"] ?? "",
        primerApellido: json["primer_apellido"] ?? "",
        segundoApellido: json["segundo_apellido"] ?? "",
        fechaDeNacimiento: json["fecha_de_nacimiento"] != null
            ? DateTime.parse(json["fecha_de_nacimiento"])
            : null,
        genero: json["genero"],
        email: json["email"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        instructorId: json["instructor_id"],
        regionalId: json["regional_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo_documento": tipoDocumento,
        "numero_documento": numeroDocumento,
        "primer_nombre": primerNombre,
        "segundo_nombre": segundoNombre,
        "primer_apellido": primerApellido,
        "segundo_apellido": segundoApellido,
        "fecha_de_nacimiento": fechaDeNacimiento != null
            ? "${fechaDeNacimiento?.year.toString().padLeft(4, '0')}-${fechaDeNacimiento?.month.toString().padLeft(2, '0')}-${fechaDeNacimiento?.day.toString().padLeft(2, '0')}"
            : null,
        "genero": genero,
        "email": email,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "instructor_id": instructorId,
        "regional_id": regionalId,
      };
}
