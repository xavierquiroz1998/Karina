import 'dart:convert';

class TiposPlagas {
  TiposPlagas({
    required this.idtiposplagas,
    required this.observacion,
    required this.estado,
    required this.createdAt,
    required this.updatedAt,
  });

  String idtiposplagas;
  String observacion;
  bool estado;
  DateTime createdAt;
  DateTime updatedAt;

  factory TiposPlagas.fromJson(String str) =>
      TiposPlagas.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TiposPlagas.fromMap(Map<String, dynamic> json) => TiposPlagas(
        idtiposplagas: json["idtiposplagas"],
        observacion: json["observacion"],
        estado: json["estado"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "idtiposplagas": idtiposplagas,
        "observacion": observacion,
        "estado": estado,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
