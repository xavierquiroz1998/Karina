import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tesis_karina/datasource/enfermedad_datasource.dart';
import 'package:tesis_karina/provider/enfermedad_provider.dart';
import 'package:tesis_karina/style/colors/custom_colors.dart';
import 'package:tesis_karina/style/custom/custom_labels.dart';
import 'package:tesis_karina/utils/util_view.dart';
import 'package:tesis_karina/widgets/white_card.dart';

class EnfermedadesView extends StatefulWidget {
  const EnfermedadesView({Key? key}) : super(key: key);

  @override
  State<EnfermedadesView> createState() => _EnfermedadesViewState();
}

class _EnfermedadesViewState extends State<EnfermedadesView> {
  @override
  void initState() {
    Provider.of<EnfermedadProvider>(context, listen: false).getListInt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EnfermedadProvider>(context);
    return SingleChildScrollView(
      child: WhiteCard(
        title: 'Lista de enfermedades',
        acciones: UtilView.usuarioUtil.rol == "Admin"
            ? InkWell(
                onTap: () {
                  provider.clearObjeto();
                  Navigator.pushNamed(context, '/dashboard/enfermedad');
                  /*  showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => const EnfermedadModals(enfermedad: null)); */
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
                  columnName: 'nombre',
                  label: Center(
                    child: Text(
                      'Nombre',
                      style: CustomLabels.h4.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                GridColumn(
                  columnWidthMode: ColumnWidthMode.fill,
                  columnName: 'obs',
                  label: Center(
                    child: Text(
                      'Observacion',
                      style: CustomLabels.h4.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'acciones',
                  label: Center(
                    child: Text(
                      'Acciones',
                      style: CustomLabels.h4.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
              source: EnfermedadesDataSource(provider: provider, cxt: context),
            ),
          ),
        ),
      ),
    );
  }
}
