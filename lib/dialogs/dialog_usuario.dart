import 'package:flutter/material.dart';
import 'package:tesis_karina/entity/usuario.dart';
import 'package:tesis_karina/provider/usuario_provider.dart';
import 'package:tesis_karina/style/custom/custom_input.dart';
import 'package:tesis_karina/utils/util_view.dart';

Future showDialogViewUsuario(
    BuildContext context, String title, UsuarioProvider usuarioProvider) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //  backgroundColor: Color(0xFF8793B2),
          title: Text(title),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: usuarioProvider.txtNombre,
                      decoration: CustomInputs.boxInputDecoration(
                          hint: 'Nombre',
                          label: 'Nombre',
                          icon: Icons.new_releases_outlined),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: TextFormField(
                      controller: usuarioProvider.txtApellido,
                      decoration: CustomInputs.boxInputDecoration(
                          hint: 'Apellido',
                          label: 'Apellido',
                          icon: Icons.new_releases_outlined),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: usuarioProvider.txtDireccion,
                decoration: CustomInputs.boxInputDecoration(
                    hint: 'Direccion',
                    label: 'Direccion',
                    icon: Icons.new_releases_outlined),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: usuarioProvider.txtCelular,
                decoration: CustomInputs.boxInputDecoration(
                    hint: 'Celular',
                    label: 'Celular',
                    icon: Icons.new_releases_outlined),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: usuarioProvider.txtEmail,
                decoration: CustomInputs.boxInputDecoration(
                    hint: 'Correo',
                    label: 'Correo',
                    icon: Icons.new_releases_outlined),
                style: const TextStyle(color: Colors.black),
              )
            ],
          ),
          actions: [
            TextButton(
                style: ButtonStyle(backgroundColor:
                    MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) {
                    return Colors.black12;
                  }
                  return Colors.transparent;
                })),
                onPressed: () {
                  usuarioProvider.newObjeto(Usuario(
                      uid: UtilView.numberRandonUid(),
                      estado: 1,
                      rol: "1",
                      nombre: usuarioProvider.txtNombre.text,
                      correo: usuarioProvider.txtEmail.text));
                  Navigator.of(context).pop();
                },
                child: const Text('Aceptar', style: TextStyle(fontSize: 14))),
            TextButton(
                style: ButtonStyle(backgroundColor:
                    MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) {
                    return Colors.black12;
                  }
                  return Colors.transparent;
                })),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancelar', style: TextStyle(fontSize: 14))),
          ],
        );
      });
}

TextStyle buildStyle() {
  return const TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
}
