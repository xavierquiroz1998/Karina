import 'package:flutter/material.dart';
import 'package:tesis_karina/api/solicitud_api.dart';
import 'package:tesis_karina/entity/terreno.dart';

class TerrenoProvider extends ChangeNotifier {
  List<Terreno> listTerreno = [];
  final _api = SolicitudApi();

  getListInt() async {
    final resp = await _api.getApiTerrenos();
    listTerreno = resp;
    notifyListeners();
  }

  newObjeto(Terreno e) async {
    final resp = await _api.postApiTerreno(e);
    listTerreno.add(e);
    notifyListeners();
  }

  updateObjeto(Terreno terreno) async {
    final resp = await _api.putApiTerreno(terreno);
    try {
      this.listTerreno = this.listTerreno.map((e) {
        if (terreno.uid != e.uid) return e;
        e.ubicacion = terreno.ubicacion;
        e.dimension = terreno.dimension;
        return e;
      }).toList();
      notifyListeners();
      return true;
    } catch (e) {
      throw 'Error al actualizar el terreno';
    }
  }

  deleteObjeto(Terreno e) async {
    final resp = await _api.deleteApiTerreno(e.uid);
    print(resp);
    listTerreno.remove(e);
    notifyListeners();
  }
}
