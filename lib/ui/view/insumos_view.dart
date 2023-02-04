import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tesis_karina/datasource/insumo_datasource.dart';
import 'package:tesis_karina/dialogs/dialog_insumo.dart';
import 'package:tesis_karina/provider/insumo_provider.dart';
import 'package:tesis_karina/style/colors/custom_colors.dart';
import 'package:tesis_karina/style/custom/custom_labels.dart';
import 'package:tesis_karina/widgets/white_card.dart';

class InsumosView extends StatefulWidget {
  const InsumosView({Key? key}) : super(key: key);

  @override
  State<InsumosView> createState() => _InsumosViewState();
}

class _InsumosViewState extends State<InsumosView> {
  @override
  void initState() {
    Provider.of<InsumoProvider>(context, listen: false).getListInt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InsumoProvider>(context);
    return SingleChildScrollView(
      child: WhiteCard(
        title: 'Lista de insumos',
        acciones: InkWell(
            onTap: () {
              showDialogViewInsumo(context, "Nuevo insumo", provider, null);
            },
            child: const Tooltip(message: "Agregar", child: Icon(Icons.add))),
        child: SfDataGridTheme(
          data: SfDataGridThemeData(headerColor: CustomColors.azulCielo),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 250,
            child: SfDataGrid(
              headerRowHeight: 35.0,
              rowHeight: 35.0,
              columns: <GridColumn>[
                GridColumn(
                  columnWidthMode: ColumnWidthMode.fill,
                  columnName: 'nombre',
                  label: Tooltip(
                    message: "Nombre",
                    child: Center(
                      child: Text('Nombre',
                          style: CustomLabels.h4.copyWith(color: Colors.white)),
                    ),
                  ),
                ),
                GridColumn(
                  columnWidthMode: ColumnWidthMode.fill,
                  columnName: 'tipo',
                  label: Tooltip(
                    message: "Tipo",
                    child: Center(
                      child: Text('Tipo',
                          style: CustomLabels.h4.copyWith(color: Colors.white)),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'acciones',
                  label: Center(
                    child: Text('Acciones',
                        style: CustomLabels.h4.copyWith(color: Colors.white)),
                  ),
                ),
              ],
              source: InsumosDataSource(provider: provider, cxt: context),
            ),
          ),
        ),
      ),
    );
  }
}
