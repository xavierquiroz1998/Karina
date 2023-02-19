import 'package:flutter/material.dart';
import 'package:tesis_karina/api/solicitud_api.dart';
import 'package:tesis_karina/entity/detalle_planificacion.dart';

class TaskProvider extends ChangeNotifier {
  List<Detalleplanificacion> listTask = [];
  final _api = SolicitudApi();

  getListInt() async {
    final resp = await _api.getApiListTask();
    listTask = resp;
    notifyListeners();
  }

  getListTaskUsuer() async {
    final resp = await _api.getApiListUserTask(
        "c1723e00-a30f-11ed-af67-7dd6fbeb535b", "0");
    listTask = resp;
    notifyListeners();
  }
}
