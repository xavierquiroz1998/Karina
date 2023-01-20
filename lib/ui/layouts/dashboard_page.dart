import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime anio = DateTime.now();
    return Scaffold(
        appBar: AppBar(title: const Text('Inicio')),
        drawer: const MenuLateral(),
        body: Column(
          children: [
            const Spacer(),
            const Center(
              child: Image(
                width: 250.0,
                height: 250.0,
                image: AssetImage('assets/no-image.png'),
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
                  const SizedBox(height: 4),
                  const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 50,
                    child: Image(
                      height: 100,    
                      width: 100,
                      image: AssetImage('assets/no-image.jpg'),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "USUARIO LOGEADO XX",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                     "XXXXXXXXXXX-XXXXXXXX-@XXXX.COM",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              )),
          ListTile(
            leading: const Icon(
              Icons.rate_review_rounded,
              color: Colors.blueGrey,
            ),
            title: const Text("Por definir"),
            onTap: () async => Navigator.pushNamed(context, '/newmaster'),
          ),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app_outlined,
              color: Colors.red,
            ),
            title: const Text("Salir"),
            onTap: () async {
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
