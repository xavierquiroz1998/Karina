import 'package:flutter/material.dart';
import 'package:tesis_karina/ui/layouts/cronograma_page.dart';
import 'package:tesis_karina/ui/layouts/dashboard_page.dart';
import 'package:tesis_karina/ui/layouts/login_page.dart';
import 'package:tesis_karina/ui/layouts/matenimiento_page.dart';
import 'package:tesis_karina/ui/layouts/report_page.dart';
import 'package:tesis_karina/ui/layouts/seguimiento_page.dart';
import 'package:tesis_karina/ui/layouts/task_page.dart';
import 'package:tesis_karina/ui/layouts/usuario_page.dart';

final routes = <String, WidgetBuilder>{
  //auth
  '/': (context) => const LoginPage(),

  //OPCION PRINCIPAL
  '/dashboard': (context) => const DashboardPage(),

  //DASBOARD OPT
  '/dashboard/mantenimientos': (context) => const MatenimientoPage(),
  '/dashboard/controlCronograma': (context) => CronogramaPage(),
  '/dashboard/controlReporte': (context) => ReportPage(),
  '/dashboard/controlSeguimiento': (context) => SeguiminentoPage(),
  '/dashboard/controlTareas': (context) => TaskPage(),
  //FIN

  //VISTAS COMPLETAS --> complemento del dashboard
  '/dashboard/usuario': (context) => const UsuarioPage(),
};
