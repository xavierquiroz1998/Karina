// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:tesis_karina/style/custom/custom_input.dart';
import 'package:tesis_karina/style/custom/custom_labels.dart';

Future<String> dialogComentario(BuildContext context) async {
  TextEditingController _controller = TextEditingController();

  await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Flexible(
                  child: Padding(
                padding: EdgeInsets.all(9),
                child: Text("Agregar Comentario",
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              )),
              Container(
                  margin: const EdgeInsets.only(top: 15, bottom: 10),
                  width: double.infinity,
                  child: TextFormField(
                      controller: _controller,
                      keyboardType: TextInputType.text,
                      maxLines: 3,
                      style: const TextStyle(color: Colors.black),
                      decoration: CustomInputs.boxInputDecoration2(
                          hint: "Comentario", icon: Icons.assignment))),
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
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.check_circle, color: Colors.green),
                    label: Text(
                      'Finalizar',
                      style: CustomLabels.h3.copyWith(color: Colors.green),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      });
  return _controller.text;
}
