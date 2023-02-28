import 'package:flutter/material.dart';
import 'package:tesis_karina/ui/layouts/enfermedad_page.dart';
import 'package:tesis_karina/ui/layouts/mapa_page.dart';
import 'package:tesis_karina/ui/layouts/mapa_page2.dart';
import 'package:tesis_karina/ui/layouts/observaciones_page.dart';
import 'package:tesis_karina/ui/layouts/planificacion_page.dart';
import 'package:tesis_karina/ui/layouts/dashboard_page.dart';
import 'package:tesis_karina/ui/layouts/login_page.dart';
import 'package:tesis_karina/ui/layouts/matenimiento_page.dart';
import 'package:tesis_karina/ui/layouts/report_page.dart';
import 'package:tesis_karina/ui/layouts/seguimiento_page.dart';
import 'package:tesis_karina/ui/layouts/seguimiento_page2.dart';
import 'package:tesis_karina/ui/layouts/task_page.dart';
import 'package:tesis_karina/ui/layouts/usuario_page.dart';

final routes = <String, WidgetBuilder>{
  //auth
  '/': (context) => const LoginPage(),

  //OPCION PRINCIPAL
  '/dashboard': (context) => const DashboardPage(),

  //DASBOARD OPT
  '/dashboard/mantenimientos': (context) => const MatenimientoPage(),
  '/dashboard/controlCronograma': (context) => const PlanificacionPage(),
  '/dashboard/controlReporte': (context) => const ReportPage(),
  '/dashboard/controlSeguimiento': (context) => const SeguiminentoPage(),
  '/dashboard/controlSeguimiento2': (context) => const SeguiminentoPage2(),
  '/dashboard/controlTareas': (context) => const TaskPage(),
  //FIN

  //VISTAS COMPLETAS --> complemento del dashboard
  '/dashboard/usuario': (context) => const UsuarioPage(),
  '/dashboard/enfermedad': (context) => const EnfermedadPage(),
  '/dashboard/controlObservaciones': (context) => const ObservacionPage(),
  '/dashboard/selectMapa': (context) => const MapaPage(),
  '/dashboard/selectMapa2': (context) => const MapaPage2(),
};
