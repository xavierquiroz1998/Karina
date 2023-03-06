import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tesis_karina/dialogs/dialog_acep_canc.dart';
import 'package:tesis_karina/entity/enfermedad.dart';
import 'package:tesis_karina/provider/enfermedad_provider.dart';
import 'package:tesis_karina/utils/util_view.dart';

class EnfermedadesDataSource extends DataGridSource {
  late List<DataGridRow> listData;
  late BuildContext context;
  late EnfermedadProvider enfermedadProvider;

  EnfermedadesDataSource(
      {required EnfermedadProvider provider, required BuildContext cxt}) {
    context = cxt;
    enfermedadProvider = provider;
    listData = enfermedadProvider.listEnfermedad
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'nombre', value: e.nombre),
              DataGridCell<String>(columnName: 'obs', value: e.observacion),
              DataGridCell<Enfermedades>(columnName: 'acciones', value: e),
            ]))
        .toList();
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: <Widget>[
        Container(
            padding: const EdgeInsets.only(left: 5),
            alignment: Alignment.centerLeft,
            child: Text(row.getCells()[0].value.toString())),
        Container(
            padding: const EdgeInsets.only(left: 5),
            alignment: Alignment.centerLeft,
            child: Tooltip(
                message: row.getCells()[1].value.toString(),
                child: Text(row.getCells()[1].value.toString()))),
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
                        enfermedadProvider.isTipo = false;
                        enfermedadProvider
                            .mergerObjeto(row.getCells()[2].value);
                        Navigator.pushNamed(context, '/dashboard/enfermedad');
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
                          enfermedadProvider
                              .deleteObjeto(row.getCells()[2].value);
                        }
                      } else {
                        UtilView.messageSnackNewError(
                            "NO CONTIENE PERMISOS", context);
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