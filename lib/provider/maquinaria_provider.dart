import 'package:flutter/material.dart';
import 'package:tesis_karina/api/solicitud_api.dart';
import 'package:tesis_karina/entity/maquinaria.dart';
import 'package:tesis_karina/utils/util_view.dart';

class MaquinariaProvider extends ChangeNotifier {
  List<Maquinaria> listMaquinaria = [];
  final _api = SolicitudApi();

  final txtNonbre = TextEditingController();
  final txtTipo = TextEditingController();

  getListInt() async {
    final resp = await _api.getApiMaquinarias();
    listMaquinaria = resp;
    notifyListeners();
  }

  newObjeto() async {
    final obj = Maquinaria(
        uid: UtilView.numberRandonUid(),
        nombre: txtNonbre.text,
        tipo: txtTipo.text,
        ingreso: "00-00-0000",
        estado: "I");
    final resp = await _api.postApiMaquinaria(obj);
    listMaquinaria.add(obj);
    print(resp);
    clearValue();
    notifyListeners();
  }

  updateObjeto(Maquinaria e) async {
    final resp = await _api.putApiMaquinaria(e);
    try {
      listMaquinaria = listMaquinaria.map((en) {
        if (en.uid != e.uid) return e;
        e.nombre = e.nombre;
        return e;
      }).toList();
      clearValue();
      notifyListeners();
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

  void clearValue() {
    txtNonbre.clear();
    txtTipo.clear();
  }
}
