import 'dart:convert';

class TiposInsumos {
  TiposInsumos({
    required this.idtiposinsumos,
    required this.cantidad,
    required this.observacion,
    required this.estado,
    required this.createdAt,
    required this.updatedAt,
  });

  String idtiposinsumos;
  int cantidad;
  String observacion;
  bool estado;
  DateTime createdAt;
  DateTime updatedAt;

  factory TiposInsumos.fromJson(String str) =>
      TiposInsumos.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TiposInsumos.fromMap(Map<String, dynamic> json) => TiposInsumos(
        idtiposinsumos: json["idtiposinsumos"],
        cantidad: json["cantidad"],
        observacion: json["observacion"],
        estado: json["estado"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "idtiposinsumos": idtiposinsumos,
        "cantidad": cantidad,
        "observacion": observacion,
        "estado": estado,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
