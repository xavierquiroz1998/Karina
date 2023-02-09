import 'dart:convert';

class ListInsumos {
  ListInsumos({
    required this.uid,
    required this.referencia,
    required this.idinsumo,
  });

  String uid;
  String referencia;
  String idinsumo;

  factory ListInsumos.fromJson(String str) =>
      ListInsumos.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListInsumos.fromMap(Map<String, dynamic> json) => ListInsumos(
        uid: json["uid"],
        referencia: json["referencia"],
        idinsumo: json["idinsumo"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "referencia": referencia,
        "idinsumo": idinsumo,
      };
}
