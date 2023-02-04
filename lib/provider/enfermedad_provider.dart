import 'package:flutter/material.dart';
import 'package:tesis_karina/api/solicitud_api.dart';
import 'package:tesis_karina/entity/enfermedad.dart';

class EnfermedadProvider extends ChangeNotifier {
  List<Enfermedad> listEnfermedad = [];
  final _api = SolicitudApi();

  getListInt() async {
    final resp = await _api.getApiEnfermedades();
    listEnfermedad = resp;
    notifyListeners();
  }

  newObjeto(Enfermedad e) async {
    final resp = await _api.postApiEnfermedad(e);
    listEnfermedad.add(e);
    notifyListeners();
  }

  updateObjeto(Enfermedad e) async {
    final resp = await _api.putApiEnfermedad(e);
    try {
      this.listEnfermedad = this.listEnfermedad.map((en) {
        if (en.uid != e.uid) return e;
        en.nombre = e.nombre;
        return e;
      }).toList();
      notifyListeners();
    } catch (e) {
      throw 'Error al actualizar la enfermedad';
    }
  }

  deleteObjeto(Enfermedad e) async {
    final resp = await _api.deleteApiEnfermedad(e.uid);
    print(resp);
    listEnfermedad.remove(e);
    notifyListeners();
  }
}
