import 'package:flutter/material.dart';
import 'package:tesis_karina/entity/finca.dart';
import 'package:tesis_karina/provider/finca_provider.dart';
import 'package:tesis_karina/style/custom/custom_input.dart';
import 'package:tesis_karina/utils/util_view.dart';

Future showDialogViewFinca(BuildContext context, String title,
    FincaProvider provider, Finca? finca) async {
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
                  controller: provider.txtNombre,
                  decoration: CustomInputs.boxInputDecoration(
                      hint: 'Nombre',
                      label: 'Nombre',
                      icon: Icons.new_releases_outlined),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: provider.txtDimension,
                  decoration: CustomInputs.boxInputDecoration(
                      hint: 'Dimension',
                      label: 'Dimension',
                      icon: Icons.new_releases_outlined),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: provider.txtUbicacion,
                  decoration: CustomInputs.boxInputDecoration(
                      hint: 'Ubicacion',
                      label: 'Ubicacion',
                      icon: Icons.new_releases_outlined),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: provider.txtReferencia,
                  decoration: CustomInputs.boxInputDecoration(
                      hint: 'Referencia',
                      label: 'Referencia',
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
                  if (finca == null) {
                    provider.newObjeto(Finca(
                        uid: UtilView.numberRandonUid(),
                        nombre: provider.txtNombre.text,
                        dimension: provider.txtDimension.text,
                        ubicacion: provider.txtUbicacion.text,
                        referencia: provider.txtReferencia.text,
                        estado: "I"));
                  } else {
                    finca.dimension = provider.txtDimension.text;
                    finca.nombre = provider.txtNombre.text;
                    finca.referencia = provider.txtReferencia.text;
                    finca.ubicacion = provider.txtUbicacion.text;
                    provider.updateObjeto(finca);
                  }
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
