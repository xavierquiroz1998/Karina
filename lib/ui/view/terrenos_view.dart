import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tesis_karina/datasource/terreno_datasource.dart';
import 'package:tesis_karina/dialogs/dialog_terreno.dart';
import 'package:tesis_karina/provider/terreno_provider.dart';
import 'package:tesis_karina/style/colors/custom_colors.dart';
import 'package:tesis_karina/style/custom/custom_labels.dart';
import 'package:tesis_karina/utils/util_view.dart';
import 'package:tesis_karina/widgets/white_card.dart';

class TerrenosView extends StatefulWidget {
  const TerrenosView({Key? key}) : super(key: key);

  @override
  State<TerrenosView> createState() => _TerrenosViewState();
}

class _TerrenosViewState extends State<TerrenosView> {
  @override
  void initState() {
    Provider.of<TerrenoProvider>(context, listen: false).getListInt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TerrenoProvider>(context);
    return SingleChildScrollView(
      child: WhiteCard(
        title: 'Lista de Terrenos',
        acciones: UtilView.usuarioUtil.rol == "Admin"
            ? InkWell(
                onTap: () {
                  showDialogViewTerreno(
                      context, "Nuevo terreno", provider, null);
                },
                child:
                    const Tooltip(message: "Agregar", child: Icon(Icons.add)))
            : Text(''),
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
                  columnName: 'ubicacion',
                  label: Center(
                    child: Text('Ubicación',
                        style: CustomLabels.h4.copyWith(color: Colors.white)),
                  ),
                ),
                GridColumn(
                  columnWidthMode: ColumnWidthMode.fill,
                  columnName: 'dimension',
                  label: Center(
                    child: Text('Dimensión',
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
              source: TerrenosDataSource(provider: provider, cxt: context),
            ),
          ),
        ),
      ),
    );
  }
}
