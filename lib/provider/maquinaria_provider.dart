import 'package:flutter/material.dart';
import 'package:tesis_karina/api/solicitud_api.dart';
import 'package:tesis_karina/entity/maquinaria.dart';

class MaquinariaProvider extends ChangeNotifier {
  List<Maquinaria> listMaquinaria = [];
  final _api = SolicitudApi();

  getListInt() async {
    final resp = await _api.getApiMaquinarias();
    listMaquinaria = resp;
    notifyListeners();
  }

  newObjeto(Maquinaria obj) async {
    final resp = await _api.postApiMaquinaria(obj);
    listMaquinaria.add(obj);
    notifyListeners();
  }

  updateObjeto(Maquinaria maquinaria) async {
    final resp = await _api.putApiMaquinaria(maquinaria);
    try {
      this.listMaquinaria = this.listMaquinaria.map((e) {
        if (maquinaria.uid != e.uid) return e;
        e.nombre = e.nombre;
        return e;
      }).toList();
      notifyListeners();
      return true;
    } catch (e) {
      throw 'Error al actualizar la maquinaria';
    }
  }

  deleteObjeto(Maquinaria e) async {
    final resp = await _api.deleteApiMaquinaria(e.uid);
    print(resp);
    listMaquinaria.remove(e);
    notifyListeners();
  }
}
