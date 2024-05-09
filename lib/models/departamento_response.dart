import 'dart:convert';

Departamento departamentoFromJson(String str) =>
    Departamento.fromJson(json.decode(str));

String departamentoToJson(Departamento data) => json.encode(data.toJson());

class Departamento {
  final List<DepartamentoModel> departamentos;

  Departamento({
    required this.departamentos,
  });

  factory Departamento.fromJson(Map<String, dynamic> json) => Departamento(
        departamentos: List<DepartamentoModel>.from(
            json["departamentos"].map((x) => DepartamentoModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "departamentos":
            List<dynamic>.from(departamentos.map((x) => x.toJson())),
      };
}

class DepartamentoModel {
  final int id;
  final String departamento;
  final int paisId;
  final int status;
  final String createdAt;
  final String updatedAt;

  DepartamentoModel({
    required this.id,
    required this.departamento,
    required this.paisId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DepartamentoModel.fromJson(Map<String, dynamic> json) =>
      DepartamentoModel(
        id: json["id"],
        departamento: json["departamento"],
        paisId: json["pais_id"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "departamento": departamento,
        "pais_id": paisId,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
