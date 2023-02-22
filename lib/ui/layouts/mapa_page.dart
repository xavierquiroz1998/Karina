import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tesis_karina/provider/terreno_provider.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({Key? key}) : super(key: key);

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TerrenoProvider>(context);

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Mapa')),
      body: GoogleMap(
        mapType: MapType.normal,
        markers: provider.getMarkers,
        initialCameraPosition: provider.kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          provider.controller.complete(controller);
        },
        compassEnabled: false,
        onTap: provider.onTap,
      ),
    );
  }
}



/* 

  Set<Marker> listMarker = {
     
          Marker(
            markerId: MarkerId("Cojapan"),
            position: LatLng(-2.1900852, -79.890274),
          ),
          Marker(
            markerId: MarkerId("Cojapan"),
            position: LatLng(-2.1900852, -79.890274),
          ),
          Marker(
            markerId: MarkerId("Cojapan"),
            position: LatLng(-2.1900852, -79.890274),
          ),

        
  };

 */