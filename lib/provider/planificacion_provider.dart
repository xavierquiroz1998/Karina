import 'package:flutter/material.dart';
import 'package:tesis_karina/api/solicitud_api.dart';
import 'package:tesis_karina/entity/planificacion.dart';
import 'package:tesis_karina/entity/finca.dart';
import 'package:tesis_karina/entity/insumo.dart';
import 'package:tesis_karina/entity/list_insumos.dart';
import 'package:tesis_karina/entity/list_personal.dart';
import 'package:tesis_karina/entity/list_terrenos.dart';
import 'package:tesis_karina/entity/personas.dart';
import 'package:tesis_karina/entity/terreno.dart';
import 'package:tesis_karina/utils/util_view.dart';

class PlanificacionProvider extends ChangeNotifier {
  List<Insumos> listInsumo = [];
  List<Terreno> listTerrenos = [];
  List<Terreno> listTerrenosTemp = [];
  List<Finca> listFincas = [];
  List<Persona> listPersonas = [];
  Finca? fincasSelect;
  List<Terreno> listTerrenosSelect = [];
  List<Insumos> listInsumoSelect = [];
  List<Persona> listPersonasSelect = [];

  TextEditingController _dateController = TextEditingController();
  TextEditingController _dateFinController = TextEditingController();

  TextEditingController disponibleController = TextEditingController();
  TextEditingController humedadFinController = TextEditingController();
  TextEditingController temperaturaFinController = TextEditingController();
  TextEditingController observacionFinController = TextEditingController();

  final _api = SolicitudApi();
// #region get and set

  TextEditingController get dateFinController => _dateFinController;

  set dateFinController(TextEditingController value) {
    _dateFinController = value;
  }

  TextEditingController get dateController => _dateController;

  set dateController(TextEditingController value) {
    _dateController = value;
  }

  getListInsumos() async {
    final resp = await _api.getApiInsumos();
    listInsumo = resp;
    //notifyListeners();
  }

  getListTerrenos() async {
    final resp = await _api.getApiTerrenos();
    listTerrenos = resp;
    listTerrenosTemp = resp;
    //notifyListeners();
  }

  getListfincas() async {
    final resp = await _api.getApiFincas();
    listFincas = resp;
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
      await getListInsumos();
      await getListTerrenos();
      await getListfincas();
      await getListPersonas();
      fincasSelect = null;
      listTerrenosSelect = [];
      listInsumoSelect = [];
      listPersonasSelect = [];

      notifyListeners();
    } catch (e) {}
  }

  Future<bool> grabar() async {
    try {
      var referenciaTask = UtilView.numberRandonUid();
      var uidInsumos = "";

      String idFinca = fincasSelect!.idfinca;
      // insumos
      for (var e in listInsumoSelect) {
        uidInsumos = UtilView.numberRandonUid();

        await _api.postApiListInsumo(ListInsumos(
            idlistadeInsumos: uidInsumos,
            idPlanificacion: referenciaTask,
            idInsumo: e.idinsumos,
            estado: 1,
            unidad: ''));
      }

      var uidPersonal = "";
      // personal
      var usuario = "c1723e00-a30f-11ed-af67-7dd6fbeb535b";
      for (var e in listPersonasSelect) {
        uidPersonal = UtilView.numberRandonUid();

        await _api.postApiListPersonal(ListPersonal(
            idlistadepersonal: uidPersonal,
            idPlanificacion: referenciaTask,
            idPersonal: usuario,
            estado: 1));
      }

      var uidTerrenos = "";
      // terrenos
      for (var e in listTerrenosSelect) {
        uidTerrenos = UtilView.numberRandonUid();

        await _api.postApiListTerrenos(ListTerrenos(
            uid: uidTerrenos,
            referencia: referenciaTask,
            idTerreno: e.idterreno));
      }

      var observacio = observacionFinController.text;
      var temperatura = temperaturaFinController.text;
      var humedad = humedadFinController.text;
      var disponible = int.parse(disponibleController.text);
      var estado = 1;
      var fechaInicio = DateTime.parse(dateController.text);
      var fechafin = DateTime.parse(dateFinController.text);

      Planificacion tarea = Planificacion(
          idplanificacion: referenciaTask,
          idFinca: idFinca,
          // idTerreno: uidTerrenos,
          // disponible: disponible,
          humedad: humedad,
          temperatura: temperatura,
          idListInsumo: uidInsumos,
          idListPersonal: uidPersonal,
          idUsuario: usuario,
          observacion: observacio,
          observacion2: observacio,
          fechaI: fechaInicio,
          fechaF: fechafin,
          estado: true);

      await _api.postApiTask(tarea);
      return true;
    } catch (e) {
      print("Error al guardar task ${e.toString()}");
      return false;
    }
  }
}
