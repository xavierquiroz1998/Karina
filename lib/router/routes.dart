import 'package:flutter/material.dart';
import 'package:tesis_karina/ui/layouts/dashboard_page.dart';
import 'package:tesis_karina/ui/layouts/login_page.dart';
import 'package:tesis_karina/ui/layouts/matenimiento_page.dart';

final routes = <String, WidgetBuilder>{
  '/': (context) => const LoginPage(),
  '/dashboard': (context) => const DashboardPage(),
  '/dashboard/mantenimientos': (context) => const MatenimientoPage(),
};
