import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tesis_karina/datasource/finca_datasource.dart';
import 'package:tesis_karina/dialogs/dialog_finca.dart';
import 'package:tesis_karina/provider/finca_provider.dart';
import 'package:tesis_karina/style/colors/custom_colors.dart';
import 'package:tesis_karina/style/custom/custom_labels.dart';
import 'package:tesis_karina/utils/util_view.dart';
import 'package:tesis_karina/widgets/white_card.dart';

class FincaView extends StatefulWidget {
  const FincaView({Key? key}) : super(key: key);

  @override
  State<FincaView> createState() => _FincaViewState();
}

class _FincaViewState extends State<FincaView> {
  @override
  void initState() {
    Provider.of<FincaProvider>(context, listen: false).getListInt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FincaProvider>(context);
    return SingleChildScrollView(
      child: WhiteCard(
        title: 'Lista de fincas',
        acciones: UtilView.usuarioUtil.rol == "Admin"
            ? InkWell(
                onTap: () {
                  showDialogViewFinca(context, "Nueva finca", provider, null);
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
                  columnName: 'nombre',
                  label: Center(
                    child: Text('Nombre',
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
                  columnWidthMode: ColumnWidthMode.fill,
                  columnName: 'ubicacion',
                  label: Center(
                    child: Text('Ubicación',
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
              source: FincaDataSource(provider: provider, cxt: context),
            ),
          ),
        ),
      ),
    );
  }
}
