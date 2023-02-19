import 'dart:convert';

class Usuario {
  Usuario({
    required this.idusuarios,
    required this.correo,
    required this.rol,
    required this.estado,
    this.img = "",
    required this.clave,
    required this.createdAt,
    required this.updatedAt,
  });

  String idusuarios;
  String correo;
  String rol;
  bool estado;
  String img;
  String clave;
  DateTime createdAt;
  DateTime updatedAt;

  factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        idusuarios: json["idusuarios"],
        correo: json["correo"],
        rol: json["rol"],
        estado: json["estado"],
        img: json["img"],
        clave: json["clave"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "idusuarios": idusuarios,
        "correo": correo,
        "rol": rol,
        "estado": estado,
        "img": img,
        "clave": clave,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
