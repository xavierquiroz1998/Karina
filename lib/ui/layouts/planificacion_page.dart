import 'package:flutter/material.dart';
import 'package:tesis_karina/widgets/input_form.dart';
import 'package:tesis_karina/widgets/white_card.dart';

class PlanificacionPage extends StatefulWidget {
  const PlanificacionPage({Key? key}) : super(key: key);

  @override
  State<PlanificacionPage> createState() => _PlanificacionPageState();
}

class _PlanificacionPageState extends State<PlanificacionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Planificacion')),
      body: WhiteCard(
          // ignore: sort_child_properties_last
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: InputForm(
                      hint: 'Finca',
                      icon: Icons.assignment_ind_outlined,
                      controller: TextEditingController(),
                      length: 15,
                      textInputType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese su identificación';
                        } else if (value.length <= 9) {
                          return 'Formato Incorrecto';
                        } else if (value.length == 10) {
                        } else if (value.length == 13) {}

                        return null; // Válido
                      },
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: InputForm(
                      hint: 'Terreno',
                      icon: Icons.assignment_ind_outlined,
                      controller: TextEditingController(),
                      length: 15,
                      textInputType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese su identificación';
                        } else if (value.length <= 9) {
                          return 'Formato Incorrecto';
                        } else if (value.length == 10) {
                        } else if (value.length == 13) {}

                        return null; // Válido
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
          acciones: const Icon(Icons.emoji_objects_rounded)),
    );
  }
}
