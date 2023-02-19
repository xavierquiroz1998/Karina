import 'package:flutter/material.dart';
import 'package:tesis_karina/api/solicitud_api.dart';
import 'package:tesis_karina/entity/finca.dart';

class FincaProvider extends ChangeNotifier {
  List<Finca> listFinca = [];
  final _api = SolicitudApi();

  getListInt() async {
    final resp = await _api.getApiFincas();
    listFinca = resp;
    notifyListeners();
  }

  newObjeto(Finca e) async {
    final resp = await _api.postApiFinca(e);
    listFinca.add(e);
    notifyListeners();
  }

  updateObjeto(Finca e) async {
    final resp = await _api.putApiFinca(e);
    try {
      this.listFinca = this.listFinca.map((en) {
        if (en.idfinca != e.idfinca) return e;
        en.nombre = e.nombre;
        return e;
      }).toList();

      notifyListeners();
    } catch (e) {
      throw 'Error al actualizar la Finca';
    }
  }

  deleteObjeto(Finca e) async {
    final resp = await _api.deleteApiFinca(e.idfinca);
    listFinca.remove(e);
    notifyListeners();
  }
}
