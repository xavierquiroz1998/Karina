// To parse this JSON data, do
//
//     final persona = personaFromMap(jsonString);

import 'dart:convert';

class Persona {
  Persona({
    required this.uid,
    required this.nombre,
    required this.apellido,
    required this.direccion,
    required this.celular,
    required this.correo,
    required this.cedula,
    required this.fecha,
    required this.estado,
    required this.idusuario,
  });

  String uid;
  String nombre;
  String apellido;
  String direccion;
  String celular;
  String correo;
  String cedula;
  DateTime fecha;
  int estado;
  String idusuario;

  factory Persona.fromJson(String str) => Persona.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Persona.fromMap(Map<String, dynamic> json) => Persona(
        uid: json["uid"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        direccion: json["direccion"],
        celular: json["celular"],
        correo: json["correo"],
        cedula: json["cedula"],
        fecha: DateTime.parse(json["fecha"]),
        estado: json["estado"],
        idusuario: json["idusuario"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "nombre": nombre,
        "apellido": apellido,
        "direccion": direccion,
        "celular": celular,
        "correo": correo,
        "cedula": cedula,
        "fecha": fecha.toIso8601String(),
        "estado": estado,
        "idusuario": idusuario,
      };

  @override
  String toString() {
    // TODO: implement toString
    return '$nombre $apellido';
  }
}
