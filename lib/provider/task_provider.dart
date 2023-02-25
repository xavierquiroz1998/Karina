import 'package:flutter/material.dart';
import 'package:tesis_karina/api/solicitud_api.dart';
import 'package:tesis_karina/entity/detalle_planificacion.dart';
import 'package:tesis_karina/utils/util_view.dart';

class TaskProvider extends ChangeNotifier {
  List<Detalleplanificacion> listTask = [];
  final _api = SolicitudApi();

  getListInt() async {
    final resp = await _api.getApiListTask();
    listTask = resp;
    notifyListeners();
  }

  getListTaskUsuer() async {
    final resp =
        await _api.getApiListUserTask(UtilView.usuarioUtil.idusuarios, "1");
    listTask = resp;
    notifyListeners();
  }

  closeTask(Detalleplanificacion detalle) async {
    final resp = await _api.putApiTask(detalle);
    try {
      this.listTask = this.listTask.map((e) {
        if (detalle.iddetalleplanificacion != e.iddetalleplanificacion)
          return e;
        e.observacion2 = detalle.observacion2;
        return e;
      }).toList();
      notifyListeners();
      return true;
    } catch (e) {
      throw 'Error al actualizar el insumo';
    }
  }

  userTask(Detalleplanificacion detalle) async {
    final resp = await _api.putApiTask(detalle);
    try {
      this.listTask = this.listTask.map((e) {
        if (detalle.iddetalleplanificacion != e.iddetalleplanificacion)
          return e;
        e.observacion = detalle.observacion;
        return e;
      }).toList();
      notifyListeners();
      return true;
    } catch (e) {
      throw 'Error al actualizar el insumo';
    }
  }
}
