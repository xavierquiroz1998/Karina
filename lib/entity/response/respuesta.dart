import 'dart:convert';

class Respuesta {
  Respuesta({
    required this.msg,
  });

  String msg;

  factory Respuesta.fromJson(String str) => Respuesta.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Respuesta.fromMap(Map<String, dynamic> json) => Respuesta(
        msg: json["msg"],
      );

  Map<String, dynamic> toMap() => {
        "msg": msg,
      };
}
