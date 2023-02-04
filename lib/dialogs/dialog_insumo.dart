import 'package:flutter/material.dart';
import 'package:tesis_karina/provider/insumo_provider.dart';
import 'package:tesis_karina/style/custom/custom_input.dart';

Future showDialogViewInsumo(
    BuildContext context, String title, InsumoProvider insumoProvider) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //  backgroundColor: Color(0xFF8793B2),
          title: Text(title),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          content: SizedBox(
            height: 110,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                TextFormField(
                  controller: insumoProvider.txtNombre,
                  decoration: CustomInputs.boxInputDecoration(
                      hint: 'Nombre del Insumo',
                      label: 'Insumo',
                      icon: Icons.new_releases_outlined),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: insumoProvider.txtclase,
                  decoration: CustomInputs.boxInputDecoration(
                      hint: 'clase de insumo',
                      label: 'Clase',
                      icon: Icons.new_releases_outlined),
                  style: const TextStyle(color: Colors.black),
                )
              ],
            ),
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
                  insumoProvider.newObjeto();
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
