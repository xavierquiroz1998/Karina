import 'dart:convert';

class TiposMaquinarias {
  TiposMaquinarias({
    required this.idtiposmaquinarias,
    required this.cantidad,
    required this.observacion,
    required this.estado,
    required this.createdAt,
    required this.updatedAt,
  });

  String idtiposmaquinarias;
  int cantidad;
  String observacion;
  bool estado;
  DateTime createdAt;
  DateTime updatedAt;

  factory TiposMaquinarias.fromJson(String str) =>
      TiposMaquinarias.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TiposMaquinarias.fromMap(Map<String, dynamic> json) =>
      TiposMaquinarias(
        idtiposmaquinarias: json["idtiposmaquinarias"],
        cantidad: json["cantidad"],
        observacion: json["observacion"],
        estado: json["estado"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "idtiposmaquinarias": idtiposmaquinarias,
        "cantidad": cantidad,
        "observacion": observacion,
        "estado": estado,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
