import 'package:flutter/material.dart';
import 'package:tesis_karina/api/solicitud_api.dart';
import 'package:tesis_karina/entity/insumo.dart';
import 'package:tesis_karina/utils/util_view.dart';

class InsumoProvider extends ChangeNotifier {
  List<Insumo> listInsumo = [];
  TextEditingController txtNombre = TextEditingController();
  TextEditingController txtclase = TextEditingController();

  final _api = SolicitudApi();

  getListInt() async {
    final resp = await _api.getApiInsumos();
    listInsumo = resp;
    notifyListeners();
  }

  newObjeto() async {
    final resp = await _api.postApiInsumo(Insumo(
        uid: UtilView.numberRandonUid(),
        nombre: txtNombre.text,
        clase: txtclase.text,
        ingreso: "00-00-0000",
        estado: "1"));
    clearValue();
    print(resp);
    notifyListeners();
  }

  updateObjeto(Insumo e) async {
    final resp = await _api.putApiInsumo(e);
    try {
      listInsumo = listInsumo.map((en) {
        if (en.uid != e.uid) return e;
        e.nombre = e.nombre;
        return e;
      }).toList();
      clearValue();
      notifyListeners();
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

  void clearValue() {
    txtNombre.clear();
    txtclase.clear();
  }
}
