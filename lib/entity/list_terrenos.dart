import 'dart:convert';

class ListTerrenos {
  ListTerrenos({
    required this.uid,
    required this.referencia,
    required this.idTerreno,
  });

  String uid;
  String referencia;
  String idTerreno;

  factory ListTerrenos.fromJson(String str) =>
      ListTerrenos.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListTerrenos.fromMap(Map<String, dynamic> json) => ListTerrenos(
        uid: json["uid"],
        referencia: json["referencia"],
        idTerreno: json["idTerreno"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "referencia": referencia,
        "idTerreno": idTerreno,
      };
}
