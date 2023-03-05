import 'package:flutter/material.dart';
import 'package:tesis_karina/style/colors/custom_colors.dart';
import 'package:tesis_karina/utils/util_view.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime anio = DateTime.now();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Inicio'),
          backgroundColor: CustomColors.customDefaut,
        ),
        drawer: const MenuLateral(),
        body: Column(
          children: [
            const Spacer(),
            const Center(
              child: Image(
                width: 250.0,
                height: 250.0,
                image: AssetImage('assets/logoArroz.png'),
              ),
            ),
            const Spacer(),
            Text(
              'Copyrigh (c) ${anio.year}',
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            )
          ],
        ));
  }
}

class MenuLateral extends StatelessWidget {
  const MenuLateral({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 270,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              //decoration: const BoxDecoration(color: Palette.cojapanColor),
              child: Column(
                children: [
                  const SizedBox(height: 2),
                  const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 50,
                    child: Image(
                      height: 100,
                      width: 100,
                      image: AssetImage('assets/user.png'),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    UtilView.usuarioUtil.rol.toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    UtilView.usuarioUtil.correo,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              )),
          if (UtilView.usuarioUtil.rol == "Admin" ||
              UtilView.usuarioUtil.rol == "Jefe de cuadrilla" ||
              UtilView.usuarioUtil.rol == "Jornaleros")
            ListTile(
              leading: const Icon(Icons.store_mall_directory_rounded,
                  color: Colors.blueGrey),
              title: const Text("Mantenimiento"),
              onTap: () async =>
                  Navigator.pushNamed(context, '/dashboard/mantenimientos'),
            ),
          /*  if (UtilView.usuarioUtil.rol == "Admin" ||
              UtilView.usuarioUtil.rol == "Jefe de cuadrilla") */
          ListTile(
            leading: const Icon(Icons.task_rounded, color: Colors.blueGrey),
            title: const Text("Tareas"),
            onTap: () async =>
                Navigator.pushNamed(context, '/dashboard/controlTareas'),
          ),
          if (UtilView.usuarioUtil.rol == "Jefe de cuadrilla")
            ListTile(
              leading: const Icon(Icons.work_history_rounded,
                  color: Colors.blueGrey),
              title: const Text("Orden de trabajo"),
              onTap: () async =>
                  Navigator.pushNamed(context, '/dashboard/controlCronograma'),
            ),
          if (UtilView.usuarioUtil.rol == "Jefe de cuadrilla")
            ListTile(
              leading: const Icon(Icons.work_history_rounded,
                  color: Colors.blueGrey),
              title: const Text("Detalle de orden"),
              onTap: () async => Navigator.pushNamed(
                  context, '/dashboard/controlDetailCronograma'),
            ),
          if (UtilView.usuarioUtil.rol == "Jefe de cuadrilla")
            ListTile(
              leading: const Icon(Icons.task_rounded, color: Colors.blueGrey),
              title: const Text("Seguimiento de cultivo"),
              onTap: () async =>
                  Navigator.pushNamed(context, '/dashboard/controlSeguimiento'),
            ),
          if (UtilView.usuarioUtil.rol == "Admin" ||
              UtilView.usuarioUtil.rol == "Jefe de cuadrilla")
            ListTile(
              leading: const Icon(Icons.task_rounded, color: Colors.blueGrey),
              title: const Text("Generacion de reportes"),
              onTap: () async =>
                  Navigator.pushNamed(context, '/dashboard/controlReporte'),
            ),
          ListTile(
            leading: const Icon(Icons.exit_to_app_outlined, color: Colors.red),
            title: const Text("Salir"),
            onTap: () async {
              Navigator.of(context).pushReplacementNamed('/');
              /* await LocalStorage.removeCache("usuario").whenComplete(() {
                Navigator.of(context).pushReplacementNamed('/login');
              }); */
            },
          ),
        ],
      ),
    );
  }
}
