import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tesis_karina/dialogs/dialog_acep_canc.dart';
import 'package:tesis_karina/dialogs/dialog_maquinaria.dart';
import 'package:tesis_karina/entity/maquinaria.dart';
import 'package:tesis_karina/provider/maquinaria_provider.dart';

class MaquinariasDataSource extends DataGridSource {
  late List<DataGridRow> listData;
  late BuildContext context;
  late MaquinariaProvider maquinariaProvider;

  MaquinariasDataSource(
      {required MaquinariaProvider provider, required BuildContext cxt}) {
    context = cxt;
    maquinariaProvider = provider;
    listData = maquinariaProvider.listMaquinaria
        .map<DataGridRow>((e) => DataGridRow(cells: [
              const DataGridCell<String>(columnName: 'index', value: "0"),
              DataGridCell<String>(columnName: 'nombre', value: e.nombre),
              DataGridCell<String>(columnName: 'tipo', value: e.tipo),
              DataGridCell<String>(columnName: 'estado', value: e.estado),
              DataGridCell<Maquinaria>(columnName: 'acciones', value: e),
            ]))
        .toList();
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: <Widget>[
        Container(
            alignment: Alignment.center,
            child: Text(row.getCells()[0].value.toString())),
        Container(
            alignment: Alignment.center,
            child: Text(row.getCells()[1].value.toString())),
        Container(
            alignment: Alignment.center,
            child: Text(row.getCells()[2].value.toString())),
        Container(
            alignment: Alignment.center,
            child: Text(row.getCells()[3].value.toString())),
        Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                    onTap: () async {
                      maquinariaProvider.txtNonbre.text =
                          row.getCells()[4].value;
                      maquinariaProvider.txtTipo.text = row.getCells()[4].value;
                      showDialogViewMaquinaria(context, "Actualizar Maquinaria",
                          maquinariaProvider, row.getCells()[4].value);
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
                        maquinariaProvider
                            .deleteObjeto(row.getCells()[4].value);
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
