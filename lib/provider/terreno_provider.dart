import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tesis_karina/api/solicitud_api.dart';
import 'package:tesis_karina/entity/finca.dart';
import 'package:tesis_karina/entity/terreno.dart';
import 'package:tesis_karina/utils/util_view.dart';

class TerrenoProvider extends ChangeNotifier {
  List<Terreno> listTerreno = [];
  List<Finca> listFincas = [];
  late Finca selectFinca;
  final _api = SolicitudApi();
  final Map<MarkerId, Marker> markers = {};

  Completer controller = Completer();

  final CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(-2.190095, -79.890241),
    zoom: 14.4746,
  );

  Set<Marker> get getMarkers => markers.values.toSet();

  getListInt() async {
    final resp = await _api.getApiTerrenos();
    listTerreno = resp;
    getListInt2();
    notifyListeners();
  }

  getListInt2() async {
    final resp = await _api.getApiFincas();
    listFincas = resp;
  }

  void limpiar() {
    markers.clear();
  }

  newObjeto(Terreno e) async {
    if (markers.isNotEmpty) {
      var objTEmp = markers.values.first;
      e.longitud = "${objTEmp.position.longitude}";
      e.latitud = "${objTEmp.position.latitude}";
      final resp = await _api.postApiTerreno(e);
      listTerreno.add(e);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  void onTap(LatLng position) {
    markers.clear();
    final markeId = MarkerId(markers.length.toString());
    final marker = Marker(markerId: markeId, position: position);
    markers[markeId] = marker;
    notifyListeners();
  }

  updateObjeto(Terreno terreno) async {
    final resp = await _api.putApiTerreno(terreno);
    try {
      this.listTerreno = this.listTerreno.map((e) {
        if (terreno.idterreno != e.idterreno) return e;
        e.ubicacion = terreno.ubicacion;
        e.dimension = terreno.dimension;
        return e;
      }).toList();
      notifyListeners();
      return true;
    } catch (e) {
      throw 'Error al actualizar el terreno';
    }
  }

  deleteObjeto(Terreno e) async {
    final resp = await _api.deleteApiTerreno(e.idterreno);
    print(resp);
    listTerreno.remove(e);
    notifyListeners();
  }
}
