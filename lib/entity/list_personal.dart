import 'dart:convert';

class ListPersonal {
  ListPersonal({
    required this.idlistadepersonal,
    required this.idPersonal,
    required this.idPlanificacion,
    required this.estado,
  });

  String idlistadepersonal;
  String idPersonal;
  String idPlanificacion;
  int estado;

  factory ListPersonal.fromJson(String str) =>
      ListPersonal.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListPersonal.fromMap(Map<String, dynamic> json) => ListPersonal(
        idlistadepersonal: json["idlistadepersonal"],
        idPersonal: json["idPersonal"],
        idPlanificacion: json["idPlanificacion"],
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "idlistadepersonal": idlistadepersonal,
        "idPersonal": idPersonal,
        "idPlanificacion": idPlanificacion,
        "estado": estado,
      };
}
