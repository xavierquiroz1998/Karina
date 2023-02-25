import 'package:flutter/material.dart';
import 'package:tesis_karina/style/colors/custom_colors.dart';
import 'package:tesis_karina/ui/view/enfermedades_view.dart';
import 'package:tesis_karina/ui/view/finca_view.dart';
import 'package:tesis_karina/ui/view/insumos_view.dart';
import 'package:tesis_karina/ui/view/maquinarias_view.dart';
import 'package:tesis_karina/ui/view/terrenos_view.dart';
import 'package:tesis_karina/ui/view/usuarios_view.dart';

class MatenimientoPage extends StatelessWidget {
  const MatenimientoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: Colors.grey[600],
        appBar: AppBar(
          backgroundColor: CustomColors.customDefaut,
          bottom: const TabBar(
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(
                  icon: Icon(Icons.medication_sharp),
                  child: Text('Enfermedades')),
              Tab(
                  icon: Icon(Icons.medication_liquid_sharp),
                  child: Text('Insumos')),
              Tab(
                  icon: Icon(Icons.local_shipping_outlined),
                  child: Text('Maquinarias')),
              Tab(
                  icon: Icon(Icons.dashboard_customize_sharp),
                  child: Text('Terrenos')),
              Tab(icon: Icon(Icons.cabin_rounded), child: Text('Finca')),
              Tab(
                  icon: Icon(Icons.supervised_user_circle_sharp),
                  child: Text('Usuarios')),
            ],
          ),
          title: const Text('Matenimientos'),
        ),
        body: const TabBarView(
          children: [
            EnfermedadesView(),
            InsumosView(),
            MaquinariasView(),
            TerrenosView(),
            FincaView(),
            UsuariosView(),
          ],
        ),
      ),
    );
  }
}
