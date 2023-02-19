import 'dart:convert';

class Enfermedades {
  Enfermedades(
      {required this.idenfermedades,
      required this.nombre,
      required this.plagasTipoId,
      required this.enfermedadTipoId,
      required this.especificaciones,
      required this.tratamiento,
      required this.observacion,
      required this.fotografia,
      required this.estado});

  String idenfermedades;
  String nombre;
  String plagasTipoId;
  String enfermedadTipoId;
  String especificaciones;
  String tratamiento;
  String observacion;
  String fotografia;
  int estado;

  factory Enfermedades.fromJson(String str) =>
      Enfermedades.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Enfermedades.fromMap(Map<String, dynamic> json) => Enfermedades(
        idenfermedades: json["idenfermedades"],
        nombre: json["nombre"],
        plagasTipoId: json["plagasTipoId"],
        enfermedadTipoId: json["enfermedadTipoId"],
        especificaciones: json["especificaciones"],
        tratamiento: json["tratamiento"],
        observacion: json["observacion"],
        fotografia: json["fotografia"],
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "idenfermedades": idenfermedades,
        "nombre": nombre,
        "plagasTipoId": plagasTipoId,
        "enfermedadTipoId": enfermedadTipoId,
        "especificaciones": especificaciones,
        "tratamiento": tratamiento,
        "observacion": observacion,
        "fotografia": fotografia,
        "estado": estado,
      };
}
