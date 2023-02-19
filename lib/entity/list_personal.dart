import 'dart:convert';

class ListPersonal {
  ListPersonal({
    required this.idlistadepersonal,
    required this.idPersonal,
    required this.idPlanificacion,
    required this.estado,
    required this.createdAt,
    required this.updatedAt,
  });

  String idlistadepersonal;
  String idPersonal;
  String idPlanificacion;
  int estado;
  DateTime createdAt;
  DateTime updatedAt;

  factory ListPersonal.fromJson(String str) =>
      ListPersonal.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListPersonal.fromMap(Map<String, dynamic> json) => ListPersonal(
        idlistadepersonal: json["idlistadepersonal"],
        idPersonal: json["idPersonal"],
        idPlanificacion: json["idPlanificacion"],
        estado: json["estado"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "idlistadepersonal": idlistadepersonal,
        "idPersonal": idPersonal,
        "idPlanificacion": idPlanificacion,
        "estado": estado,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
