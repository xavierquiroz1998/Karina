import 'package:flutter/material.dart';
import 'package:tesis_karina/api/solicitud_api.dart';
import 'package:tesis_karina/entity/terreno.dart';

class TerrenoProvider extends ChangeNotifier {
  List<Terreno> listTerreno = [];
  final _api = SolicitudApi();

  final txtUbicacion = TextEditingController();
  final txtDimension = TextEditingController();
  final txtUnidad = TextEditingController();

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

  updateObjeto(Terreno e) async {
    final resp = await _api.putApiTerreno(e);
    try {
      listTerreno = listTerreno.map((en) {
        if (en.uid != e.uid) return e;
        e.ubicacion = e.ubicacion;
        e.dimension = e.dimension;
        return e;
      }).toList();
      notifyListeners();
    } catch (e) {
      throw 'Error al actualizar la enfermedad';
    }
  }

  deleteObjeto(Terreno e) async {
    final resp = await _api.deleteApiTerreno(e.uid);
    print(resp);
    listTerreno.remove(e);
    notifyListeners();
  }
}
