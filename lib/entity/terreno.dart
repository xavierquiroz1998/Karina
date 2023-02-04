import 'dart:convert';

class Terreno {
  Terreno({
    required this.uid,
    required this.ubicacion,
    required this.dimension,
    required this.unidad,
    required this.observacion,
    required this.estado,
  });

  String uid;
  String ubicacion;
  String dimension;
  String unidad;
  String observacion;
  int estado;

  factory Terreno.fromJson(String str) => Terreno.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Terreno.fromMap(Map<String, dynamic> json) => Terreno(
        uid: json["uid"],
        ubicacion: json["ubicacion"],
        dimension: json["dimension"],
        unidad: json["unidad"],
        observacion: json["observacion"],
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "ubicacion": ubicacion,
        "dimension": dimension,
        "unidad": unidad,
        "observacion": observacion,
        "estado": estado,
      };
}
