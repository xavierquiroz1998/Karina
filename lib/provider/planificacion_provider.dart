import 'package:flutter/material.dart';
import 'package:tesis_karina/api/solicitud_api.dart';
import 'package:tesis_karina/entity/finca.dart';
import 'package:tesis_karina/entity/insumo.dart';
import 'package:tesis_karina/entity/terreno.dart';

class PlanificacionProvider extends ChangeNotifier {
  List<Insumo> listInsumo = [];
  List<Terreno> listTerrenos = [];
  List<Finca> listFincas = [];
  List<Finca> listFincasSelect = [];
  List<Terreno> listTerrenosSelect = [];
  List<Insumo> listInsumoSelect = [];

  TextEditingController _dateController = TextEditingController();
  TextEditingController _dateFinController = TextEditingController();

  TextEditingController get dateFinController => _dateFinController;

  set dateFinController(TextEditingController value) {
    _dateFinController = value;
  }

  TextEditingController get dateController => _dateController;

  set dateController(TextEditingController value) {
    _dateController = value;
  }

  final _api = SolicitudApi();

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

  inializacion() async {
    await getListInsumos();
    await getListTerrenos();
    await getListfincas();
    listFincasSelect = [];
    listTerrenosSelect = [];
    listInsumoSelect = [];

    notifyListeners();
  }
}
