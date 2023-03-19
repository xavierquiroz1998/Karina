// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tesis_karina/entity/finca.dart';
import 'package:tesis_karina/provider/planificacion_provider.dart';
import 'package:tesis_karina/style/buttons/custom_form_button.dart';
import 'package:tesis_karina/style/colors/custom_colors.dart';
import 'package:tesis_karina/style/custom/custom_input.dart';
import 'package:tesis_karina/style/custom/custom_labels.dart';
import 'package:tesis_karina/utils/util_view.dart';
import 'package:tesis_karina/widgets/input_form.dart';
import 'package:tesis_karina/widgets/white_card.dart';

class PlanificacionPage extends StatefulWidget {
  const PlanificacionPage({Key? key}) : super(key: key);

  @override
  State<PlanificacionPage> createState() => _PlanificacionPageState();
}

class _PlanificacionPageState extends State<PlanificacionPage> {
  @override
  void initState() {
    Provider.of<PlanificacionProvider>(context, listen: false).inializacion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provPlanificacion = Provider.of<PlanificacionProvider>(context);

    void selectDate(String cadena) async {
      DateTime fecha = UtilView.convertStringToDate(cadena == 'init'
          ? provPlanificacion.dateController.text
          : provPlanificacion.dateFinController.text);
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: fecha,
          firstDate: DateTime(2015),
          lastDate: DateTime(2025),
          initialEntryMode: DatePickerEntryMode.input,
          //initialDatePickerMode: DatePickerMode.year,
          helpText: "Seleccionar Fecha",
          errorInvalidText: "Rango fecha [2015-2025]");
      if (fecha.isAfter(picked!)) {
        setState(() {
          switch (cadena) {
            case 'init':
              provPlanificacion.dateController.text =
                  UtilView.dateFormatDMY(picked.toString());
              break;
            case 'finish':
              provPlanificacion.dateFinController.text =
                  UtilView.dateFormatDMY(picked.toString());
              break;
            default:
          }
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Generar Ordenes de Trabajo'),
        backgroundColor: CustomColors.customDefaut,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: CustomColors.customFondo,
        child: SingleChildScrollView(
          child: WhiteCard(
            title: "Ingreso de ordenes",
            // ignore: sort_child_properties_last
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text("Identificación", style: CustomLabels.h11)),
                    Expanded(
                        child: InputForm(
                      controller: provPlanificacion.nombreController,
                      hint: "Ingresa identificación",
                      icon: Icons.assignment,
                      length: 200,
                      textInputType: TextInputType.text,
                    )),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text("Finca", style: CustomLabels.h11)),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.3),
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<Finca>(
                            isExpanded: true,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            hint: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                provPlanificacion.fincasSelect == null
                                    ? ""
                                    : provPlanificacion.fincasSelect!.nombre,
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            onChanged: (Finca? value) async {
                              provPlanificacion.fincasSelect = value;
                              provPlanificacion.getListTerrenos();
                              provPlanificacion.listTerrenos = provPlanificacion
                                  .listTerrenosTemp
                                  .where((e) => e.idFinca == value!.idfinca)
                                  .toList();
                            },
                            items: provPlanificacion.listFincas
                                .map<DropdownMenuItem<Finca>>((Finca value) {
                              return DropdownMenuItem<Finca>(
                                value: value,
                                child: Text(value.nombre),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text("Comienzo", style: CustomLabels.h11)),
                    Expanded(
                      child: TextField(
                          controller: provPlanificacion
                              .dateController, //editing controller of this TextField
                          decoration: CustomInputs.boxInputDecoration3(
                              label: "Fecha de inicio de planificación",
                              icon: Icons.calendar_today),
                          readOnly: true, // when true user cannot edit text
                          onTap: () async {
                            //when click we have to show the datepicker
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(), //get today's date
                                firstDate: DateTime(
                                    2020), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101));
                            if (pickedDate != null) {
                              String formattedDate = DateFormat('yyyy-MM-dd')
                                  .format(
                                      pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed

                              setState(() {
                                provPlanificacion.dateController.text =
                                    formattedDate; //set foratted date to TextField value.
                              });
                            }
                          }),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text("Culminación", style: CustomLabels.h11)),
                    Expanded(
                      child: TextField(
                          controller: provPlanificacion
                              .dateFinController, //editing controller of this TextField
                          decoration: CustomInputs.boxInputDecoration3(
                              label: "Fecha de fin de planificacion",
                              icon: Icons.calendar_today),
                          readOnly: true, // when true user cannot edit text
                          onTap: () async {
                            //when click we have to show the datepicker
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(), //get today's date
                                firstDate: DateTime(
                                    2020), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101));
                            if (pickedDate != null) {
                              String formattedDate = DateFormat('yyyy-MM-dd')
                                  .format(
                                      pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed

                              setState(() {
                                provPlanificacion.dateFinController.text =
                                    formattedDate; //set foratted date to TextField value.
                              });
                            }
                          }),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text("Humedad", style: CustomLabels.h11)),
                    Expanded(
                        child: InputForm(
                      controller: provPlanificacion.humedadFinController,
                      hint: "Ingresa cantidad de humedad",
                      icon: Icons.waves_sharp,
                      length: 6,
                      textInputType: TextInputType.number,
                    )),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text("Temperatura", style: CustomLabels.h11)),
                    Expanded(
                        child: InputForm(
                      controller: provPlanificacion.temperaturaFinController,
                      hint: "Ingresas temperatura",
                      icon: Icons.crisis_alert_outlined,
                      length: 6,
                      textInputType: TextInputType.number,
                    )),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text("Observación", style: CustomLabels.h11)),
                    Expanded(
                        child: InputForm(
                      controller: provPlanificacion.observacionFinController,
                      hint: "Ingrese observación",
                      icon: Icons.assignment,
                      maxLines: 3,
                      length: 200,
                      textInputType: TextInputType.text,
                    )),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomFormButton(
                        color: Colors.green,
                        onPressed: () async {
                          final resp = await provPlanificacion.grabar();

                          if (resp) {
                            UtilView.messageSnackNewAccess(
                                "Orden de trabajo generada\ncon exito",
                                context);
                          } else {
                            UtilView.messageSnackNewError("Error", context);
                          }
                        },
                        text: "Guardar"),
                    const SizedBox(width: 10),
                    CustomFormButton(
                        color: Colors.red,
                        onPressed: () async {
                          provPlanificacion.limpiar();
                        },
                        text: "Cancelar"),
                  ],
                ),
              ],
            ),
            acciones: InkWell(
              onTap: () async {},
              child: const Text(
                "+",
                style: TextStyle(fontSize: 12, color: Colors.red),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
