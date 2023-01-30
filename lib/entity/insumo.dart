import 'dart:convert';

class Insumo {
  Insumo({
    required this.uid,
    required this.nombre,
    required this.clase,
    required this.ingreso,
    required this.estado,
  });

  int uid;
  String nombre;
  String clase;
  String ingreso;
  String estado;
  String? img;

  factory Insumo.fromJson(String str) => Insumo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Insumo.fromMap(Map<String, dynamic> json) => Insumo(
        uid: json["uid"],
        nombre: json["nombre"],
        clase: json["clase"],
        ingreso: json["ingreso"],
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "nombre": nombre,
        "clase": clase,
        "ingreso": ingreso,
        "estado": estado,
      };
}
