import 'package:flutter/material.dart';
import 'package:tesis_karina/api/solicitud_api.dart';
import 'package:tesis_karina/entity/detalle_planificacion.dart';
import 'package:tesis_karina/entity/historial.dart';

class HistorialProvider extends ChangeNotifier {
  List<Historial> listHistorial = [];
  List<Detalleplanificacion> listDetail = [];
  final _api = SolicitudApi();

  getListInt() async {
    final resp = await _api.getApiHistorial();
    listHistorial = resp;
    notifyListeners();
  }

  getListIntDetail() async {
    final resp = await _api.getApiListTask();
    listDetail = resp;
    notifyListeners();
  }
}
