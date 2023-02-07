import 'dart:convert';

class HistTask {
  HistTask({
    required this.uid,
    required this.referencia,
    required this.observacion,
    required this.observacion2,
    required this.estado,
    required this.idTask,
    required this.createdAt,
    required this.updatedAt,
  });

  String uid;
  String referencia;
  String observacion;
  String observacion2;
  String estado;
  String idTask;
  DateTime createdAt;
  DateTime updatedAt;

  factory HistTask.fromJson(String str) => HistTask.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HistTask.fromMap(Map<String, dynamic> json) => HistTask(
        uid: json["uid"],
        referencia: json["referencia"],
        observacion: json["observacion"],
        observacion2: json["observacion2"],
        estado: json["estado"],
        idTask: json["idTask"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "referencia": referencia,
        "observacion": observacion,
        "observacion2": observacion2,
        "estado": estado,
        "idTask": idTask,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
