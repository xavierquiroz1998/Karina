import 'dart:convert';

class Task {
  Task({
    required this.uid,
    required this.idFinca,
    required this.idTerreno,
    required this.disponible,
    required this.humedad,
    required this.temperatura,
    required this.idInsumos,
    required this.idPersonal,
    required this.idUsuario,
    required this.observacion,
    required this.start,
    required this.end,
    required this.estado,
    required this.createdAt,
    required this.updatedAt,
  });

  String uid;
  String idFinca;
  String idTerreno;
  int disponible;
  String humedad;
  String temperatura;
  String idInsumos;
  String idPersonal;
  String idUsuario;
  String observacion;
  DateTime start;
  DateTime end;
  int estado;
  DateTime createdAt;
  DateTime updatedAt;

  factory Task.fromJson(String str) => Task.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Task.fromMap(Map<String, dynamic> json) => Task(
        uid: json["uid"],
        idFinca: json["idFinca"],
        idTerreno: json["idTerreno"],
        disponible: json["disponible"],
        humedad: json["humedad"],
        temperatura: json["temperatura"],
        idInsumos: json["idInsumos"],
        idPersonal: json["idPersonal"],
        idUsuario: json["idUsuario"],
        observacion: json["observacion"],
        start: DateTime.parse(json["start"]),
        end: DateTime.parse(json["end"]),
        estado: json["estado"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "idFinca": idFinca,
        "idTerreno": idTerreno,
        "disponible": disponible,
        "humedad": humedad,
        "temperatura": temperatura,
        "idInsumos": idInsumos,
        "idPersonal": idPersonal,
        "idUsuario": idUsuario,
        "observacion": observacion,
        "start": start.toIso8601String(),
        "end": end.toIso8601String(),
        "estado": estado,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
