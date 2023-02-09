import 'dart:convert';

class ListPersonal {
  ListPersonal(
      {required this.uid, required this.referencia, required this.idUsuario});

  String uid;
  String referencia;
  String idUsuario;

  factory ListPersonal.fromJson(String str) =>
      ListPersonal.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListPersonal.fromMap(Map<String, dynamic> json) => ListPersonal(
      uid: json["uid"],
      referencia: json["referencia"],
      idUsuario: json["idUsuario"]);

  Map<String, dynamic> toMap() =>
      {"uid": uid, "referencia": referencia, "idUsuario": idUsuario};
}
