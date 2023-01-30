import 'dart:convert';

class Finca {
  Finca({
    required this.uid,
    required this.nombre,
    required this.dimension,
    required this.ubicacion,
    required this.referencia,
    required this.estado,
  });

  int uid;
  String nombre;
  String dimension;
  String ubicacion;
  String referencia;
  String estado;

  factory Finca.fromJson(String str) => Finca.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Finca.fromMap(Map<String, dynamic> json) => Finca(
        uid: json["uid"],
        nombre: json["nombre"],
        dimension: json["dimension"],
        ubicacion: json["ubicacion"],
        referencia: json["referencia"],
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "nombre": nombre,
        "dimension": dimension,
        "ubicacion": ubicacion,
        "referencia": referencia,
        "estado": estado,
      };
}
