import 'package:flutter/material.dart';
import 'package:tesis_karina/api/solicitud_api.dart';
import 'package:tesis_karina/entity/finca.dart';
import 'package:tesis_karina/entity/insumo.dart';
import 'package:tesis_karina/entity/list_insumos.dart';
import 'package:tesis_karina/entity/personas.dart';
import 'package:tesis_karina/entity/terreno.dart';
import 'package:tesis_karina/utils/util_view.dart';

class PlanificacionProvider extends ChangeNotifier {
  List<Insumo> listInsumo = [];
  List<Terreno> listTerrenos = [];
  List<Finca> listFincas = [];
  List<Persona> listPersonas = [];
  List<Finca> listFincasSelect = [];
  List<Terreno> listTerrenosSelect = [];
  List<Insumo> listInsumoSelect = [];
  List<Persona> listPersonasSelect = [];

  TextEditingController _dateController = TextEditingController();
  TextEditingController _dateFinController = TextEditingController();

  final _api = SolicitudApi();

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

  inializacion() async {
    await getListInsumos();
    await getListTerrenos();
    await getListfincas();
    await getListPersonas();
    listFincasSelect = [];
    listTerrenosSelect = [];
    listInsumoSelect = [];
    listPersonasSelect = [];

    notifyListeners();
  }

  void grabar() async{
    try {
      var referenciaTask = UtilView.numberRandonUid();
      for (var e in listInsumoSelect) {
        var uid = UtilView.numberRandonUid();

        await _api.postApiListInsumo(
            ListInsumos(uid: uid, referencia: referenciaTask, idinsumo: e.uid));
      }
    } catch (e) {}
  }
}
