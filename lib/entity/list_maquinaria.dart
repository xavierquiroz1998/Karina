import 'dart:convert';

class ListMaquinarias {
  ListMaquinarias(
      {required this.idlistamaquinaria,
      required this.idMaquinaria,
      required this.idPlanificacion,
      required this.estado});

  String idlistamaquinaria;
  String idMaquinaria;
  String idPlanificacion;
  bool estado;

  factory ListMaquinarias.fromJson(String str) =>
      ListMaquinarias.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListMaquinarias.fromMap(Map<String, dynamic> json) => ListMaquinarias(
      idlistamaquinaria: json["idlistamaquinaria"],
      idMaquinaria: json["idMaquinaria"],
      idPlanificacion: json["idPlanificacion"],
      estado: json["estado"]);

  Map<String, dynamic> toMap() => {
        "idlistamaquinaria": idlistamaquinaria,
        "idMaquinaria": idMaquinaria,
        "idPlanificacion": idPlanificacion,
        "estado": estado
      };
}
