import 'dart:convert';

class Maquinaria {
  Maquinaria({
    required this.idmaquinarias,
    required this.nombre,
    required this.identificacion,
    required this.maquinariaTipoId,
    required this.capacidad,
    required this.estado,
    required this.createdAt,
    required this.updatedAt,
  });

  String idmaquinarias;
  String nombre;
  String identificacion;
  String maquinariaTipoId;
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
        "capacidad": capacidad,
        "estado": estado,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };

  @override
  String toString() {
    // TODO: implement toString
    return nombre;
  }

  bool isEqual(Maquinaria model) {
    return this.idmaquinarias == model.idmaquinarias;
  }
}
