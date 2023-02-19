import 'package:flutter/material.dart';
import 'package:tesis_karina/api/solicitud_api.dart';
import 'package:tesis_karina/entity/maquinaria.dart';

class MaquinariaProvider extends ChangeNotifier {
  List<Maquinaria> listMaquinaria = [];
  String isSelect = "";
  List<String> tipoMaquinaria = [];
  final _api = SolicitudApi();

  getListInt() async {
    final resp = await _api.getApiMaquinarias();
    listMaquinaria = resp;
    getTipoList();
    notifyListeners();
  }

  getTipoList() async {
    final resp1 = await _api.getApiTipoMaquinarias();
    tipoMaquinaria = resp1.map((en) {
      return "${en.idtiposmaquinarias} / ${en.observacion}";
    }).toList();
    isSelect = tipoMaquinaria[0];
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
        if (maquinaria.idmaquinarias != e.idmaquinarias) return e;
        e.nombre = e.nombre;
        e.identificacion = e.identificacion;
        e.capacidad = e.capacidad;
        e.maquinariaTipoId = e.maquinariaTipoId;
        return e;
      }).toList();
      notifyListeners();
      return true;
    } catch (e) {
      throw 'Error al actualizar la maquinaria';
    }
  }

  deleteObjeto(Maquinaria e) async {
    final resp = await _api.deleteApiMaquinaria(e.idmaquinarias);
    print(resp);
    listMaquinaria.remove(e);
    notifyListeners();
  }
}
