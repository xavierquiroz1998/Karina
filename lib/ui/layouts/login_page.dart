// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tesis_karina/provider/usuario_provider.dart';
import 'package:tesis_karina/style/custom/custom_input.dart';
import 'package:tesis_karina/utils/util_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final providerUsuario = Provider.of<UsuarioProvider>(context);
    final txtEmail = TextEditingController();
    final txtPass = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    void guardar() async {
      if (formKey.currentState!.validate()) {
        final user =
            await providerUsuario.getUsuarioLogin(txtEmail.text, txtPass.text);

        if (user != null) {
          UtilView.usuarioUtil = user;
          Navigator.pushNamed(context, '/dashboard');
        }
      }
    }

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          textDirection: TextDirection.rtl,
          children: [
            Container(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                  key: formKey,
                  child: Column(children: [
                    const SizedBox(height: 10.0),
                    Image.asset("assets/logoArroz.png"),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                              controller: txtEmail,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(myFocusNode),
                              keyboardType: TextInputType.emailAddress,
                              decoration: CustomInputs.loginInputDecoration(
                                  hint: "Correo electrónico",
                                  label: "Correo electrónico",
                                  icon: Icons.email)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            focusNode: myFocusNode,
                            controller: txtPass,
                            onEditingComplete: () => guardar(),
                            obscureText: true,
                            decoration: CustomInputs.loginInputDecoration(
                                hint: "Contraseña",
                                label: "Contraseña",
                                icon: Icons.password),
                            keyboardType: TextInputType.visiblePassword,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
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
                      onTap: () => guardar(),
                    ),
                    /*    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(width: 12.0),
                        Text("Se te olvidó tu contraseña?",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 12.0),
                        FaIcon(Icons.arrow_circle_right_outlined, size: 20.0),
                      ],
                    ), */
                  ]),
                ))
          ],
        ),
      )),
    );
  }
}
