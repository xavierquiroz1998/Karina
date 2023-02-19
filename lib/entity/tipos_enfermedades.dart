import 'dart:convert';

class TipoEnfermedades {
  TipoEnfermedades({
    required this.idtiposenfermedades,
    required this.observacion,
    required this.estado,
  });

  String idtiposenfermedades;
  String observacion;
  bool estado;

  factory TipoEnfermedades.fromJson(String str) =>
      TipoEnfermedades.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TipoEnfermedades.fromMap(Map<String, dynamic> json) =>
      TipoEnfermedades(
        idtiposenfermedades: json["idtiposenfermedades"],
        observacion: json["observacion"],
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "idtiposenfermedades": idtiposenfermedades,
        "observacion": observacion,
        "estado": estado,
      };
}
