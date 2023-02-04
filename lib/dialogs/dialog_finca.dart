import 'package:flutter/material.dart';
import 'package:tesis_karina/entity/finca.dart';
import 'package:tesis_karina/provider/finca_provider.dart';
import 'package:tesis_karina/style/custom/custom_input.dart';
import 'package:tesis_karina/utils/util_view.dart';

Future showDialogViewFinca(BuildContext context, String title,
    FincaProvider provider, Finca? finca) async {
  final txtNombre =
      TextEditingController(text: finca == null ? "" : finca.nombre);
  final txtDimension =
      TextEditingController(text: finca == null ? "" : finca.dimension);
  final txtUbicacion =
      TextEditingController(text: finca == null ? "" : finca.ubicacion);
  final txtReferencia =
      TextEditingController(text: finca == null ? "" : finca.referencia);

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
                  controller: txtNombre,
                  decoration: CustomInputs.boxInputDecoration(
                      hint: 'Nombre',
                      label: 'Nombre',
                      icon: Icons.new_releases_outlined),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: txtDimension,
                  decoration: CustomInputs.boxInputDecoration(
                      hint: 'Dimension',
                      label: 'Dimension',
                      icon: Icons.new_releases_outlined),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: txtUbicacion,
                  decoration: CustomInputs.boxInputDecoration(
                      hint: 'Ubicacion',
                      label: 'Ubicacion',
                      icon: Icons.new_releases_outlined),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: txtReferencia,
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
                        nombre: txtNombre.text,
                        dimension: txtDimension.text,
                        ubicacion: txtUbicacion.text,
                        referencia: txtReferencia.text,
                        estado: 1));
                  } else {
                    finca.dimension = txtDimension.text;
                    finca.nombre = txtNombre.text;
                    finca.referencia = txtReferencia.text;
                    finca.ubicacion = txtUbicacion.text;

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
