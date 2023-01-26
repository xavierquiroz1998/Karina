import 'package:flutter/material.dart';
import 'package:tesis_karina/entity/enfermedad.dart';

class EnfermedadProvider extends ChangeNotifier {
  List<Enfermedad> listEnfermedad = [];
  //final _api = SolicitudApi();

  getListInt() async {
    final resp = [
      Enfermedad(
          uid: "E01",
          nombre: "piricularia",
          grado: "Medio",
          ingreso: "10/01/20223",
          estado: "A")
    ];
    //final resp = await _api.getApiEnfermedades();
    listEnfermedad = resp;
  }

  newObjeto(Enfermedad e) {
    listEnfermedad.add(Enfermedad(
        uid: "E01",
        nombre: "piricularia",
        grado: "Medio",
        ingreso: "10/01/20223",
        estado: "A"));
    notifyListeners();
  }

  updateObjeto(Enfermedad e) {}

  deleteObjeto(Enfermedad e) {
    listEnfermedad.remove(e);
    notifyListeners();
  }
}
