import 'dart:convert';

class Enfermedad {
  Enfermedad({
    required this.uid,
    required this.nombre,
    required this.grado,
    required this.observacion,
    required this.estado,
  });

  String uid;
  String nombre;
  String grado;
  String observacion;
  int estado;

  factory Enfermedad.fromJson(String str) =>
      Enfermedad.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Enfermedad.fromMap(Map<String, dynamic> json) => Enfermedad(
        uid: json["uid"],
        nombre: json["nombre"],
        grado: json["grado"],
        observacion: json["observacion"],
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "nombre": nombre,
        "grado": grado,
        "observacion": observacion,
        "estado": estado,
      };
}
