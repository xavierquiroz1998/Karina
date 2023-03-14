// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tesis_karina/entity/finca.dart';
import 'package:tesis_karina/entity/terreno.dart';
import 'package:tesis_karina/provider/terreno_provider.dart';
import 'package:tesis_karina/style/custom/custom_input.dart';
import 'package:tesis_karina/utils/util_view.dart';

Future showDialogViewTerreno(BuildContext context, String title,
    TerrenoProvider terrenoProvider, Terreno? terreno) async {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final txtUbicacion =
      TextEditingController(text: terreno == null ? "" : terreno.ubicacion);
  final txtDimension =
      TextEditingController(text: terreno == null ? "" : terreno.dimension);
  final txtUnidad =
      TextEditingController(text: terreno == null ? "" : terreno.unidad);

  terrenoProvider.limpiar();

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
            height: 225,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: txtUbicacion,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo requerido*';
                        }
                        return null;
                      },
                      decoration: CustomInputs.boxInputDecoration(
                          hint: 'Ubicacion',
                          label: 'Ubicacion',
                          icon: Icons.new_releases_outlined),
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: txtDimension,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo requerido*';
                        }
                        return null;
                      },
                      decoration: CustomInputs.boxInputDecoration(
                          hint: 'Dimension',
                          label: 'Dimension',
                          icon: Icons.new_releases_outlined),
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: txtUnidad,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo requerido*';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'(^[0-9]*$)')),
                      ],
                      decoration: CustomInputs.boxInputDecoration(
                          hint: 'Unidad',
                          label: 'Unidad',
                          icon: Icons.new_releases_outlined),
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: DropdownButtonFormField<Finca>(
                              onChanged: (value) {
                                terrenoProvider.selectFinca = value!;
                              },
                              items: terrenoProvider.listFincas.map((item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        item.nombre,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )),
                                );
                              }).toList(),
                              decoration:
                                  CustomInputs.boxInputDecorationDialogSearch(
                                      label: 'Finca que pertenece',
                                      hint: 'Finca relacionada'),
                            ),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/dashboard/selectMapa');
                            },
                            child: const Icon(Icons.map_outlined))
                      ],
                    )
                  ],
                ),
              ),
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
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final resp = await terrenoProvider.newObjeto(Terreno(
                        idterreno: UtilView.numberRandonUid(),
                        idFinca: terrenoProvider.selectFinca.idfinca,
                        ubicacion: txtUbicacion.text,
                        dimension: txtDimension.text,
                        unidad: txtUnidad.text == "" ? "0" : txtUnidad.text,
                        observacion: "",
                        estado: true,
                        disponibilidad: 'SI',
                        longitud: '',
                        latitud: '',
                        finca: terrenoProvider.selectFinca,
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now()));

                    if (resp) {
                      Navigator.of(context).pop();
                    } else {
                      UtilView.messageDanger("Ingresar ubicacion");
                    }
                  }
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
