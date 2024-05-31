class User {
  final int id;
  final String email;
  final dynamic emailVerifiedAt;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int personaId;

  User({
    required this.id,
    required this.email,
    required this.emailVerifiedAt,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.personaId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        personaId: json["persona_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "persona_id": personaId,
      };
}
