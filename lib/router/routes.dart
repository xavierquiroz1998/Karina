import 'package:flutter/material.dart';
import 'package:tesis_karina/ui/layouts/login_page.dart';

final routes = <String, WidgetBuilder>{
  '/': (context) => const LoginPage(),
  '/dashboard': (context) => const LoginPage(),
  '/dashboard/gestion/usuarios': (context) => const LoginPage(),
  '/dashboard/gestion/insumos': (context) => const LoginPage(),
  '/dashboard/gestion/terrenos': (context) => const LoginPage(),
  '/dashboard/gestion/enfermedades': (context) => const LoginPage(),
  '/dashboard/gestion/maquinarias': (context) => const LoginPage(),
};
