import 'dart:convert';

class Insumo {
  Insumo({
    required this.uid,
    required this.nombre,
    required this.clase,
    required this.observacion,
    required this.estado,
  });

  String uid;
  String nombre;
  String clase;
  String observacion;
  int estado;

  factory Insumo.fromJson(String str) => Insumo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Insumo.fromMap(Map<String, dynamic> json) => Insumo(
        uid: json["uid"],
        nombre: json["nombre"],
        clase: json["clase"],
        observacion: json["observacion"],
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "nombre": nombre,
        "clase": clase,
        "observacion": observacion,
        "estado": estado,
      };
}
