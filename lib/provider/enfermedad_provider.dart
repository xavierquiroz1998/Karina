import 'package:flutter/material.dart';
import 'package:tesis_karina/api/solicitud_api.dart';
import 'package:tesis_karina/entity/enfermedad.dart';
import 'package:tesis_karina/utils/util_view.dart';

class EnfermedadProvider extends ChangeNotifier {
  final _api = SolicitudApi();
  late Enfermedades isSelectEnfermedad;
  List<Enfermedades> listEnfermedad = [];
  List<String> tiposEnfermedad = [];
  List<String> tiposPlagas = [];

  String isSelectE = "";
  String isSelectP = "";
  bool isTipo = true;

  TextEditingController txtNombre = TextEditingController();
  TextEditingController txtEspecificaciones = TextEditingController();
  TextEditingController txtTratamiento = TextEditingController();
  TextEditingController txtObservaciones = TextEditingController();
  String fotografia = "";

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

  newObjeto() async {
    final e = Enfermedades(
        idenfermedades: UtilView.numberRandonUid(),
        nombre: txtNombre.text,
        observacion: txtObservaciones.text,
        enfermedadTipoId: isSelectE.split("/")[0].trim(),
        plagasTipoId: isSelectP.split("/")[0].trim(),
        fotografia: fotografia,
        tratamiento: txtTratamiento.text,
        especificaciones: txtEspecificaciones.text,
        estado: 1);
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
        en.tratamiento = e.tratamiento;
        en.fotografia = e.fotografia;

        return en;
      }).toList();
      notifyListeners();
    } catch (e) {
      throw 'Error al actualizar la enfermedad';
    }
  }

  searchList1(String value) {
    String resp = "";
    for (var element in tiposEnfermedad) {
      if (element.contains(value)) {
        resp = element;
      }
    }
    return resp;
  }

  searchList2(String value) {
    String resp = "";
    for (var element in tiposPlagas) {
      if (element.contains(value)) {
        resp = element;
      }
    }
    return resp;
  }

  mergerObjeto(Enfermedades e) {
    txtNombre.text = e.nombre;
    txtEspecificaciones.text = e.especificaciones;
    txtTratamiento.text = e.tratamiento;
    txtObservaciones.text = e.observacion;
    fotografia = e.fotografia.length > 2 ? e.fotografia : "";
    isSelectP = searchList2(e.plagasTipoId);
    isSelectE = searchList1(e.enfermedadTipoId);
  }

  clearObjeto() {
    txtNombre.text = "";
    txtEspecificaciones.text = "";
    txtTratamiento.text = "";
    txtObservaciones.text = "";
    fotografia = "";
    isSelectE = tiposEnfermedad[0];
    isSelectP = tiposPlagas[0];
  }

  deleteObjeto(Enfermedades e) async {
    final resp = await _api.deleteApiEnfermedad(e.idenfermedades);
    print(resp);
    listEnfermedad.remove(e);
    notifyListeners();
  }
}
