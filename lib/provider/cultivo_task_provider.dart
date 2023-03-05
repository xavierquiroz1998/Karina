import 'package:flutter/material.dart';
import 'package:tesis_karina/api/solicitud_api.dart';
import 'package:tesis_karina/entity/finca.dart';
import 'package:tesis_karina/entity/historial.dart';
import 'package:tesis_karina/entity/terreno.dart';
import 'package:tesis_karina/entity/tipos_plagas.dart';
import 'package:tesis_karina/utils/util_view.dart';

class CultivoTaskProvider extends ChangeNotifier {
  List<Finca> listFinca = [];
  List<Terreno> listTerreno = [];
  List<TiposPlagas> listTplaga = [];
  late Terreno selectTerreno;
  late TiposPlagas selectTpPlaga;
  final _api = SolicitudApi();
  String selectFinca = "";

  final txtNovedad = TextEditingController();
  final txtPlagas = TextEditingController();
  double porcentajeProgreso = 30;
  double valoracion = 2.8;
  String imgBs4 = "";

  getIntList() async {
    final resp = await _api.getApiFincas();
    listFinca = resp;
    notifyListeners();
  }

  getListPlaga() async {
    final resp = await _api.getApiTipoPlagas();
    listTplaga = resp;
    notifyListeners();
  }

  getListTerrenoOne(String uid) async {
    final resp = await _api.getApiTerreno(uid);
    if (resp != null) {
      selectTerreno = resp;
    }
    notifyListeners();
  }

  getListTerreno(String uid) async {
    final resp = await _api.getApiFincaAndTerreno(uid);
    listTerreno = resp;
    getListPlaga();
    notifyListeners();
  }

  saveGuardarHist() async {
    var r = selectTerreno;
    final datos = Historial(
        idhistorial: UtilView.numberRandonUid(),
        referencia: r == null ? "X" : selectTerreno.idterreno,
        observacion: txtNovedad.text,
        observacion2:
            "ACTUAL PROCESO DE EVOLUCION $porcentajeProgreso% INGRESADA POR EL USUARIO :: ${UtilView.usuarioUtil.idusuarios}",
        evaluar: valoracion.toInt(),
        carga: imgBs4);
    txtNovedad.clear();
    _api.postApiHist(datos);
  }
}
