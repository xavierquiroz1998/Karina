import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tesis_karina/datasource/detail_plan_datasource.dart';
import 'package:tesis_karina/entity/detalle_planificacion.dart';
import 'package:tesis_karina/entity/finca.dart';
import 'package:tesis_karina/entity/insumo.dart';
import 'package:tesis_karina/entity/maquinaria.dart';
import 'package:tesis_karina/entity/personas.dart';
import 'package:tesis_karina/entity/terreno.dart';
import 'package:tesis_karina/provider/planificacion_provider.dart';
import 'package:tesis_karina/style/colors/custom_colors.dart';
import 'package:tesis_karina/style/custom/custom_input.dart';
import 'package:tesis_karina/style/custom/custom_labels.dart';
import 'package:tesis_karina/utils/date_formatter.dart';
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
          ? provPlanificacion.txtInicio.text
          : provPlanificacion.txtFin.text);
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
              provPlanificacion.txtInicio.text =
                  UtilView.dateFormatDMY(picked.toString());
              break;
            case 'finish':
              provPlanificacion.txtFin.text =
                  UtilView.dateFormatDMY(picked.toString());
              break;
            default:
          }
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Planificacion'),
        backgroundColor: CustomColors.customDefaut,
      ),
      body: SingleChildScrollView(
        child: WhiteCard(
            // ignore: sort_child_properties_last
            child: provPlanificacion.isDetail
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              width: 100,
                              child: Text("Finca", style: CustomLabels.h11)),
                          Expanded(
                            child: DropdownButton<Finca>(
                              isExpanded: true,
                              hint: Text(provPlanificacion.fincasSelect == null
                                  ? ""
                                  : provPlanificacion.fincasSelect!.nombre),
                              onChanged: (Finca? value) async {
                                provPlanificacion.fincasSelect = value;
                                provPlanificacion.getListTerrenos();
                                provPlanificacion.listTerrenos =
                                    provPlanificacion
                                        .listTerrenosTemp
                                        .where(
                                            (e) => e.idFinca == value!.idfinca)
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
                            hint: "",
                            icon: Icons.assignment,
                            length: 6,
                            textInputType: TextInputType.number,
                          )),
                          Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text("Temp", style: CustomLabels.h11)),
                          Expanded(
                              child: InputForm(
                            controller:
                                provPlanificacion.temperaturaFinController,
                            hint: "",
                            icon: Icons.assignment,
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
                              child:
                                  Text("Observación", style: CustomLabels.h11)),
                          Expanded(
                              child: InputForm(
                            controller:
                                provPlanificacion.observacionFinController,
                            hint: "",
                            icon: Icons.assignment,
                            maxLines: 3,
                            length: 200,
                            textInputType: TextInputType.text,
                          )),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                                onPressed: () {
                                  provPlanificacion.setIsDetail = false;
                                },
                                icon: const Icon(Icons.assignment_add),
                                label: const Text('Agregar Actividades')),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                                controller: provPlanificacion
                                    .dateController, //editing controller of this TextField
                                decoration: CustomInputs.boxInputDecoration3(
                                    label: "Fecha de inicio de planificacion",
                                    icon: Icons.calendar_today),
                                readOnly:
                                    true, // when true user cannot edit text
                                onTap: () async {
                                  //when click we have to show the datepicker
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate:
                                          DateTime.now(), //get today's date
                                      firstDate: DateTime(
                                          2020), //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2101));
                                  if (pickedDate != null) {
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd').format(
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
                          Expanded(
                            child: TextField(
                                controller: provPlanificacion
                                    .dateFinController, //editing controller of this TextField
                                decoration: CustomInputs.boxInputDecoration3(
                                    label: "Fecha de fin de planificacion",
                                    icon: Icons.calendar_today),
                                readOnly:
                                    true, // when true user cannot edit text
                                onTap: () async {
                                  //when click we have to show the datepicker
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate:
                                          DateTime.now(), //get today's date
                                      firstDate: DateTime(
                                          2020), //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2101));
                                  if (pickedDate != null) {
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd').format(
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
                  )
                : Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 5),
                        child: Text("Rango fecha de la actividad",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextFormField(
                                controller: provPlanificacion.txtInicio,
                                decoration:
                                    CustomInputs.boxInputDecorationDatePicker(
                                        labelText: 'Inicio',
                                        fc: () => selectDate('init')),
                                inputFormatters: [DateFormatter()],
                                onChanged: (value) {},
                                onTap: () {
                                  provPlanificacion.txtInicio.selection =
                                      TextSelection(
                                          baseOffset: 0,
                                          extentOffset: provPlanificacion
                                              .txtInicio.text.length);
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextFormField(
                                controller: provPlanificacion.txtFin,
                                decoration:
                                    CustomInputs.boxInputDecorationDatePicker(
                                        labelText: 'Fin',
                                        fc: () => selectDate('finish')),
                                inputFormatters: [DateFormatter()],
                                onTap: () {
                                  provPlanificacion.txtFin.selection =
                                      TextSelection(
                                          baseOffset: 0,
                                          extentOffset: provPlanificacion
                                              .txtFin.text.length);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text("Actividad Aplicada a un Terreno"),
                          Switch(
                            value: provPlanificacion.isTerreno,
                            onChanged: (value) {
                              provPlanificacion.isChangeTerreno(value);
                            },
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 5),
                        child: Text("Nombre de la Actividad",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          controller: provPlanificacion.txtName,
                          decoration: CustomInputs.boxInputDecoration2(
                              hint: 'Ingresar Actividad',
                              icon: Icons.menu_open_sharp),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'(^[A-Z a-z 0-9]*$)')),
                            LengthLimitingTextInputFormatter(100),
                          ],
                          onTap: () => provPlanificacion.txtName.selection =
                              TextSelection(
                                  baseOffset: 0,
                                  extentOffset:
                                      provPlanificacion.txtName.text.length),
                        ),
                      ),
                      provPlanificacion.isTerreno
                          ? Row(
                              children: [
                                SizedBox(
                                    width: 80,
                                    child: Text("Terrenos",
                                        style: CustomLabels.h11)),
                                Expanded(
                                  child: DropdownSearch<Terreno>.multiSelection(
                                    items: provPlanificacion.listTerrenos,
                                    compareFn: (i, s) => i.isEqual(s),
                                    onChanged: (value) {
                                      provPlanificacion.listTerrenosSelect =
                                          value;
                                    },
                                    popupProps: PopupPropsMultiSelection
                                        .modalBottomSheet(
                                      showSearchBox: true,
                                      itemBuilder:
                                          _customPopupItemBuilderExample2,
                                      favoriteItemProps: FavoriteItemProps(
                                        showFavoriteItems: true,
                                        favoriteItems: (us) {
                                          return us
                                              .where((e) =>
                                                  e.ubicacion.contains("Mrs"))
                                              .toList();
                                        },
                                        favoriteItemBuilder:
                                            (context, item, isSelected) {
                                          return Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 6),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  "NUEVA",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.indigo),
                                                ),
                                                const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8)),
                                                isSelected
                                                    ? const Icon(Icons
                                                        .check_box_outlined)
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
                            )
                          : Container(),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(
                              width: 80,
                              child: Text("Insumos", style: CustomLabels.h11)),
                          Expanded(
                            child: DropdownSearch<Insumos>.multiSelection(
                              items: provPlanificacion.listInsumo,
                              compareFn: (i, s) => i.isEqual(s),
                              onChanged: (value) {
                                provPlanificacion.listInsumoSelect = value;
                              },
                              popupProps:
                                  PopupPropsMultiSelection.modalBottomSheet(
                                showSearchBox: true,
                                itemBuilder: _customPopupItemBuilderInsumos,
                                favoriteItemProps: FavoriteItemProps(
                                  showFavoriteItems: true,
                                  favoriteItems: (us) {
                                    return us
                                        .where((e) => e.nombre.contains("Mrs"))
                                        .toList();
                                  },
                                  favoriteItemBuilder:
                                      (context, item, isSelected) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 6),
                                      child: Row(
                                        children: [
                                          Text(
                                            "${item.nombre}",
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.indigo),
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8)),
                                          isSelected
                                              ? Icon(Icons.check_box_outlined)
                                              : SizedBox.shrink(),
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
                              width: 80,
                              child: Text("Personas", style: CustomLabels.h11)),
                          Expanded(
                            child: DropdownSearch<Persona>.multiSelection(
                              items: provPlanificacion.listPersonas,
                              compareFn: (i, s) => i.isEqual(s),
                              onChanged: (value) {
                                provPlanificacion.listPersonasSelect = value;
                              },
                              popupProps:
                                  PopupPropsMultiSelection.modalBottomSheet(
                                showSearchBox: true,
                                itemBuilder: _customPopupItemBuilderPersona,
                                favoriteItemProps: FavoriteItemProps(
                                  showFavoriteItems: true,
                                  favoriteItems: (us) {
                                    return us
                                        .where((e) => e.nombre.contains("Mrs"))
                                        .toList();
                                  },
                                  favoriteItemBuilder:
                                      (context, item, isSelected) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 6),
                                      child: Row(
                                        children: [
                                          Text(
                                            "${item.nombre}",
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.indigo),
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8)),
                                          isSelected
                                              ? Icon(Icons.check_box_outlined)
                                              : SizedBox.shrink(),
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
                              width: 80,
                              child:
                                  Text("Maquinarias", style: CustomLabels.h11)),
                          Expanded(
                            child: DropdownSearch<Maquinaria>.multiSelection(
                              items: provPlanificacion.listMaquinarias,
                              compareFn: (i, s) => i.isEqual(s),
                              onChanged: (value) {
                                provPlanificacion.listMaquinariasSelect = value;
                              },
                              popupProps:
                                  PopupPropsMultiSelection.modalBottomSheet(
                                showSearchBox: true,
                                itemBuilder: _customPopupItemBuilderMaquinarias,
                                favoriteItemProps: FavoriteItemProps(
                                  showFavoriteItems: true,
                                  favoriteItems: (us) {
                                    return us
                                        .where((e) => e.nombre.contains("Mrs"))
                                        .toList();
                                  },
                                  favoriteItemBuilder:
                                      (context, item, isSelected) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 6),
                                      child: Row(
                                        children: [
                                          Text(
                                            "${item.nombre}",
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.indigo),
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8)),
                                          isSelected
                                              ? Icon(Icons.check_box_outlined)
                                              : SizedBox.shrink(),
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
                      const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 5),
                        child: Text("Lista de Actividades",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      SfDataGridTheme(
                        data: SfDataGridThemeData(
                            headerColor: CustomColors.azulCielo),
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
                                    child: Text('Actividad',
                                        style: CustomLabels.h4
                                            .copyWith(color: Colors.white)),
                                  ),
                                ),
                                GridColumn(
                                  columnWidthMode:
                                      ColumnWidthMode.fitByColumnName,
                                  columnName: 'terreno',
                                  label: Center(
                                    child: Text('Terreno',
                                        style: CustomLabels.h4
                                            .copyWith(color: Colors.white)),
                                  ),
                                ),
                                GridColumn(
                                  columnWidthMode: ColumnWidthMode.fill,
                                  columnName: 'fechaI',
                                  label: Center(
                                    child: Text('F.Inico',
                                        style: CustomLabels.h4
                                            .copyWith(color: Colors.white)),
                                  ),
                                ),
                                GridColumn(
                                  columnWidthMode: ColumnWidthMode.fill,
                                  columnName: 'fechaF',
                                  label: Center(
                                    child: Text('F.Fin',
                                        style: CustomLabels.h4
                                            .copyWith(color: Colors.white)),
                                  ),
                                ),
                              ],
                              source: DetailPlanDataSource(
                                  provider: provPlanificacion, cxt: context)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                              onPressed: () {
                                provPlanificacion.setIsDetail = true;
                              },
                              label: const Text('Regresar'),
                              icon: const Icon(Icons.arrow_back)),
                          const SizedBox(width: 10),
                          ElevatedButton.icon(
                              onPressed: () {
                                provPlanificacion.listDetailPlanificacion.add(
                                  Detalleplanificacion(
                                      actividad: provPlanificacion.txtName.text,
                                      estado: true,
                                      fin: UtilView.convertStringToDate(
                                          provPlanificacion.txtFin.text),
                                      idPlanificacion: "",
                                      idTerreno: "",
                                      iddetalleplanificacion: "",
                                      idtipograminea: "",
                                      inicio: UtilView.convertStringToDate(
                                          provPlanificacion.txtInicio.text),
                                      observacion2: "-",
                                      observacion: ""),
                                );
                                // provPlanificacion.setIsDetail = true;
                                setState(() {});
                              },
                              label: const Text('Agregar'),
                              icon: const Icon(Icons.save))
                        ],
                      ),
                    ],
                  ),
            acciones: const Icon(Icons.emoji_objects_rounded)),
      ),
    );
  }
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
