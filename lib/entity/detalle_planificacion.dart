import 'dart:convert';

class Detalleplanificacion {
  Detalleplanificacion({
    required this.iddetalleplanificacion,
    required this.idPlanificacion,
    required this.actividad,
    required this.idTerreno,
    required this.idtipograminea,
    required this.nivel,
    required this.etapa,
    required this.tipo,
    required this.inicio,
    required this.fin,
    required this.observacion,
    required this.observacion2,
    required this.estado,
    required this.createdAt,
    required this.updatedAt,
  });

  String iddetalleplanificacion;
  String idPlanificacion;
  String actividad;
  String idTerreno;
  String idtipograminea;
  int nivel;
  int etapa;
  String tipo;
  DateTime inicio;
  DateTime fin;
  String observacion;
  String observacion2;
  bool estado;
  DateTime createdAt;
  DateTime updatedAt;

  factory Detalleplanificacion.fromJson(String str) =>
      Detalleplanificacion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Detalleplanificacion.fromMap(Map<String, dynamic> json) =>
      Detalleplanificacion(
        iddetalleplanificacion: json["iddetalleplanificacion"],
        idPlanificacion: json["idPlanificacion"],
        actividad: json["actividad"],
        idTerreno: json["idTerreno"],
        idtipograminea: json["idtipograminea"],
        nivel: json["nivel"],
        etapa: json["etapa"],
        tipo: json["tipo"],
        inicio: DateTime.parse(json["inicio"]),
        fin: DateTime.parse(json["fin"]),
        observacion: json["observacion"],
        observacion2: json["observacion2"],
        estado: json["estado"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "iddetalleplanificacion": iddetalleplanificacion,
        "idPlanificacion": idPlanificacion,
        "actividad": actividad,
        "idTerreno": idTerreno,
        "idtipograminea": idtipograminea,
        "nivel": nivel,
        "etapa": etapa,
        "tipo": tipo,
        "inicio": inicio.toIso8601String(),
        "fin": fin.toIso8601String(),
        "observacion": observacion,
        "observacion2": observacion2,
        "estado": estado,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
