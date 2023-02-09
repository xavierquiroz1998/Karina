import 'package:flutter/material.dart';
import 'package:tesis_karina/api/solicitud_api.dart';
import 'package:tesis_karina/entity/terreno.dart';

class SeguimientoProvider extends ChangeNotifier {
  List<Terreno> listTerreno = [];
  final _api = SolicitudApi();

  final txtNovedad = TextEditingController();
  final txtPlagas = TextEditingController();
  double porcentajeProgreso = 30;
  double valoracion = 2.8;
  String imgBs4 = "";

  getListTerreno() async {
    final resp = await _api.getApiTerrenos();
    listTerreno = resp;
    notifyListeners();
  }
}
