import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tesis_karina/dialogs/dialog_acep_canc.dart';
import 'package:tesis_karina/modals/enfermedad_modals.dart';
import 'package:tesis_karina/entity/enfermedad.dart';
import 'package:tesis_karina/provider/enfermedad_provider.dart';

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
              const DataGridCell<String>(columnName: 'index', value: "0"),
              DataGridCell<String>(columnName: 'nombre', value: e.nombre),
              DataGridCell<String>(columnName: 'grado', value: e.grado),
              DataGridCell<String>(columnName: 'estado', value: e.estado),
              DataGridCell<Enfermedad>(columnName: 'acciones', value: e),
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
            child: Icon(Icons.warning_rounded,
                color:
                    row.getCells()[2].value.toString().toLowerCase() == "medio"
                        ? Colors.amber
                        : Colors.red)),
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
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (_) => EnfermedadModals(
                              enfermedad: row.getCells()[4].value));
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
                        enfermedadProvider
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