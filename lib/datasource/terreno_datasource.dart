import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tesis_karina/dialogs/dialog_acep_canc.dart';
import 'package:tesis_karina/entity/terreno.dart';
import 'package:tesis_karina/provider/terreno_provider.dart';

class TerrenosDataSource extends DataGridSource {
  late List<DataGridRow> listData;
  late BuildContext context;
  late TerrenoProvider terrenoProvider;

  TerrenosDataSource(
      {required TerrenoProvider provider, required BuildContext cxt}) {
    context = cxt;
    terrenoProvider = provider;
    listData = terrenoProvider.listTerreno
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'ubicacion', value: e.ubicacion),
              DataGridCell<String>(columnName: 'dimension', value: e.dimension),
              DataGridCell<Terreno>(columnName: 'acciones', value: e),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                    onTap: () async {},
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
                        terrenoProvider.deleteObjeto(row.getCells()[2].value);
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
