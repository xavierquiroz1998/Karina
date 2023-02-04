import 'dart:convert';

class Maquinaria {
  Maquinaria({
    required this.uid,
    required this.nombre,
    required this.tipo,
    required this.observacion,
    required this.estado,
  });

  String uid;
  String nombre;
  String observacion;
  String tipo;
  int estado;

  factory Maquinaria.fromJson(String str) =>
      Maquinaria.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Maquinaria.fromMap(Map<String, dynamic> json) => Maquinaria(
        uid: json["uid"],
        nombre: json["nombre"],
        observacion: json["observacion"],
        tipo: json["tipo"],
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "nombre": nombre,
        "observacion": observacion,
        "tipo": tipo,
        "estado": estado,
      };
}
