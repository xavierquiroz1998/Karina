import 'dart:convert';

class Usuario {
  Usuario(
      {required this.rol,
      required this.estado,
      required this.nombre,
      required this.correo,
      required this.direccion,
      required this.uid,
      this.img});

  String rol;
  bool estado;
  String nombre;
  String correo;
  bool direccion;
  String uid;
  String? img;

  factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        rol: json["rol"],
        estado: json["estado"],
        nombre: json["nombre"],
        correo: json["correo"],
        direccion: json["direccion"],
        uid: json["uid"],
        img: json["img"],
      );

  Map<String, dynamic> toMap() => {
        "rol": rol,
        "estado": estado,
        "nombre": nombre,
        "correo": correo,
        "direccion": direccion,
        "uid": uid,
        "img": img,
      };
}
