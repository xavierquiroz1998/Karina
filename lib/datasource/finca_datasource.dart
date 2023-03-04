import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tesis_karina/dialogs/dialog_acep_canc.dart';
import 'package:tesis_karina/dialogs/dialog_finca.dart';
import 'package:tesis_karina/entity/finca.dart';
import 'package:tesis_karina/provider/finca_provider.dart';
import 'package:tesis_karina/utils/util_view.dart';

class FincaDataSource extends DataGridSource {
  late List<DataGridRow> listData;
  late BuildContext context;
  late FincaProvider fincaProvider;

  FincaDataSource(
      {required FincaProvider provider, required BuildContext cxt}) {
    context = cxt;
    fincaProvider = provider;
    listData = fincaProvider.listFinca
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'nombre', value: e.nombre),
              DataGridCell<String>(columnName: 'dimension', value: e.dimension),
              DataGridCell<String>(columnName: 'ubicacion', value: e.ubicacion),
              DataGridCell<Finca>(columnName: 'acciones', value: e),
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
            alignment: Alignment.centerLeft,
            child: Text(row.getCells()[1].value.toString())),
        Container(
            alignment: Alignment.center,
            child: Text(row.getCells()[2].value.toString())),
        Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                    onTap: () {
                      if (UtilView.usuarioUtil.rol == "Admin") {
                        showDialogViewFinca(context, "Actualizar finca",
                            fincaProvider, row.getCells()[3].value);
                      } else {
                        UtilView.messageSnackNewError(
                            "NO CONTIENE PERMISOS", context);
                      }
                    },
                    child: const Icon(Icons.edit_outlined,
                        color: Colors.blueGrey)),
                const SizedBox(width: 5),
                InkWell(
                    onTap: () async {
                      if (UtilView.usuarioUtil.rol == "Admin") {
                        final respuesta = await dialogAcepCanc(
                            context,
                            "Seguro que deseas eliminar?",
                            Icons.delete,
                            Colors.red);

                        if (respuesta) {
                          // ignore: use_build_context_synchronously
                          fincaProvider.deleteObjeto(row.getCells()[3].value);
                        } else {
                          UtilView.messageSnackNewError(
                              "NO CONTIENE PERMISOS", context);
                        }
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


/* 

  Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(10.0),
          child: Tooltip(
            message: row.getCells()[1].value.toString(),
            child: Text(
              row.getCells()[1].value.toString(),
              overflow: TextOverflow.ellipsis,
              style: buildStyle(),
              softWrap: true,
              maxLines: 2,
            ),
          ),
        ),

 Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: Text(NumberFormat.currency(
                    locale: 'en_US', symbol: r'$', decimalDigits: 2)
                .format(row.getCells()[4].value))),
 */