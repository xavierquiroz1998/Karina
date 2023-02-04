import 'package:flutter/material.dart';
import 'package:tesis_karina/api/solicitud_api.dart';
import 'package:tesis_karina/entity/insumo.dart';
import 'package:tesis_karina/utils/util_view.dart';

class InsumoProvider extends ChangeNotifier {
  List<Insumo> listInsumo = [];
  final _api = SolicitudApi();

  getListInt() async {
    final resp = await _api.getApiInsumos();
    listInsumo = resp;
    notifyListeners();
  }

  Future<bool> newObjeto(Insumo insumo) async {
    final resp = await _api.postApiInsumo(insumo);
    listInsumo.add(insumo);
    notifyListeners();
    return resp;
  }

  updateObjeto(Insumo insumo) async {
    final resp = await _api.putApiInsumo(insumo);
    try {
      this.listInsumo = this.listInsumo.map((e) {
        if (insumo.uid != e.uid) return e;
        e.nombre = insumo.nombre;
        return e;
      }).toList();
      notifyListeners();
      return true;
    } catch (e) {
      throw 'Error al actualizar el insumo';
    }
  }

  deleteObjeto(Insumo e) async {
    final resp = await _api.deleteApiInsumo(e.uid);
    print(resp);
    listInsumo.remove(e);
    notifyListeners();
  }
}
