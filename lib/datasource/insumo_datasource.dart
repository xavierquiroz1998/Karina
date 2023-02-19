import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tesis_karina/dialogs/dialog_acep_canc.dart';
import 'package:tesis_karina/dialogs/dialog_insumo.dart';
import 'package:tesis_karina/entity/insumo.dart';
import 'package:tesis_karina/provider/insumo_provider.dart';
import 'package:tesis_karina/utils/util_view.dart';

class InsumosDataSource extends DataGridSource {
  late List<DataGridRow> listData;
  late BuildContext context;
  late InsumoProvider insumoProvider;

  InsumosDataSource(
      {required InsumoProvider provider, required BuildContext cxt}) {
    context = cxt;
    insumoProvider = provider;
    listData = insumoProvider.listInsumo
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'nombre', value: e.nombre),
              DataGridCell<String>(columnName: 'unidad', value: e.unidades),
              DataGridCell<String>(
                  columnName: 'fecha',
                  value: UtilView.convertDateToString(e.fechaCaducidad)),
              DataGridCell<Insumos>(columnName: 'acciones', value: e),
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
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                    onTap: () async {
                      showDialogViewInsumo(context, "Actualizar insumo",
                          insumoProvider, row.getCells()[3].value);
                    },
                    child: const Icon(Icons.edit_outlined,
                        color: Colors.blueGrey)),
                const SizedBox(width: 5),
                InkWell(
                    onTap: () async {
                      final respuesta = await dialogAcepCanc(
                          context,
                          "Seguro que deseas eliminar?",
                          Icons.delete,
                          Colors.red);

                      if (respuesta) {
                        // ignore: use_build_context_synchronously
                        insumoProvider.deleteObjeto(row.getCells()[3].value);
                      }
                    },
                    child: const Icon(Icons.delete, color: Colors.red))
              ],
            )),
      ],
    );
  }

  @override
  List<DataGridRow> get rows => listData;
}
