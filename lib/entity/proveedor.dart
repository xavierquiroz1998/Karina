import 'dart:convert';

class Proveedor {
  Proveedor({
    required this.idproveedores,
    required this.observacion,
    required this.estado,
    required this.createdAt,
    required this.updatedAt,
  });

  String idproveedores;
  String observacion;
  int estado;
  DateTime createdAt;
  DateTime updatedAt;

  factory Proveedor.fromJson(String str) => Proveedor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Proveedor.fromMap(Map<String, dynamic> json) => Proveedor(
        idproveedores: json["idproveedores"],
        observacion: json["observacion"],
        estado: json["estado"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "idproveedores": idproveedores,
        "observacion": observacion,
        "estado": estado,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
