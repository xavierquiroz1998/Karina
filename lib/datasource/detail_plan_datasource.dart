import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tesis_karina/dialogs/dialog_acep_canc.dart';
import 'package:tesis_karina/dialogs/dialog_insumo.dart';
import 'package:tesis_karina/entity/detalle_planificacion.dart';
import 'package:tesis_karina/entity/insumo.dart';
import 'package:tesis_karina/provider/planificacion_provider.dart';
import 'package:tesis_karina/utils/util_view.dart';

class DetailPlanDataSource extends DataGridSource {
  late List<DataGridRow> listData;
  late BuildContext context;
  late PlanificacionProvider planificacionProvider;

  DetailPlanDataSource(
      {required PlanificacionProvider provider, required BuildContext cxt}) {
    context = cxt;
    planificacionProvider = provider;
    listData = planificacionProvider.listDetailPlanificacion
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'actividad', value: e.actividad),
              DataGridCell<String>(columnName: 'terreno', value: e.idTerreno),
              DataGridCell<String>(
                  columnName: 'fechaI',
                  value: UtilView.convertDateToString(e.inicio)),
              DataGridCell<String>(
                  columnName: 'fechaF',
                  value: UtilView.convertDateToString(e.fin)),
            ]))
        .toList();
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: <Widget>[
        Container(
            padding: const EdgeInsets.only(left: 7),
            alignment: Alignment.centerLeft,
            child: Text(row.getCells()[0].value.toString())),
        Container(
            padding: const EdgeInsets.only(left: 7),
            alignment: Alignment.center,
            child: Text(row.getCells()[1].value.toString())),
        Container(
            padding: const EdgeInsets.only(left: 7),
            alignment: Alignment.centerLeft,
            child: Text(row.getCells()[2].value.toString())),
        Container(
            padding: const EdgeInsets.only(left: 7),
            alignment: Alignment.centerLeft,
            child: Text(row.getCells()[3].value.toString())),

        // Container(
        //   alignment: Alignment.center,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       InkWell(
        //           onTap: () async {},
        //           child:
        //               const Icon(Icons.edit_outlined, color: Colors.blueGrey)),
        //       const SizedBox(width: 5),
        //       InkWell(
        //           onTap: () async {
        //             final respuesta = await dialogAcepCanc(
        //                 context,
        //                 "Seguro que deseas eliminar?",
        //                 Icons.delete,
        //                 Colors.red);

        //             if (respuesta) {
        //               // ignore: use_build_context_synchronously
        //             }
        //           },
        //           child: const Icon(Icons.delete, color: Colors.red))
        //     ],
        //   ),
        // ),
      ],
    );
  }

  @override
  List<DataGridRow> get rows => listData;
}
