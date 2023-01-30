import 'package:flutter/material.dart';
import 'package:tesis_karina/entity/terreno.dart';
import 'package:tesis_karina/provider/terreno_provider.dart';
import 'package:tesis_karina/style/custom/custom_input.dart';
import 'package:tesis_karina/utils/util_view.dart';

Future showDialogViewTerreno(
    BuildContext context, String title, TerrenoProvider terrenoProvider) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //  backgroundColor: Color(0xFF8793B2),
          title: Text(title),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: terrenoProvider.txtUbicacion,
                  decoration: CustomInputs.boxInputDecoration(
                      hint: 'Ubicacion',
                      label: 'Ubicacion',
                      icon: Icons.new_releases_outlined),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: terrenoProvider.txtDimension,
                  decoration: CustomInputs.boxInputDecoration(
                      hint: 'Dimension',
                      label: 'Dimension',
                      icon: Icons.new_releases_outlined),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: terrenoProvider.txtUnidad,
                  decoration: CustomInputs.boxInputDecoration(
                      hint: 'Unidad',
                      label: 'Unidad',
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
                  terrenoProvider.newObjeto(Terreno(
                      uid: UtilView.numberRandonUid(),
                      ubicacion: terrenoProvider.txtUbicacion.text,
                      dimension: terrenoProvider.txtDimension.text,
                      unidad: terrenoProvider.txtUnidad.text,
                      ingreso: "0000-00-00",
                      estado: "I"));
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
