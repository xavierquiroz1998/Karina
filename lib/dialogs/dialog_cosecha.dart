// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:tesis_karina/style/custom/custom_input.dart';
import 'package:tesis_karina/style/custom/custom_labels.dart';

Future<bool> dialogCosechaKg(BuildContext context) async {
  bool op = false;
  TextEditingController _controller = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
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
                  "Ingresa Cantidad de kg Cosechados",
                  style: CustomLabels.h2,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15, bottom: 10),
                  width: double.infinity,
                  child: TextFormField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      validator: (value) {},
                      style: const TextStyle(color: Colors.black),
                      decoration: CustomInputs.boxInputDecoration2(
                          hint: 'Cantidad', icon: Icons.assignment_add)),
                ),
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
        );
      });
  return op;
}
