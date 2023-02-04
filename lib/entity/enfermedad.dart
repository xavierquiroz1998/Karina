import 'dart:convert';
import 'dart:ffi';

class Enfermedad {
  Enfermedad({
    required this.uid,
    required this.nombre,
    required this.grado,
    required this.ingreso,
    required this.estado,
  });

  int uid;
  String nombre;
  String grado;
  String ingreso;
  String estado;
  String? img;

  factory Enfermedad.fromJson(String str) =>
      Enfermedad.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Enfermedad.fromMap(Map<String, dynamic> json) => Enfermedad(
        uid: json["uid"],
        nombre: json["nombre"],
        grado: json["grado"],
        ingreso: json["ingreso"],
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "nombre": nombre,
        "grado": grado,
        "ingreso": ingreso,
        "estado": estado,
      };
}
