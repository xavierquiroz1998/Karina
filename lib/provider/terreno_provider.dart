import 'package:flutter/material.dart';
import 'package:tesis_karina/entity/terreno.dart';

class TerrenoProvider extends ChangeNotifier {
  List<Terreno> listTerreno = [];
  getListInt() async {
    //final resp = await _api.getProductPaginado(empresa, cantidad, limit);
    notifyListeners();
  }
}
