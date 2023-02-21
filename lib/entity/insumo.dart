import 'dart:convert';

class Insumos {
  Insumos({
    required this.idinsumos,
    required this.insumoTipoId,
    required this.nombre,
    required this.fechaCaducidad,
    required this.observacion,
    required this.unidades,
    required this.estado,
    required this.createdAt,
    required this.updatedAt,
  });

  String idinsumos;
  String insumoTipoId;
  String nombre;
  DateTime fechaCaducidad;
  String observacion;
  String unidades;
  int estado;
  DateTime createdAt;
  DateTime updatedAt;

  factory Insumos.fromJson(String str) => Insumos.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Insumos.fromMap(Map<String, dynamic> json) => Insumos(
        idinsumos: json["idinsumos"],
        insumoTipoId: json["insumoTipoId"],
        nombre: json["nombre"],
        fechaCaducidad: DateTime.parse(json["fechaCaducidad"]),
        observacion: json["observacion"],
        unidades: json["unidades"],
        estado: json["estado"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "idinsumos": idinsumos,
        "insumoTipoId": insumoTipoId,
        "nombre": nombre,
        "fechaCaducidad": fechaCaducidad.toIso8601String(),
        "observacion": observacion,
        "unidades": unidades,
        "estado": estado,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };

  @override
  String toString() {
    // TODO: implement toString
    return nombre;
  }
}
