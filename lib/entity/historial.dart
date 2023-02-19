import 'dart:convert';

class Historial {
  Historial({
    required this.idhistorial,
    required this.referencia,
    required this.observacion,
    required this.observacion2,
    required this.evaluar,
    required this.carga,
  });

  String idhistorial;
  String referencia;
  String observacion;
  String observacion2;
  int evaluar;
  String carga;

  factory Historial.fromJson(String str) => Historial.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Historial.fromMap(Map<String, dynamic> json) => Historial(
        idhistorial: json["idhistorial"],
        referencia: json["referencia"],
        observacion: json["observacion"],
        observacion2: json["observacion2"],
        evaluar: json["evaluar"],
        carga: json["carga"],
      );

  Map<String, dynamic> toMap() => {
        "idhistorial": idhistorial,
        "referencia": referencia,
        "observacion": observacion,
        "observacion2": observacion2,
        "evaluar": evaluar,
        "carga": carga,
      };
}
