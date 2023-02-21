import 'dart:convert';

class Finca {
  Finca({
    required this.idfinca,
    required this.nombre,
    required this.dimension,
    required this.ubicacion,
    required this.referencia,
    required this.estado,
    required this.createdAt,
    required this.updatedAt,
  });

  String idfinca;
  String nombre;
  String dimension;
  String ubicacion;
  dynamic referencia;
  String estado;
  DateTime createdAt;
  DateTime updatedAt;

  factory Finca.fromJson(String str) => Finca.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Finca.fromMap(Map<String, dynamic> json) => Finca(
        idfinca: json["idfinca"],
        nombre: json["nombre"],
        dimension: json["dimension"],
        ubicacion: json["ubicacion"],
        referencia: json["referencia"],
        estado: json["estado"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "idfinca": idfinca,
        "nombre": nombre,
        "dimension": dimension,
        "ubicacion": ubicacion,
        "referencia": referencia,
        "estado": estado,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };

  @override
  String toString() {
    // TODO: implement toString
    return nombre;
  }
}
