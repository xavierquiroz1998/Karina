// ignore_for_file: use_build_context_synchronously

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tesis_karina/dialogs/dialog_update.dart';
import 'package:tesis_karina/entity/detalle_planificacion.dart';
import 'package:tesis_karina/entity/insumo.dart';
import 'package:tesis_karina/entity/maquinaria.dart';
import 'package:tesis_karina/entity/personas.dart';
import 'package:tesis_karina/entity/planificacion.dart';
import 'package:tesis_karina/entity/terreno.dart';
import 'package:tesis_karina/entity/tipos_graminea.dart';
import 'package:tesis_karina/provider/planificacion_provider.dart';
import 'package:tesis_karina/style/buttons/custom_form_button.dart';
import 'package:tesis_karina/style/colors/custom_colors.dart';
import 'package:tesis_karina/style/custom/custom_input.dart';
import 'package:tesis_karina/style/custom/custom_labels.dart';
import 'package:tesis_karina/utils/util_view.dart';
import 'package:tesis_karina/widgets/input_form.dart';
import 'package:tesis_karina/widgets/white_card.dart';

class PlanificacionDetailPage extends StatefulWidget {
  const PlanificacionDetailPage({Key? key}) : super(key: key);

  @override
  State<PlanificacionDetailPage> createState() =>
      _PlanificacionDetailPageState();
}

class _PlanificacionDetailPageState extends State<PlanificacionDetailPage> {
  @override
  void initState() {
    Provider.of<PlanificacionProvider>(context, listen: false).getIntDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provPlanificacion = Provider.of<PlanificacionProvider>(context);

    void selectDate(String cadena) async {
      DateTime fecha = UtilView.convertStringToDate(cadena == 'init'
          ? provPlanificacion.txtDetailInicio.text
          : provPlanificacion.txtDetailFin.text);
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
              provPlanificacion.txtDetailInicio.text =
                  UtilView.dateFormatDMY(picked.toString());
              break;
            case 'finish':
              provPlanificacion.txtDetailFin.text =
                  UtilView.dateFormatDMY(picked.toString());
              break;
            default:
          }
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de ordenes'),
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
                      controller: provPlanificacion.actvDetailController,
                      hint: "Ingresa identificacion",
                      icon: Icons.assignment,
                      length: 13,
                      textInputType: TextInputType.text,
                    )),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                        width: 100,
                        child:
                            Text("Ordenes/Trabajo", style: CustomLabels.h11)),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.3),
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<Planificacion>(
                            isExpanded: true,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            hint: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                provPlanificacion.planificacionSelect == null
                                    ? ""
                                    : provPlanificacion
                                        .planificacionSelect!.nombre,
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            onChanged: (Planificacion? value) async {
                              setState(() {
                                provPlanificacion.planificacionSelect = value;
                              });
                            },
                            items: provPlanificacion.listPlanificacion
                                .map<DropdownMenuItem<Planificacion>>(
                                    (Planificacion value) {
                              return DropdownMenuItem<Planificacion>(
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
                              .txtDetailInicio, //editing controller of this TextField
                          decoration: CustomInputs.boxInputDecoration3(
                              label: "Fecha de inicio de la Actividad",
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
                                provPlanificacion.txtDetailInicio.text =
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
                              .txtDetailFin, //editing controller of this TextField
                          decoration: CustomInputs.boxInputDecoration3(
                              label: "Fecha de fin de la Actividad",
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
                                provPlanificacion.txtDetailFin.text =
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
                        child: Text("Terreno", style: CustomLabels.h11)),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.3),
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<Terreno>(
                            isExpanded: true,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            hint: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                provPlanificacion.terrenoSelect == null
                                    ? ""
                                    : provPlanificacion
                                        .terrenoSelect!.ubicacion,
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            onChanged: (Terreno? value) async {
                              setState(() {
                                provPlanificacion.terrenoSelect = value;
                              });
                            },
                            items: provPlanificacion.listTerrenos
                                .map<DropdownMenuItem<Terreno>>(
                                    (Terreno value) {
                              return DropdownMenuItem<Terreno>(
                                value: value,
                                child: Text(value.ubicacion),
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
                        child: Text("Semilla", style: CustomLabels.h11)),
                    Expanded(
                      child: DropdownSearch<TiposGraminea>.multiSelection(
                        items: provPlanificacion.listGraminea,
                        compareFn: (i, s) => i.isEqual(s),
                        onChanged: (value) {
                          provPlanificacion.listGramineaSelect = value;
                        },
                        popupProps: PopupPropsMultiSelection.modalBottomSheet(
                          showSearchBox: true,
                          itemBuilder: _customPopupItemBuilderGraminea,
                          favoriteItemProps: FavoriteItemProps(
                            showFavoriteItems: true,
                            favoriteItems: (us) {
                              return us
                                  .where((e) => e.observacion.contains("Mrs"))
                                  .toList();
                            },
                            favoriteItemBuilder: (context, item, isSelected) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                child: Row(
                                  children: [
                                    Text(
                                      item.observacion,
                                      textAlign: TextAlign.center,
                                      style:
                                          const TextStyle(color: Colors.indigo),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(left: 8)),
                                    isSelected
                                        ? const Icon(Icons.check_box_outlined)
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                              );
                            },
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
                        child:
                            Text("Lista de Insumos", style: CustomLabels.h11)),
                    Expanded(
                      child: DropdownSearch<Insumos>.multiSelection(
                        items: provPlanificacion.listInsumo,
                        compareFn: (i, s) => i.isEqual(s),
                        onChanged: (value) async {
                          provPlanificacion.listInsumoSelect = value;
                          for (var element
                              in provPlanificacion.listInsumoSelect) {
                            await dialogUpdate(context, element);
                          }
                        },
                        popupProps: PopupPropsMultiSelection.modalBottomSheet(
                          showSearchBox: true,
                          itemBuilder: _customPopupItemBuilderInsumos,
                          favoriteItemProps: FavoriteItemProps(
                            showFavoriteItems: true,
                            favoriteItems: (us) {
                              return us
                                  .where((e) => e.nombre.contains("Mrs"))
                                  .toList();
                            },
                            favoriteItemBuilder: (context, item, isSelected) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                child: Row(
                                  children: [
                                    Text(
                                      item.nombre,
                                      textAlign: TextAlign.center,
                                      style:
                                          const TextStyle(color: Colors.indigo),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(left: 8)),
                                    isSelected
                                        ? const Icon(Icons.check_box_outlined)
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                              );
                            },
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
                        child: Text("Personal", style: CustomLabels.h11)),
                    Expanded(
                      child: DropdownSearch<Persona>.multiSelection(
                        items: provPlanificacion.listPersonas,
                        compareFn: (i, s) => i.isEqual(s),
                        onChanged: (value) {
                          provPlanificacion.listPersonasSelect = value;
                        },
                        popupProps: PopupPropsMultiSelection.modalBottomSheet(
                          showSearchBox: true,
                          itemBuilder: _customPopupItemBuilderPersona,
                          favoriteItemProps: FavoriteItemProps(
                            showFavoriteItems: true,
                            favoriteItems: (us) {
                              return us
                                  .where((e) => e.nombre.contains("Mrs"))
                                  .toList();
                            },
                            favoriteItemBuilder: (context, item, isSelected) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                child: Row(
                                  children: [
                                    Text(
                                      item.nombre,
                                      textAlign: TextAlign.center,
                                      style:
                                          const TextStyle(color: Colors.indigo),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(left: 8)),
                                    isSelected
                                        ? const Icon(Icons.check_box_outlined)
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                              );
                            },
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
                        child: Text("Observación", style: CustomLabels.h11)),
                    Expanded(
                        child: InputForm(
                      controller: provPlanificacion.obsDetailController,
                      hint: "Ingrese observación",
                      icon: Icons.assignment,
                      maxLines: 3,
                      length: 200,
                      textInputType: TextInputType.text,
                    )),
                  ],
                ),
                const Divider(thickness: 1),

                /*  
                
                  const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 5),
                  child: Text("Lista de Actividades",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                   const SizedBox(height: 10),
                SfDataGridTheme(
                  data: SfDataGridThemeData(
                      headerColor: CustomColors.customDefaut),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 500,
                    child: SfDataGrid(
                        headerRowHeight: 35.0,
                        rowHeight: 35.0,
                        columns: <GridColumn>[
                          GridColumn(
                            columnWidthMode: ColumnWidthMode.fill,
                            columnName: 'actividad',
                            label: Center(
                              child: Text('ACTIVIDAD',
                                  style: CustomLabels.h4
                                      .copyWith(color: Colors.white)),
                            ),
                          ),
                          GridColumn(
                            columnWidthMode: ColumnWidthMode.fill,
                            columnName: 'fechaI',
                            label: Center(
                              child: Text('INICIO',
                                  style: CustomLabels.h4
                                      .copyWith(color: Colors.white)),
                            ),
                          ),
                          GridColumn(
                            columnWidthMode: ColumnWidthMode.fill,
                            columnName: 'fechaF',
                            label: Center(
                              child: Text('FIN',
                                  style: CustomLabels.h4
                                      .copyWith(color: Colors.white)),
                            ),
                          ),
                          GridColumn(
                            width: 30,
                            columnName: 'accione',
                            label: Center(
                              child: Text('E',
                                  style: CustomLabels.h4
                                      .copyWith(color: Colors.white)),
                            ),
                          ),
                        ],
                        source: DetailPlanDataSource(
                            provider: provPlanificacion, cxt: context)),
                  ),
                ),
             */
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomFormButton(
                        color: Colors.green,
                        onPressed: () async {
                          final resp = await provPlanificacion
                              .graba2(Detalleplanificacion(
                            iddetalleplanificacion: UtilView.numberRandonUid(),
                            actividad:
                                provPlanificacion.actvDetailController.text,
                            inicio: UtilView.dateFormatNew(
                                provPlanificacion.txtDetailInicio.text),
                            fin: UtilView.dateFormatNew(
                                provPlanificacion.txtDetailFin.text),
                            tipo: "S",
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                            idPlanificacion: provPlanificacion
                                .planificacionSelect!.idplanificacion,
                            idTerreno:
                                provPlanificacion.terrenoSelect!.idterreno,
                            etapa: 1,
                            nivel: 0,
                            idtipograminea: "",
                            observacion: "",
                            observacion2: "-",
                            estado: true,
                          ));

                          if (resp) {
                            UtilView.messageSnackNewAccess(
                                "Se realizo con exito", context);
                          } else {
                            UtilView.messageSnackNewError("Error", context);
                          }
                        },
                        text: "Guardar"),
                    const SizedBox(width: 10),
                    CustomFormButton(
                        color: Colors.red,
                        onPressed: () async {
                          provPlanificacion.limpiar2();
                        },
                        text: "Cancelar"),
                  ],
                ),
              ],
            ),
            acciones: InkWell(
              onTap: () async {
                final resp =
                    await provPlanificacion.graba2(Detalleplanificacion(
                  iddetalleplanificacion: UtilView.numberRandonUid(),
                  actividad: provPlanificacion.actvDetailController.text,
                  inicio: UtilView.dateFormatNew(
                      provPlanificacion.txtDetailInicio.text),
                  fin: UtilView.dateFormatNew(
                      provPlanificacion.txtDetailFin.text),
                  tipo: "S",
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                  idPlanificacion:
                      provPlanificacion.planificacionSelect!.idplanificacion,
                  idTerreno: provPlanificacion.terrenoSelect!.idterreno,
                  etapa: 1,
                  nivel: 0,
                  idtipograminea: "",
                  observacion: "",
                  observacion2: "-",
                  estado: true,
                ));

                if (resp) {
                  UtilView.messageSnackNewAccess(
                      "Se realizo con exito", context);
                } else {
                  UtilView.messageSnackNewError("Error", context);
                }
              },
              child: const Text(
                "Guardar detalle",
                style: TextStyle(fontSize: 12, color: Colors.red),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _customPopupItemBuilderExample2(
    BuildContext context,
    Terreno? item,
    bool isSelected,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item?.ubicacion ?? ''),
      ),
    );
  }

  Widget _customPopupItemBuilderPersona(
    BuildContext context,
    Persona? item,
    bool isSelected,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item?.nombre ?? ''),
      ),
    );
  }

  Widget _customPopupItemBuilderMaquinarias(
    BuildContext context,
    Maquinaria? item,
    bool isSelected,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item?.nombre ?? ''),
      ),
    );
  }

  Widget _customPopupItemBuilderInsumos(
    BuildContext context,
    Insumos? item,
    bool isSelected,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item?.nombre ?? ''),
      ),
    );
  }

  Widget _customPopupItemBuilderGraminea(
    BuildContext context,
    TiposGraminea? item,
    bool isSelected,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item?.observacion ?? ''),
      ),
    );
  }
}
