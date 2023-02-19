import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tesis_karina/entity/insumo.dart';
import 'package:tesis_karina/provider/insumo_provider.dart';
import 'package:tesis_karina/style/custom/custom_input.dart';
import 'package:tesis_karina/utils/date_formatter.dart';
import 'package:tesis_karina/utils/util_view.dart';

Future showDialogViewInsumo(BuildContext context, String title,
    InsumoProvider insumoProvider, Insumos? insumo) async {
  final txtNombre =
      TextEditingController(text: insumo == null ? "" : insumo.nombre);
  final txtUnidades =
      TextEditingController(text: insumo == null ? "" : insumo.unidades);

  final txtCritFI = TextEditingController(
      text: insumo == null
          ? DateFormat("dd/MM/yyyy").format(DateTime.now())
          : UtilView.convertDateToString(insumo.fechaCaducidad));

  void selectDate(BuildContext context, String cadena) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      switch (cadena) {
        case 'init':
          txtCritFI.text = UtilView.dateFormatDMY(picked.toString());
          break;
        default:
      }
    }
  }

  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //  backgroundColor: Color(0xFF8793B2),
          title: Text(title),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          content: SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                TextFormField(
                  controller: txtNombre,
                  decoration: CustomInputs.boxInputDecoration(
                      hint: 'Nombre del Insumo',
                      label: 'Insumo',
                      icon: Icons.new_releases_outlined),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  child: DropdownButtonFormField<String>(
                    value: insumoProvider.isTpInsumo,
                    onChanged: (value) {
                      insumoProvider.isTpInsumo = value!;
                    },
                    dropdownColor: Colors.blueGrey,
                    items: insumoProvider.tipoInsumo.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              item,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            )),
                      );
                    }).toList(),
                    decoration: CustomInputs.boxInputDecorationDialogSearch(
                        label: 'Tipo de plagas', hint: 'Tipo de plagas'),
                  ),
                ),
                SizedBox(
                    height: 40,
                    child: TextFormField(
                      controller: txtCritFI,
                      decoration: CustomInputs.boxInputDecorationDatePicker(
                          labelText: 'Fecha de caducidad',
                          fc: () => selectDate(context, 'init')),
                      inputFormatters: [DateFormatter()],
                      onChanged: (value) {},
                    )),
                const SizedBox(height: 10),
                TextFormField(
                  controller: txtUnidades,
                  keyboardType: TextInputType.number,
                  decoration: CustomInputs.boxInputDecoration(
                      hint: 'Unidades',
                      label: 'Unidad',
                      icon: Icons.new_releases_outlined),
                  style: const TextStyle(color: Colors.black),
                ),
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
                  if (insumo == null) {
                    insumoProvider.newObjeto(Insumos(
                      idinsumos: UtilView.numberRandonUid(),
                      nombre: txtNombre.text,
                      insumoTipoId:
                          insumoProvider.isTpInsumo.split("/")[0].trim(),
                      unidades: "",
                      fechaCaducidad:
                          UtilView.convertStringToDate(txtCritFI.text),
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                      observacion: "--",
                      estado: 1,
                    ));
                  } else {
                    insumo.nombre = txtNombre.text;
                    insumo.insumoTipoId =
                        insumoProvider.isTpInsumo.split("/")[0].trim();
                    insumo.fechaCaducidad =
                        UtilView.convertStringToDate(txtCritFI.text);
                    insumoProvider.updateObjeto(insumo);
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
