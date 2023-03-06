import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tesis_karina/datasource/maquinaria_datasource.dart';
import 'package:tesis_karina/dialogs/dialog_maquinaria.dart';
import 'package:tesis_karina/provider/maquinaria_provider.dart';
import 'package:tesis_karina/style/colors/custom_colors.dart';
import 'package:tesis_karina/style/custom/custom_labels.dart';
import 'package:tesis_karina/utils/util_view.dart';
import 'package:tesis_karina/widgets/white_card.dart';

class MaquinariasView extends StatefulWidget {
  const MaquinariasView({Key? key}) : super(key: key);

  @override
  State<MaquinariasView> createState() => _MaquinariasViewState();
}

class _MaquinariasViewState extends State<MaquinariasView> {
  @override
  void initState() {
    Provider.of<MaquinariaProvider>(context, listen: false).getListInt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MaquinariaProvider>(context);

    return SingleChildScrollView(
      child: WhiteCard(
        title: 'Lista de Maquinarias',
        acciones: UtilView.usuarioUtil.rol == "Admin"
            ? InkWell(
                onTap: () {
                  showDialogViewMaquinaria(
                      context, "Nueva Maquinaria", provider, null);
                },
                child:
                    const Tooltip(message: "Agregar", child: Icon(Icons.add)))
            : const Text(''),
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
                  columnName: 'identificacion',
                  label: Center(
                    child: Text('Identificacion',
                        style: CustomLabels.h4.copyWith(color: Colors.white)),
                  ),
                ),
                GridColumn(
                  columnWidthMode: ColumnWidthMode.fill,
                  columnName: 'nombre',
                  label: Center(
                    child: Text('Nombre',
                        style: CustomLabels.h4.copyWith(color: Colors.white)),
                  ),
                ),
                GridColumn(
                  columnWidthMode: ColumnWidthMode.fill,
                  columnName: 'capacidad',
                  label: Center(
                    child: Text('N°',
                        style: CustomLabels.h4.copyWith(color: Colors.white)),
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
              source: MaquinariasDataSource(provider: provider, cxt: context),
            ),
          ),
        ),
      ),
    );
  }
}
