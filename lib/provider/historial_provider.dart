import 'package:flutter/material.dart';
import 'package:tesis_karina/api/solicitud_api.dart';
import 'package:tesis_karina/entity/detalle_planificacion.dart';
import 'package:tesis_karina/entity/historial.dart';
import 'package:tesis_karina/entity/terreno.dart';

class HistorialProvider extends ChangeNotifier {
  //List<Historial> listHistorial = [];
  List<Terreno> listTerreno = [];
  List<Detalleplanificacion> listDetail = [];
  final _api = SolicitudApi();

/*   getListInt() async {
    final resp = await _api.getApiHistorial();
    listHistorial = resp;
    notifyListeners();
  } */

  getListTerreno(String uid) async {
    final resp = await _api.getApiFincaAndTerreno(uid);
    listTerreno = resp;
    notifyListeners();
  }

  getListIntDetail2() async {
    final resp = await _api.getApiListTask();
    listDetail = resp;
    listDetail = getListNew();
    notifyListeners();
  }

  List<Detalleplanificacion> getListNew() {
    List<Detalleplanificacion> t = [];
    if (listTerreno.isEmpty) {
    } else {
      for (var element in listTerreno) {
        for (var e in listDetail) {
          if (element.idterreno == e.idTerreno) {
            t.add(e);
          }
        }
      }
    }

    return t;
  }
}
