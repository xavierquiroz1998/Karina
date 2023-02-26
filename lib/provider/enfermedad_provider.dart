import 'package:flutter/material.dart';
import 'package:tesis_karina/api/solicitud_api.dart';
import 'package:tesis_karina/entity/enfermedad.dart';

class EnfermedadProvider extends ChangeNotifier {
  final _api = SolicitudApi();
  late Enfermedades isSelectEnfermedad;
  List<Enfermedades> listEnfermedad = [];
  List<String> tiposEnfermedad = [];
  List<String> tiposPlagas = [];

  String isSelectE = "";
  String isSelectP = "";

  getListInt() async {
    final resp = await _api.getApiEnfermedades();
    getTipoList();
    listEnfermedad = resp;
    notifyListeners();
  }

  getTipoList() async {
    final resp1 = await _api.getApiTipoEnfermedades();
    final resp2 = await _api.getApiTipoPlagas();
    tiposEnfermedad = resp1.map((en) {
      return "${en.idtiposenfermedades} / ${en.observacion}";
    }).toList();
    tiposPlagas = resp2.map((en) {
      return "${en.idtiposplagas} / ${en.observacion}";
    }).toList();
    isSelectE = tiposEnfermedad[0];
    isSelectP = tiposPlagas[0];
  }

  newObjeto(Enfermedades e) async {
    final resp = await _api.postApiEnfermedad(e);
    listEnfermedad.add(e);
    notifyListeners();
  }

  updateObjeto(Enfermedades e) async {
    final resp = await _api.putApiEnfermedad(e);
    try {
      this.listEnfermedad = this.listEnfermedad.map((en) {
        if (en.idenfermedades != e.idenfermedades) return en;
        en.nombre = e.nombre;
        en.plagasTipoId = isSelectP;
        en.enfermedadTipoId = isSelectE;
        en.observacion = e.observacion;

        return en;
      }).toList();
      notifyListeners();
    } catch (e) {
      throw 'Error al actualizar la enfermedad';
    }
  }

  deleteObjeto(Enfermedades e) async {
    final resp = await _api.deleteApiEnfermedad(e.idenfermedades);
    print(resp);
    listEnfermedad.remove(e);
    notifyListeners();
  }
}
