import 'package:flutter/material.dart';
import 'package:tesis_karina/api/solicitud_api.dart';
import 'package:tesis_karina/entity/finca.dart';

class FincaProvider extends ChangeNotifier {
  List<Finca> listFinca = [];
  final _api = SolicitudApi();

  TextEditingController txtNombre = TextEditingController();
  TextEditingController txtDimension = TextEditingController();
  TextEditingController txtUbicacion = TextEditingController();
  TextEditingController txtReferencia = TextEditingController();

  getListInt() async {
    final resp = await _api.getApiFincas();
    listFinca = resp;
    notifyListeners();
  }

  newObjeto(Finca e) async {
    final resp = await _api.postApiFinca(e);
    listFinca.add(e);
    clearValue();
    notifyListeners();
  }

  updateObjeto(Finca e) async {
    final resp = await _api.putApiFinca(e);
    try {
      listFinca = listFinca.map((en) {
        if (en.uid != e.uid) return e;
        e.nombre = e.nombre;
        return e;
      }).toList();

      notifyListeners();
    } catch (e) {
      throw 'Error al actualizar la Finca';
    }
  }

  deleteObjeto(Finca e) async {
    final resp = await _api.deleteApiFinca(e.uid);
    print(resp);
    listFinca.remove(e);
    notifyListeners();
  }

  clearValue() {
    txtDimension.clear();
    txtNombre.clear();
    txtReferencia.clear();
    txtUbicacion.clear();
  }
}
