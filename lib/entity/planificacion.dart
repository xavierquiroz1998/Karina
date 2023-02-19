import 'dart:convert';

class Planificacion {
  Planificacion({
    required this.idplanificacion,
    required this.idFinca,
    required this.humedad,
    required this.temperatura,
    required this.idListInsumo,
    required this.idListPersonal,
    required this.idUsuario,
    required this.observacion,
    required this.observacion2,
    required this.fechaI,
    required this.fechaF,
    required this.estado,
    required this.createdAt,
    required this.updatedAt,
  });

  String idplanificacion;
  String idFinca;
  String humedad;
  String temperatura;
  String idListInsumo;
  String idListPersonal;
  String idUsuario;
  String observacion;
  String observacion2;
  DateTime fechaI;
  DateTime fechaF;
  bool estado;
  DateTime createdAt;
  DateTime updatedAt;

  factory Planificacion.fromJson(String str) =>
      Planificacion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Planificacion.fromMap(Map<String, dynamic> json) => Planificacion(
        idplanificacion: json["idplanificacion"],
        idFinca: json["idFinca"],
        humedad: json["humedad"],
        temperatura: json["temperatura"],
        idListInsumo: json["idListInsumo"],
        idListPersonal: json["idListPersonal"],
        idUsuario: json["idUsuario"],
        observacion: json["observacion"],
        observacion2: json["observacion2"],
        fechaI: DateTime.parse(json["fechaI"]),
        fechaF: DateTime.parse(json["fechaF"]),
        estado: json["estado"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "idplanificacion": idplanificacion,
        "idFinca": idFinca,
        "humedad": humedad,
        "temperatura": temperatura,
        "idListInsumo": idListInsumo,
        "idListPersonal": idListPersonal,
        "idUsuario": idUsuario,
        "observacion": observacion,
        "observacion2": observacion2,
        "fechaI": fechaI.toIso8601String(),
        "fechaF": fechaF.toIso8601String(),
        "estado": estado,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
