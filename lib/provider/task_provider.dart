import 'package:flutter/material.dart';
import 'package:tesis_karina/api/solicitud_api.dart';
import 'package:tesis_karina/entity/detalle_planificacion.dart';
import 'package:tesis_karina/entity/insumo.dart';
import 'package:tesis_karina/entity/list_insumos.dart';
import 'package:tesis_karina/entity/list_maquinaria.dart';
import 'package:tesis_karina/entity/list_personal.dart';
import 'package:tesis_karina/entity/maquinaria.dart';
import 'package:tesis_karina/entity/personas.dart';
import 'package:tesis_karina/utils/util_view.dart';

class TaskProvider extends ChangeNotifier {
  List<Detalleplanificacion> listTask = [];
  List<Persona> listPersonas = [];
  List<Persona> listPersonasSelect = [];

  List<Maquinaria> listMaquinarias = [];
  List<Maquinaria> listMaquinariasSelect = [];

  List<Insumos> listInsumo = [];
  List<Insumos> listInsumoSelect = [];

  bool valueI = false;
  bool valueP = false;
  bool valueM = false;

  String codigoPersona = "";

  final _api = SolicitudApi();

  getListInt() async {
    final resp = await _api.getApiListTask();
    listTask = resp;
    notifyListeners();
  }

  inializacion() async {
    try {
      await getListInsumos();
      await getListPersonas();
      await getListMaquinarias();

      listInsumoSelect = [];
      listPersonasSelect = [];
      listMaquinariasSelect = [];

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  saveList(String uid) {
    if (listInsumoSelect.isNotEmpty) {
      for (var e in listInsumoSelect) {
        _api.postApiListInsumo(ListInsumos(
            idlistadeInsumos: UtilView.numberRandonUid(),
            idInsumo: e.idinsumos,
            idPlanificacion: uid,
            unidad: "0",
            estado: 1));
      }
    }
    if (listPersonasSelect.isNotEmpty) {
      for (var e in listPersonasSelect) {
        _api.postApiListPersonal(ListPersonal(
            idlistadepersonal: UtilView.numberRandonUid(),
            idPersonal: e.idpersonas,
            idPlanificacion: uid,
            estado: 1));
      }
    }
    if (listMaquinariasSelect.isNotEmpty) {
      for (var e in listMaquinariasSelect) {
        _api.postApiListMaquinaria(ListMaquinarias(
            idlistamaquinaria: UtilView.numberRandonUid(),
            idMaquinaria: e.idmaquinarias,
            idPlanificacion: uid,
            estado: true));
      }
    }
  }

  getListInsumos() async {
    final resp = await _api.getApiInsumos();
    listInsumo = resp;
    //notifyListeners();
  }

  getListMaquinarias() async {
    final resp = await _api.getApiMaquinarias();
    listMaquinarias = resp;
    //notifyListeners();
  }

  getListPersonas() async {
    final resp = await _api.getApiPersonas();
    listPersonas = resp;
    //notifyListeners();
  }

  getListTaskUsuer() async {
    await getIdPersona();
    final resp = await _api.getApiListUserTask(codigoPersona, "1");
    listTask = resp;
    notifyListeners();
  }

  getIdPersona() async {
    await getListPersonas();

    for (var e in listPersonas) {
      if (e.idUsuario == UtilView.usuarioUtil.idusuarios) {
        codigoPersona = e.idpersonas;
      }
    }
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
