import 'package:flutter/material.dart';
import 'package:tesis_karina/entity/insumo.dart';

class InsumoProvider extends ChangeNotifier {
  List<Insumo> listInsumo = [];
  TextEditingController txtNombre = TextEditingController();
  TextEditingController txtclase = TextEditingController();

  getListInt() async {
    //final resp = await _api.getProductPaginado(empresa, cantidad, limit);
    final resp = [
      Insumo(
          uid: "I01",
          nombre: "Bisturi",
          clase: "Quirurjico",
          ingreso: "10/01/20223",
          estado: "A")
    ];
    listInsumo = resp;
  }

  newObjeto(Insumo e) {
    listInsumo.add(Insumo(
        uid: "I01",
        nombre: "Bisturi",
        clase: "Quirurjico",
        ingreso: "10/01/20223",
        estado: "A"));
    notifyListeners();
  }

  updateObjeto(Insumo e) {}

  deleteObjeto(Insumo e) {
    listInsumo.remove(e);
    notifyListeners();
  }
}
