import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tesis_karina/provider/user_form_provider.dart';
import 'package:tesis_karina/provider/usuario_provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserFormProvider>(context);
    final providerUsuario = Provider.of<UsuarioProvider>(context);
    final txtEmail = TextEditingController();
    final txtPass = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
          child: Stack(
        textDirection: TextDirection.rtl,
        children: [
          Container(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: formKey,
                child: Column(children: [
                  Expanded(child: Container()),
                  const FaIcon(FontAwesomeIcons.bridgeLock, size: 50.0),
                  const SizedBox(height: 30.0),
                  TextFormField(
                      controller: txtEmail,
                      decoration: const InputDecoration(
                          labelText: 'Correo electrónico o teléfono')),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: txtPass,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Contraseña'),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: 20.0),
                  InkWell(
                    child: Container(
                        padding: const EdgeInsets.all(16.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black12, width: 0.5),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5.0)),
                            color: Colors.black12),
                        child: const Text(
                          "iniciar sesión",
                          style: TextStyle(fontSize: 14.0),
                          textAlign: TextAlign.center,
                        )),
                    onTap: () async {
                      /* if (formKey.currentState!.validate()) {
                        final user = await providerUsuario.getUsuarioLogin(
                            txtEmail.text, txtPass.text);

                        if (user != null) {
                          // ignore: use_build_context_synchronously
                          Navigator.pushNamed(context, '/dashboard');
                        }
                      } */
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
                ]),
              ))
        ],
      )),
    );
  }
}
