import 'dart:convert';

import 'package:tesis_karina/entity/finca.dart';

class Terreno {
  Terreno({
    required this.idterreno,
    required this.idFinca,
    required this.ubicacion,
    required this.dimension,
    required this.longitud,
    required this.latitud,
    required this.unidad,
    required this.disponibilidad,
    required this.observacion,
    required this.estado,
    required this.createdAt,
    required this.updatedAt,
    required this.finca,
  });

  String idterreno;
  String idFinca;
  String ubicacion;
  String dimension;
  String longitud;
  String latitud;
  String unidad;
  String disponibilidad;
  String observacion;
  bool estado;
  DateTime createdAt;
  DateTime updatedAt;
  Finca finca;

  factory Terreno.fromJson(String str) => Terreno.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Terreno.fromMap(Map<String, dynamic> json) => Terreno(
        idterreno: json["idterreno"],
        idFinca: json["idFinca"],
        ubicacion: json["ubicacion"],
        dimension: json["dimension"],
        longitud: json["longitud"],
        latitud: json["latitud"],
        unidad: json["unidad"],
        disponibilidad: json["disponibilidad"],
        observacion: json["observacion"],
        estado: json["estado"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        finca: Finca.fromMap(json["finca"]),
      );

  Map<String, dynamic> toMap() => {
        "idterreno": idterreno,
        "idFinca": idFinca,
        "ubicacion": ubicacion,
        "dimension": dimension,
        "longitud": longitud,
        "latitud": latitud,
        "unidad": unidad,
        "disponibilidad": disponibilidad,
        "observacion": observacion,
        "estado": estado,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "finca": finca.toMap(),
      };

  @override
  String toString() {
    // TODO: implement toString
    return ubicacion;
  }

  bool isEqual(Terreno model) {
    return this.idterreno == model.idterreno;
  }
}
