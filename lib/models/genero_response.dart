// To parse this JSON data, do
//
//     final generoResponse = generoResponseFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

List<GeneroResponse> generoResponseFromJson(String str) =>
    List<GeneroResponse>.from(
        json.decode(str).map((x) => GeneroResponse.fromJson(x)));

String generoResponseToJson(List<GeneroResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GeneroResponse {
  final int id;
  final String name;

  GeneroResponse({
    required this.id,
    required this.name,
  });

  factory GeneroResponse.fromJson(Map<String, dynamic> json) => GeneroResponse(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
