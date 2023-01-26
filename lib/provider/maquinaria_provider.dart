import 'package:flutter/material.dart';
import 'package:tesis_karina/entity/maquinaria.dart';

class MaquinariaProvider extends ChangeNotifier {
  List<Maquinaria> listMaquinaria = [];
  getListInt() async {
    //final resp = await _api.getProductPaginado(empresa, cantidad, limit);
    final resp = [
      Maquinaria(
          uid: "0",
          nombre: "Maquina de carga",
          tipo: "Constructor",
          ingreso: "2022-10-19",
          estado: "A")
    ];
    listMaquinaria = resp;
    //notifyListeners();
  }

  newObjeto(Maquinaria e) {
    /* listMaquinaria.add(Maquinaria(
        uid: uid,
        nombre: nombre,
        tipo: tipo,
        ingreso: ingreso,
        estado: estado)); */
    notifyListeners();
  }

  updateObjeto(Maquinaria e) {}

  deleteObjeto(Maquinaria e) {
    listMaquinaria.remove(e);
    notifyListeners();
  }
}
