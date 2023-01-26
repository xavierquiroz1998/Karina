import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        textDirection: TextDirection.rtl,
        children: [
          Container(
              padding: const EdgeInsets.all(30.0),
              child: Column(children: [
                Expanded(child: Container()),
                const FaIcon(FontAwesomeIcons.bridgeLock, size: 50.0),
                const SizedBox(height: 30.0),
                TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Correo electrónico o teléfono')),
                const SizedBox(height: 20.0),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 20.0),
                InkWell(
                  child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "iniciar sesión",
                        style: TextStyle(fontSize: 14.0),
                        textAlign: TextAlign.center,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 0.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          color: Colors.black12)),
                  onTap: () {
                    Navigator.pushNamed(context, '/dashboard');
                  },
                ),
                Expanded(child: Container()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(width: 12.0),
                    Text("Se te olvidó tu contraseña?",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 12.0),
                    FaIcon(Icons.arrow_circle_right_outlined, size: 20.0),
                  ],
                ),
                const SizedBox(height: 20.0),
              ]))
        ],
      )),
    );
  }
}
