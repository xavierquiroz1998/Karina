import 'package:flutter/material.dart';
import 'package:tesis_karina/api/solicitud_api.dart';
import 'package:tesis_karina/entity/detalle_planificacion.dart';
import 'package:tesis_karina/entity/historial.dart';
import 'package:tesis_karina/entity/terreno.dart';
import 'package:tesis_karina/entity/tipos_plagas.dart';
import 'package:tesis_karina/utils/util_view.dart';

class Seguimiento3Provider extends ChangeNotifier {
  final _api = SolicitudApi();
  List<Terreno> listTerreno = [];
  List<TiposPlagas> listTplaga = [];
  late Detalleplanificacion selectDetail;
  late Terreno selectTerreno;
  late TiposPlagas selectTpPlaga;
  TextEditingController txtNovedad = TextEditingController();
  TextEditingController txtPlagas = TextEditingController();
  double porcentajeProgreso = 0;
  double valoracion = 0;
  String imgBs4 = "";

  getListPlaga() async {
    final resp = await _api.getApiTipoPlagas();
    listTplaga = resp;
    notifyListeners();
  }

  getListTerrenoOne(String uid) async {
    final resp = await _api.getApiTerreno(uid);
    if (resp != null) {
      selectTerreno = resp;
      porcentajeProgreso = 0;
      porcentajeProgreso =
          UtilView.porcentajeProceso(selectDetail.etapa, selectDetail.nivel);
    }
    notifyListeners();
  }

  saveGuardarHist() async {
    final datos = Historial(
        idhistorial: UtilView.numberRandonUid(),
        referencia: "T::${selectTerreno.idterreno}",
        observacion: txtNovedad.text,
        observacion2:
            "ACTUAL PROCESO DE EVOLUCION $porcentajeProgreso% INGRESADA POR EL USUARIO :: ${UtilView.usuarioUtil.idusuarios}",
        evaluar: valoracion.toInt(),
        carga: imgBs4);
    txtNovedad.clear();
    _api.postApiHist(datos);
  }
}
