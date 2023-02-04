import 'dart:convert';

class Usuario {
  Usuario(
      {required this.rol,
      required this.estado,
      required this.nombre,
      required this.correo,
      required this.uid,
      this.img});

  String uid;
  String nombre;
  String correo;
  String rol;
  int estado;
  String? img;

  factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        rol: json["rol"],
        estado: json["estado"],
        nombre: json["nombre"],
        correo: json["correo"],
        uid: json["uid"],
        img: json["img"],
      );

  Map<String, dynamic> toMap() => {
        "rol": rol,
        "estado": estado,
        "nombre": nombre,
        "correo": correo,
        "uid": uid,
        "img": img,
      };
}
