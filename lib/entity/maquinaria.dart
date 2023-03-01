import 'dart:convert';

class Maquinaria {
  Maquinaria({
    required this.idmaquinarias,
    required this.nombre,
    required this.identificacion,
    required this.maquinariaTipoId,
    required this.procedencia,
    required this.fechacompra,
    required this.capacidad,
    required this.estado,
    required this.createdAt,
    required this.updatedAt,
  });

  String idmaquinarias;
  String nombre;
  String identificacion;
  String maquinariaTipoId;
  String procedencia;
  DateTime fechacompra;
  int capacidad;
  int estado;
  DateTime createdAt;
  DateTime updatedAt;

  factory Maquinaria.fromJson(String str) =>
      Maquinaria.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Maquinaria.fromMap(Map<String, dynamic> json) => Maquinaria(
        idmaquinarias: json["idmaquinarias"],
        nombre: json["nombre"],
        identificacion: json["identificacion"],
        maquinariaTipoId: json["maquinariaTipoId"],
        procedencia: json["procedencia"],
        fechacompra: DateTime.parse(json["fechacompra"]),
        capacidad: json["capacidad"],
        estado: json["estado"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "idmaquinarias": idmaquinarias,
        "nombre": nombre,
        "identificacion": identificacion,
        "maquinariaTipoId": maquinariaTipoId,
        "procedencia": procedencia,
        "fechacompra": fechacompra.toIso8601String(),
        "capacidad": capacidad,
        "estado": estado,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };

  bool isEqual(Maquinaria model) {
    return this.idmaquinarias == model.idmaquinarias;
  }
}
