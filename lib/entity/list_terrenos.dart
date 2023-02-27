import 'dart:convert';

class ListTerrenos {
  ListTerrenos({
    required this.idlistadeterrenos,
    required this.idTerreno,
    required this.idGramineas,
    required this.idenfermedad,
    required this.idPlanificacion,
    required this.ocupado,
    required this.estado,
  });

  String idlistadeterrenos;
  String idTerreno;
  String idGramineas;
  String idenfermedad;
  String idPlanificacion;
  bool ocupado;
  bool estado;

  factory ListTerrenos.fromJson(String str) =>
      ListTerrenos.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListTerrenos.fromMap(Map<String, dynamic> json) => ListTerrenos(
      idlistadeterrenos: json["idlistadeterrenos"],
      idTerreno: json["idTerreno"],
      idGramineas: json["idGramineas"],
      idenfermedad: json["idenfermedad"],
      idPlanificacion: json["idPlanificacion"],
      ocupado: json["ocupado"],
      estado: json["estado"]);

  Map<String, dynamic> toMap() => {
        "idlistadeterrenos": idlistadeterrenos,
        "idTerreno": idTerreno,
        "idGramineas": idGramineas,
        "idenfermedad": idenfermedad,
        "idPlanificacion": idPlanificacion,
        "ocupado": ocupado,
        "estado": estado
      };
}
