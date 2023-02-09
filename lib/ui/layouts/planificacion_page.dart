import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tesis_karina/entity/finca.dart';
import 'package:tesis_karina/entity/insumo.dart';
import 'package:tesis_karina/entity/personas.dart';
import 'package:tesis_karina/entity/terreno.dart';
import 'package:tesis_karina/provider/planificacion_provider.dart';
import 'package:tesis_karina/style/custom/custom_labels.dart';
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

    return Scaffold(
      appBar: AppBar(title: const Text('Crear Planificacion')),
      body: SingleChildScrollView(
        child: WhiteCard(
            // ignore: sort_child_properties_last
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text("Finca", style: CustomLabels.h11)),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Align(
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              'Select Items',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          ),
                          items: provPlanificacion.listFincas.map((item) {
                            return DropdownMenuItem<Finca>(
                              value: item,
                              //disable default onTap to avoid closing menu when selecting an item
                              enabled: false,
                              child: StatefulBuilder(
                                builder: (context, menuSetState) {
                                  final _isSelected = provPlanificacion
                                      .listFincasSelect
                                      .contains(item);
                                  return InkWell(
                                    onTap: () {
                                      _isSelected
                                          ? provPlanificacion.listFincasSelect
                                              .remove(item)
                                          : provPlanificacion.listFincasSelect
                                              .add(item);
                                      //This rebuilds the StatefulWidget to update the button's text
                                      setState(() {});
                                      //This rebuilds the dropdownMenu Widget to update the check mark
                                      menuSetState(() {});
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Row(
                                        children: [
                                          _isSelected
                                              ? const Icon(
                                                  Icons.check_box_outlined)
                                              : const Icon(Icons
                                                  .check_box_outline_blank),
                                          const SizedBox(width: 16),
                                          Text(
                                            item.nombre,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }).toList(),
                          //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                          value: provPlanificacion.listFincasSelect.isEmpty
                              ? null
                              : provPlanificacion.listFincasSelect.last,
                          onChanged: (value) {},
                          buttonHeight: 40,
                          buttonWidth: 140,
                          itemHeight: 40,
                          itemPadding: EdgeInsets.zero,
                          selectedItemBuilder: (context) {
                            return provPlanificacion.listFincas.map(
                              (item) {
                                return Container(
                                  alignment: AlignmentDirectional.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Text(
                                    provPlanificacion.listFincasSelect
                                        .join(', '),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                );
                              },
                            ).toList();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text("Terreno", style: CustomLabels.h11)),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Align(
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              'Select Items',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          ),
                          items: provPlanificacion.listTerrenos.map((item) {
                            return DropdownMenuItem<Terreno>(
                              value: item,
                              //disable default onTap to avoid closing menu when selecting an item
                              enabled: false,
                              child: StatefulBuilder(
                                builder: (context, menuSetState) {
                                  final _isSelected = provPlanificacion
                                      .listTerrenosSelect
                                      .contains(item);
                                  return InkWell(
                                    onTap: () {
                                      _isSelected
                                          ? provPlanificacion.listTerrenosSelect
                                              .remove(item)
                                          : provPlanificacion.listTerrenosSelect
                                              .add(item);
                                      //This rebuilds the StatefulWidget to update the button's text
                                      setState(() {});
                                      //This rebuilds the dropdownMenu Widget to update the check mark
                                      menuSetState(() {});
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Row(
                                        children: [
                                          _isSelected
                                              ? const Icon(
                                                  Icons.check_box_outlined)
                                              : const Icon(Icons
                                                  .check_box_outline_blank),
                                          const SizedBox(width: 16),
                                          Text(
                                            item.ubicacion,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }).toList(),
                          //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                          value: provPlanificacion.listTerrenosSelect.isEmpty
                              ? null
                              : provPlanificacion.listTerrenosSelect.last,
                          onChanged: (value) {},
                          buttonHeight: 40,
                          buttonWidth: 140,
                          itemHeight: 40,
                          itemPadding: EdgeInsets.zero,
                          selectedItemBuilder: (context) {
                            return provPlanificacion.listTerrenos.map(
                              (item) {
                                return Container(
                                  alignment: AlignmentDirectional.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Text(
                                    provPlanificacion.listTerrenosSelect
                                        .join(', '),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                );
                              },
                            ).toList();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text("Personal", style: CustomLabels.h11)),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Align(
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              'Select Items',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          ),
                          items: provPlanificacion.listPersonas.map((item) {
                            return DropdownMenuItem<Persona>(
                              value: item,
                              //disable default onTap to avoid closing menu when selecting an item
                              enabled: false,
                              child: StatefulBuilder(
                                builder: (context, menuSetState) {
                                  final _isSelected = provPlanificacion
                                      .listPersonasSelect
                                      .contains(item);
                                  return InkWell(
                                    onTap: () {
                                      _isSelected
                                          ? provPlanificacion.listPersonasSelect
                                              .remove(item)
                                          : provPlanificacion.listPersonasSelect
                                              .add(item);
                                      //This rebuilds the StatefulWidget to update the button's text
                                      setState(() {});
                                      //This rebuilds the dropdownMenu Widget to update the check mark
                                      menuSetState(() {});
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Row(
                                        children: [
                                          _isSelected
                                              ? const Icon(
                                                  Icons.check_box_outlined)
                                              : const Icon(Icons
                                                  .check_box_outline_blank),
                                          const SizedBox(width: 16),
                                          Text(
                                            item.nombre,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }).toList(),
                          //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                          value: provPlanificacion.listPersonasSelect.isEmpty
                              ? null
                              : provPlanificacion.listPersonasSelect.last,
                          onChanged: (value) {},
                          buttonHeight: 40,
                          buttonWidth: 140,
                          itemHeight: 40,
                          itemPadding: EdgeInsets.zero,
                          selectedItemBuilder: (context) {
                            return provPlanificacion.listPersonas.map(
                              (item) {
                                return Container(
                                  alignment: AlignmentDirectional.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Text(
                                    provPlanificacion.listPersonasSelect
                                        .join(', '),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                );
                              },
                            ).toList();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text("Insumos", style: CustomLabels.h11)),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Align(
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              'Select Items',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          ),
                          items: provPlanificacion.listInsumo.map((item) {
                            return DropdownMenuItem<Insumo>(
                              value: item,
                              //disable default onTap to avoid closing menu when selecting an item
                              enabled: false,
                              child: StatefulBuilder(
                                builder: (context, menuSetState) {
                                  var _isSelected = provPlanificacion
                                      .listInsumoSelect
                                      .contains(item);
                                  return InkWell(
                                    onTap: () {
                                      _isSelected
                                          ? provPlanificacion.listInsumoSelect
                                              .remove(item)
                                          : provPlanificacion.listInsumoSelect
                                              .add(item);
                                      //This rebuilds the StatefulWidget to update the button's text
                                      setState(() {});
                                      //This rebuilds the dropdownMenu Widget to update the check mark
                                      menuSetState(() {});
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Row(
                                        children: [
                                          _isSelected
                                              ? const Icon(
                                                  Icons.check_box_outlined)
                                              : const Icon(Icons
                                                  .check_box_outline_blank),
                                          const SizedBox(width: 16),
                                          Text(
                                            item.nombre,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }).toList(),
                          //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                          value: provPlanificacion.listInsumoSelect.isEmpty
                              ? null
                              : provPlanificacion.listInsumoSelect.last,
                          onChanged: (value) {},
                          buttonHeight: 40,
                          buttonWidth: 140,
                          itemHeight: 40,
                          itemPadding: EdgeInsets.zero,
                          selectedItemBuilder: (context) {
                            return provPlanificacion.listInsumo.map(
                              (item) {
                                return Container(
                                  alignment: AlignmentDirectional.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Text(
                                    provPlanificacion.listInsumoSelect
                                        .join(', '),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                );
                              },
                            ).toList();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text("Disponible", style: CustomLabels.h11)),
                    Expanded(
                        child: InputForm(
                      controller: provPlanificacion.disponibleController,
                      hint: "",
                      icon: Icons.assignment,
                      length: 6,
                      textInputType: TextInputType.number,
                    )),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text("Humedad", style: CustomLabels.h11)),
                    Expanded(
                        child: InputForm(
                      controller: provPlanificacion.humedadFinController,
                      hint: "",
                      icon: Icons.assignment,
                      length: 6,
                      textInputType: TextInputType.number,
                    )),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text("Temperatura", style: CustomLabels.h11)),
                    Expanded(
                        child: InputForm(
                      controller: provPlanificacion.temperaturaFinController,
                      hint: "",
                      icon: Icons.assignment,
                      length: 6,
                      textInputType: TextInputType.number,
                    )),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text("Observación", style: CustomLabels.h11)),
                    Expanded(
                        child: InputForm(
                      controller: provPlanificacion.observacionFinController,
                      hint: "",
                      icon: Icons.assignment,
                      maxLines: 3,
                      length: 200,
                      textInputType: TextInputType.text,
                    )),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text("Agregar Act.", style: CustomLabels.h11)),
                    Expanded(
                      child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.assignment_add),
                          label: const Text('Actividades')),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                          controller: provPlanificacion
                              .dateController, //editing controller of this TextField
                          decoration: const InputDecoration(
                              icon: Icon(
                                  Icons.calendar_today), //icon of text field
                              labelText:
                                  "Fecha de inicio de planificacion" //label text of field
                              ),
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
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                          controller: provPlanificacion
                              .dateFinController, //editing controller of this TextField
                          decoration: const InputDecoration(
                              icon: Icon(
                                  Icons.calendar_today), //icon of text field
                              labelText:
                                  "Fecha de fin de planificacion" //label text of field
                              ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () async {
                        provPlanificacion.grabar();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Guardar", style: CustomLabels.h11),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Cancelar", style: CustomLabels.h11),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            acciones: const Icon(Icons.emoji_objects_rounded)),
      ),
    );
  }
}
