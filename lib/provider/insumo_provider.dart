import 'package:flutter/material.dart';
import 'package:tesis_karina/api/solicitud_api.dart';
import 'package:tesis_karina/entity/insumo.dart';

class InsumoProvider extends ChangeNotifier {
  List<Insumos> listInsumo = [];
  List<String> tipoInsumo = [];
  String isTpInsumo = "TPI-01 / NOMBRE DE INSUMO";
  final _api = SolicitudApi();

  getListInt() async {
    final resp = await _api.getApiInsumos();
    listInsumo = resp;
    getTipoList();
    notifyListeners();
  }

  getTipoList() async {
    final resp1 = await _api.getApiTipoInsumos();
    tipoInsumo = resp1.map((en) {
      return "${en.idtiposinsumos} / ${en.observacion}";
    }).toList();
    print(tipoInsumo.length);
  }

  Future<bool> newObjeto(Insumos insumo) async {
    final resp = await _api.postApiInsumo(insumo);
    listInsumo.add(insumo);
    notifyListeners();
    return resp;
  }

  updateObjeto(Insumos insumo) async {
    final resp = await _api.putApiInsumo(insumo);
    try {
      this.listInsumo = this.listInsumo.map((e) {
        if (insumo.idinsumos != e.idinsumos) return e;
        e.nombre = insumo.nombre;
        e.fechaCaducidad = insumo.fechaCaducidad;
        e.unidades = insumo.unidades;
        return e;
      }).toList();
      notifyListeners();
      return true;
    } catch (e) {
      throw 'Error al actualizar el insumo';
    }
  }

  deleteObjeto(Insumos e) async {
    final resp = await _api.deleteApiInsumo(e.idinsumos);
    print(resp);
    listInsumo.remove(e);
    notifyListeners();
  }
}
