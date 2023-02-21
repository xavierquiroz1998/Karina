import 'dart:convert';

class ListInsumos {
  ListInsumos({
    required this.idlistadeInsumos,
    required this.idInsumo,
    required this.idPlanificacion,
    required this.unidad,
    required this.estado,
  });

  String idlistadeInsumos;
  String idInsumo;
  String idPlanificacion;
  String unidad;
  int estado;

  factory ListInsumos.fromJson(String str) =>
      ListInsumos.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListInsumos.fromMap(Map<String, dynamic> json) => ListInsumos(
        idlistadeInsumos: json["idlistadeInsumos"],
        idInsumo: json["idInsumo"],
        idPlanificacion: json["idPlanificacion"],
        unidad: json["unidad"],
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "idlistadeInsumos": idlistadeInsumos,
        "idInsumo": idInsumo,
        "idPlanificacion": idPlanificacion,
        "unidad": unidad,
        "estado": estado, 
      };
}
