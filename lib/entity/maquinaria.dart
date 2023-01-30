import 'dart:convert';

class Maquinaria {
  Maquinaria({
    required this.uid,
    required this.nombre,
    required this.tipo,
    required this.ingreso,
    required this.estado,
  });

  int uid;
  String nombre;
  String ingreso;
  String tipo;
  String estado;
  String? img;

  factory Maquinaria.fromJson(String str) =>
      Maquinaria.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Maquinaria.fromMap(Map<String, dynamic> json) => Maquinaria(
        uid: json["uid"],
        nombre: json["nombre"],
        ingreso: json["ingreso"],
        tipo: json["tipo"],
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "nombre": nombre,
        "ingreso": ingreso,
        "tipo": tipo,
        "estado": estado,
      };
}
