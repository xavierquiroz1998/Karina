import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tesis_karina/provider/finca_provider.dart';
import 'package:tesis_karina/style/colors/custom_colors.dart';

class MapaPage2 extends StatefulWidget {
  const MapaPage2({Key? key}) : super(key: key);

  @override
  _MapaPage2State createState() => _MapaPage2State();
}

class _MapaPage2State extends State<MapaPage2> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FincaProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Mapa'),
        backgroundColor: CustomColors.customDefaut,
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        markers: provider.getMarkers,
        initialCameraPosition: provider.kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          try {
            provider.controller.complete(controller);
          } catch (e) {
            print(e);
          }
        },
        compassEnabled: false,
        onTap: provider.onTap,
      ),
    );
  }
}
