import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:tesis_karina/entity/maquinaria.dart';
import 'package:tesis_karina/provider/maquinaria_provider.dart';
import 'package:tesis_karina/style/custom/custom_input.dart';
import 'package:tesis_karina/utils/date_formatter.dart';
import 'package:tesis_karina/utils/util_view.dart';

Future showDialogViewMaquinaria(BuildContext context, String title,
    MaquinariaProvider maquinariaProvider, Maquinaria? maquinaria) async {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final txtNonbre =
      TextEditingController(text: maquinaria == null ? "" : maquinaria.nombre);
  final txtIdentificacion = TextEditingController(
      text: maquinaria == null ? "" : maquinaria.identificacion);
  final txtProcedencia = TextEditingController(
      text: maquinaria == null ? "" : maquinaria.procedencia);
  final txtCapacidad = TextEditingController(
      text: maquinaria == null ? "" : "${maquinaria.capacidad}");
  final txtCompra = TextEditingController(
      text: maquinaria == null
          ? DateFormat("dd/MM/yyyy").format(DateTime.now())
          : UtilView.convertDateToString(maquinaria.fechacompra));

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
          txtCompra.text = UtilView.dateFormatDMY(picked.toString());
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
            height: 220,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: txtNonbre,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo requerido*';
                        }
                        return null;
                      },
                      decoration: CustomInputs.boxInputDecoration(
                          hint: 'Nombre',
                          label: 'Nombre',
                          icon: Icons.new_releases_outlined),
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: txtIdentificacion,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo requerido*';
                        }
                        return null;
                      },
                      decoration: CustomInputs.boxInputDecoration(
                          hint: 'Identificación',
                          label: 'Identificación',
                          icon: Icons.new_releases_outlined),
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: txtProcedencia,
                      decoration: CustomInputs.boxInputDecoration(
                          hint: 'Procedencia',
                          label: 'Procedencia',
                          icon: Icons.new_releases_outlined),
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: txtCapacidad,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Campo requerido*';
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'(^[0-9]*$)')),
                            ],
                            decoration: CustomInputs.boxInputDecoration(
                                hint: '0',
                                label: 'Capacidad',
                                icon: Icons.new_releases_outlined),
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: SizedBox(
                              height: 48,
                              child: TextFormField(
                                controller: txtCompra,
                                decoration:
                                    CustomInputs.boxInputDecorationDatePicker(
                                        labelText: 'Fecha Compra',
                                        fc: () => selectDate(context, 'init')),
                                inputFormatters: [DateFormatter()],
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 40,
                      child: DropdownButtonFormField<String>(
                        value: maquinariaProvider.isSelect,
                        onChanged: (value) {
                          maquinariaProvider.isSelect = value!;
                        },
                        dropdownColor: Colors.blueGrey,
                        items: maquinariaProvider.tipoMaquinaria.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  item,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                )),
                          );
                        }).toList(),
                        decoration: CustomInputs.boxInputDecorationDialogSearch(
                            label: 'Tipo de maquinaria',
                            hint: 'Tipo de maquinaria'),
                      ),
                    ),
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
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (maquinaria == null) {
                      maquinariaProvider.newObjeto(Maquinaria(
                          idmaquinarias: UtilView.numberRandonUid(),
                          nombre: txtNonbre.text,
                          fechacompra:
                              UtilView.convertStringToDate(txtCompra.text),
                          procedencia: txtProcedencia.text,
                          maquinariaTipoId:
                              maquinariaProvider.isSelect.split("/")[0].trim(),
                          identificacion: txtIdentificacion.text,
                          capacidad: int.tryParse(txtCapacidad.text) ?? 0,
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                          estado: 1));
                    } else {
                      maquinaria.nombre = txtNonbre.text;
                      maquinaria.identificacion = txtIdentificacion.text;
                      maquinaria.procedencia = txtProcedencia.text;
                      maquinaria.fechacompra =
                          UtilView.convertStringToDate(txtCompra.text);
                      maquinaria.maquinariaTipoId =
                          maquinariaProvider.isSelect.split("/")[0].trim();
                      maquinaria.capacidad =
                          int.tryParse(txtCapacidad.text) ?? 0;
                      maquinariaProvider.updateObjeto(maquinaria);
                    }
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
