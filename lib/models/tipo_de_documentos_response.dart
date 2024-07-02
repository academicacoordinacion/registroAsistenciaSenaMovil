// To parse this JSON data, do
//
//     final tipoDocumentoResponse = tipoDocumentoResponseFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

List<TipoDocumentoResponse> tipoDocumentoResponseFromJson(String str) =>
    List<TipoDocumentoResponse>.from(
        json.decode(str).map((x) => TipoDocumentoResponse.fromJson(x)));

String tipoDocumentoResponseToJson(List<TipoDocumentoResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TipoDocumentoResponse {
  final int id;
  final String name;

  TipoDocumentoResponse({
    required this.id,
    required this.name,
  });

  factory TipoDocumentoResponse.fromJson(Map<String, dynamic> json) =>
      TipoDocumentoResponse(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
