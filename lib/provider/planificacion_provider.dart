import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tesis_karina/api/solicitud_api.dart';
import 'package:tesis_karina/entity/detalle_planificacion.dart';
import 'package:tesis_karina/entity/list_insumos.dart';
import 'package:tesis_karina/entity/list_personal.dart';
import 'package:tesis_karina/entity/list_terrenos.dart';
import 'package:tesis_karina/entity/maquinaria.dart';
import 'package:tesis_karina/entity/planificacion.dart';
import 'package:tesis_karina/entity/finca.dart';
import 'package:tesis_karina/entity/insumo.dart';
import 'package:tesis_karina/entity/personas.dart';
import 'package:tesis_karina/entity/terreno.dart';
import 'package:tesis_karina/entity/tipos_graminea.dart';
import 'package:tesis_karina/utils/util_view.dart';

class PlanificacionProvider extends ChangeNotifier {
  List<Insumos> listInsumo = [];
  List<Terreno> listTerrenos = [];
  List<Terreno> listTerrenosTemp = [];
  List<Finca> listFincas = [];
  List<Persona> listPersonas = [];
  List<TiposGraminea> listGraminea = [];
  List<Maquinaria> listMaquinarias = [];
  Finca? fincasSelect;
  List<Terreno> listTerrenosSelect = [];
  List<Insumos> listInsumoSelect = [];
  List<TiposGraminea> listGramineaSelect = [];
  List<Persona> listPersonasSelect = [];
  List<Maquinaria> listMaquinariasSelect = [];
  List<Detalleplanificacion> listDetailPlanificacion = [];
  List<Planificacion> listPlanificacion = [];

//VARIABLES DE LA CABECERA DEL DETALLE
  TextEditingController dateController = TextEditingController(
      text: DateFormat("dd/MM/yyyy").format(DateTime.now()));
  TextEditingController dateFinController =
      TextEditingController(text: UtilView.dateSumDay(60));
  TextEditingController disponibleController = TextEditingController();
  TextEditingController humedadFinController = TextEditingController();
  TextEditingController temperaturaFinController = TextEditingController();
  TextEditingController observacionFinController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController ctrSearch = TextEditingController();
  TextEditingController txtName = TextEditingController();

//DETALLE
  Planificacion? planificacionSelect;
  Terreno? terrenoSelect;
  TextEditingController actvDetailController = TextEditingController();
  TextEditingController obsDetailController = TextEditingController();
  final txtDetailInicio = TextEditingController(
      text: DateFormat("dd/MM/yyyy").format(DateTime.now()));
  final txtDetailFin = TextEditingController();
  bool isDetail = true;

  final _api = SolicitudApi();

  set setIsDetail(bool value) {
    isDetail = value;
    notifyListeners();
  }

  getIntDetail() async {
    try {
      final resp = await _api.getApiTask();
      await getListInsumos();
      await getListTerrenosDetail();
      await getListfincas();
      await getListPersonas();
      await getListMaquinarias();
      await getListGraminea();
      planificacionSelect = null;
      terrenoSelect = null;
      listTerrenosSelect = [];
      listInsumoSelect = [];
      listPersonasSelect = [];
      listMaquinariasSelect = [];
      listPlanificacion = resp;
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  getIntDetail2() async {
    try {
      final resp = await _api.getApiListTask();
      await getListfincas();
      listDetailPlanificacion = resp;
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  getListTerrenosDetail() async {
    final resp = await _api.getApiTerrenos();
    listTerrenos = resp;
//    notifyListeners();
  }

  getListInsumos() async {
    try {
      final resp = await _api.getApiInsumos();
      listInsumo = resp;
    } catch (e) {
      rethrow;
    }

    //notifyListeners();
  }

  update() async {
    notifyListeners();
  }

  getListGraminea() async {
    try {
      final resp = await _api.getApiTipoGraminea();
      listGraminea = resp;
    } catch (e) {
      rethrow;
    }

    //notifyListeners();
  }

  getListTerrenos() async {
    listTerrenos.clear();
    listTerrenosTemp.clear();
    final resp = await _api.getApiFincaAndTerreno(fincasSelect!.idfinca);
    listTerrenos = resp;
    listTerrenosTemp = resp;
    notifyListeners();
  }

  getListfincas() async {
    final resp = await _api.getApiFincas();
    listFincas = resp;
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

// #endregion
  inializacion() async {
    try {
      await getListfincas();
      fincasSelect = null;
    } catch (e) {
      rethrow;
    }
  }

  limpiar2() {
    planificacionSelect = null;
    terrenoSelect = null;

/*     listGramineaSelect = [];
    listTerrenosSelect = [];
    listInsumoSelect = [];
    listPersonasSelect = [];
    listMaquinariasSelect = []; */

    actvDetailController.clear();
    obsDetailController.clear();
    txtDetailInicio.text = DateFormat("dd/MM/yyyy").format(DateTime.now());
    txtDetailFin.clear();

    notifyListeners();
  }

  limpiar() {
    nombreController.clear();
    fincasSelect = null;
    humedadFinController.clear();
    temperaturaFinController.clear();
    observacionFinController.clear();
    dateController.clear();
    dateFinController.clear();
    notifyListeners();
  }

  Future<bool> grabar() async {
    bool saveCab = false;
    try {
      var fechaInicio = DateTime.parse(dateController.text);
      var fechafin = DateTime.parse(dateFinController.text);

      Planificacion tarea = Planificacion(
          idplanificacion: UtilView.numberRandonUid(),
          nombre: nombreController.text,
          idFinca: fincasSelect!.idfinca,
          humedad: humedadFinController.text,
          temperatura: temperaturaFinController.text,
          idListInsumo: "",
          idListPersonal: "",
          idUsuario: UtilView.usuarioUtil.idusuarios,
          observacion: "-",
          observacion2: observacionFinController.text,
          observacion3: "-",
          fechaI: fechaInicio,
          fechaF: fechafin,
          estado: true);
      saveCab = await _api.postApiTask(tarea);
      if (saveCab) {
        limpiar();
      }
    } catch (e) {
      print("Error al guardar task ${e.toString()}");
    }
    return saveCab;
  }

  Future<bool> graba2(Detalleplanificacion deta) async {
    bool saveDet = false;

    try {
      for (var e in listInsumoSelect) {
        await _api.postApiListInsumo(ListInsumos(
            idlistadeInsumos: UtilView.numberRandonUid(),
            idPlanificacion: deta.idPlanificacion,
            idInsumo: e.idinsumos,
            estado: 1,
            unidad: "${e.cantidad}"));

        await _api.putApiInsumo(e);
      }

      for (var e in listPersonasSelect) {
        await _api.postApiListPersonal(ListPersonal(
            idlistadepersonal: UtilView.numberRandonUid(),
            idPlanificacion: deta.iddetalleplanificacion,
            idPersonal: e.idpersonas,
            estado: 1));
      }

      for (var e in listGramineaSelect) {
        await _api.postApiListTerrenos(ListTerrenos(
            idlistadeterrenos: UtilView.numberRandonUid(),
            idTerreno: terrenoSelect!.idterreno,
            idPlanificacion: deta.idPlanificacion,
            idenfermedad: "",
            idGramineas: e.idtipograminea,
            ocupado: true,
            estado: true));
      }

      saveDet = await _api.postApiTaskDet(deta);

      if (saveDet) {
        limpiar2();
      }
    } catch (e) {
      print("Error al guardar task ${e.toString()}");
    }
    return saveDet;
  }
}
