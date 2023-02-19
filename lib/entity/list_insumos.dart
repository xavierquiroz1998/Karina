import 'dart:convert';

class ListInsumos {
  ListInsumos({
    required this.idlistadeInsumos,
    required this.idInsumo,
    required this.idPlanificacion,
    required this.unidad,
    required this.estado,
    required this.createdAt,
    required this.updatedAt,
  });

  String idlistadeInsumos;
  String idInsumo;
  String idPlanificacion;
  String unidad;
  int estado;
  DateTime createdAt;
  DateTime updatedAt;

  factory ListInsumos.fromJson(String str) =>
      ListInsumos.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListInsumos.fromMap(Map<String, dynamic> json) => ListInsumos(
        idlistadeInsumos: json["idlistadeInsumos"],
        idInsumo: json["idInsumo"],
        idPlanificacion: json["idPlanificacion"],
        unidad: json["unidad"],
        estado: json["estado"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "idlistadeInsumos": idlistadeInsumos,
        "idInsumo": idInsumo,
        "idPlanificacion": idPlanificacion,
        "unidad": unidad,
        "estado": estado,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
