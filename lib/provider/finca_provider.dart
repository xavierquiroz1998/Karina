import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tesis_karina/api/solicitud_api.dart';
import 'package:tesis_karina/entity/finca.dart';
import 'package:tesis_karina/utils/util_view.dart';

class FincaProvider extends ChangeNotifier {
  List<Finca> listFinca = [];
  final _api = SolicitudApi();
  final Map<MarkerId, Marker> markers = {};

  Completer controller = Completer();

  final CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(-2.190095, -79.890241),
    zoom: 14.4746,
  );

  Set<Marker> get getMarkers => markers.values.toSet();

  void limpiar() {
    markers.clear();
  }

  void onTap(LatLng position) {
    markers.clear();
    final markeId = MarkerId(markers.length.toString());
    final marker = Marker(markerId: markeId, position: position);
    markers[markeId] = marker;
    notifyListeners();
  }

  getListInt() async {
    final resp = await _api.getApiFincas();
    listFinca = resp;
    notifyListeners();
  }

  newObjeto(Finca e) async {
    if (markers.isNotEmpty) {
      var objTEmp = markers.values.first;
      e.ubicacion =
          "LT:${objTEmp.position.latitude} LG: ${objTEmp.position.longitude}";
      final resp = await _api.postApiFinca(e);
      listFinca.add(e);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  updateObjeto(Finca e) async {
    final resp = await _api.putApiFinca(e);
    try {
      this.listFinca = this.listFinca.map((en) {
        if (en.idfinca != e.idfinca) return e;
        en.nombre = e.nombre;
        en.ubicacion = e.ubicacion;
        return e;
      }).toList();

      notifyListeners();
    } catch (e) {
      throw 'Error al actualizar la Finca';
    }
  }

  deleteObjeto(Finca e) async {
    final resp = await _api.deleteApiFinca(e.idfinca);
    listFinca.remove(e);
    notifyListeners();
  }
}
