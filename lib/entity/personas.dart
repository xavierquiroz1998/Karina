import 'dart:convert';

class Persona {
  Persona({
    required this.idpersonas,
    required this.cedula,
    required this.nombre,
    required this.apellido,
    required this.direccion,
    required this.celular,
    required this.nacimiento,
    required this.estado,
    required this.idUsuario,
  });

  String idpersonas;
  String cedula;
  String nombre;
  String apellido;
  String direccion;
  String celular;
  DateTime nacimiento;
  bool estado;
  String idUsuario;

  factory Persona.fromJson(String str) => Persona.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Persona.fromMap(Map<String, dynamic> json) => Persona(
        idpersonas: json["idpersonas"],
        cedula: json["cedula"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        direccion: json["direccion"],
        celular: json["celular"],
        nacimiento: DateTime.parse(json["nacimiento"]),
        estado: json["estado"],
        idUsuario: json["idUsuario"],
      );

  Map<String, dynamic> toMap() => {
        "idpersonas": idpersonas,
        "cedula": cedula,
        "nombre": nombre,
        "apellido": apellido,
        "direccion": direccion,
        "celular": celular,
        "nacimiento": nacimiento.toIso8601String(),
        "estado": estado,
        "idUsuario": idUsuario,
      };
}
