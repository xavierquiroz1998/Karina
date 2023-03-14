// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:tesis_karina/entity/insumo.dart';
import 'package:tesis_karina/style/custom/custom_input.dart';
import 'package:tesis_karina/style/custom/custom_labels.dart';

Future<bool> dialogUpdate(BuildContext context, Insumos insumo) async {
  bool op = false;
  TextEditingController _controller = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String? validateCantidad(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);

    if (value.isEmpty) {
      return "Ingrese una cantidad";
    } else if (value == "0") {
      return "El numero tiene que ser mayor a cero";
    } else if (!regExp.hasMatch(value)) {
      return "El numero debe de ser 72";
    }
    return null;
  }

  await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: Form(
            key: formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Cantidad a utilizar :: ${insumo.nombre}",
                  style: CustomLabels.h2,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15, bottom: 10),
                  width: double.infinity,
                  child: TextFormField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (int.tryParse(insumo.unidades)! <
                            int.tryParse(value!)!) {
                          return "Supero la cantidad";
                        } else if (value.isEmpty) {
                          return "Campo requerido";
                        }

                        return validateCantidad(value); // Válido
                      },
                      style: const TextStyle(color: Colors.black),
                      decoration: CustomInputs.loginInputDecoration(
                          hint: "Ingresa la cantidad a utilizar",
                          label: "Ingresa la cantidad a utilizar",
                          icon: Icons.assistant_photo)),
                ),
                Text('Cantidad restante :: ${insumo.unidades}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.cancel, color: Colors.red),
                      label: Text(
                        'Cancelar',
                        style: CustomLabels.h3.copyWith(color: Colors.red),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          var opt = (int.tryParse(insumo.unidades)! -
                              int.tryParse(_controller.text)!);
                          insumo.cantidad = opt;
                          op = true;
                          Navigator.pop(context);
                        }
                      },
                      icon: const Icon(Icons.check_circle, color: Colors.green),
                      label: Text(
                        'Aceptar',
                        style: CustomLabels.h3.copyWith(color: Colors.green),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          /*   actions: [
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.outbox_rounded, color: Colors.indigo),
              label: Text(
                'Promoción',
                style: CustomLabels.h3.copyWith(color: Colors.indigo),
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.cancel, color: Colors.red),
              label: Text(
                'Cancelar',
                style: CustomLabels.h3.copyWith(color: Colors.red),
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.check_circle, color: Colors.green),
              label: Text(
                'Aceptar',
                style: CustomLabels.h3.copyWith(color: Colors.green),
              ),
            ),
          ], */
        );
      });
  return op;
}
