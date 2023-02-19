import 'dart:convert';

class TiposGraminea {
  TiposGraminea({
    required this.idtipograminea,
    required this.observacion,
    required this.estado,
    required this.createdAt,
    required this.updatedAt,
  });

  String idtipograminea;
  String observacion;
  bool estado;
  DateTime createdAt;
  DateTime updatedAt;

  factory TiposGraminea.fromJson(String str) =>
      TiposGraminea.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TiposGraminea.fromMap(Map<String, dynamic> json) => TiposGraminea(
        idtipograminea: json["idtipograminea"],
        observacion: json["observacion"],
        estado: json["estado"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "idtipograminea": idtipograminea,
        "observacion": observacion,
        "estado": estado,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
