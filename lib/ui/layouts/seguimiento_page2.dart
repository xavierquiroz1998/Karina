import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tesis_karina/datasource/detail_plan_datasource.dart';
import 'package:tesis_karina/provider/historial_provider.dart';
import 'package:tesis_karina/style/colors/custom_colors.dart';
import 'package:tesis_karina/style/custom/custom_labels.dart';
import 'package:tesis_karina/widgets/white_card.dart';

class SeguiminentoPage2 extends StatefulWidget {
  const SeguiminentoPage2({Key? key}) : super(key: key);

  @override
  State<SeguiminentoPage2> createState() => _SeguiminentoPage2State();
}

class _SeguiminentoPage2State extends State<SeguiminentoPage2> {
  @override
  void initState() {
    Provider.of<HistorialProvider>(context, listen: false).getListIntDetail2();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HistorialProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Terrenos'),
          backgroundColor: CustomColors.customDefaut,
        ),
        body: WhiteCard(
          title: 'Estado de los terrenos',
          acciones: const Text(''),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 220,
              child: SfDataGridTheme(
                data:
                    SfDataGridThemeData(headerColor: CustomColors.customDefaut),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 500,
                  child: SfDataGrid(
                    headerRowHeight: 35.0,
                    rowHeight: 35.0,
                    columns: <GridColumn>[
                      GridColumn(
                        columnWidthMode: ColumnWidthMode.fill,
                        columnName: 'actividad',
                        label: Center(
                          child: Text('ACTIVIDAD',
                              style: CustomLabels.h4
                                  .copyWith(color: Colors.white)),
                        ),
                      ),
                      GridColumn(
                        columnWidthMode: ColumnWidthMode.fill,
                        columnName: 'fechaI',
                        label: Center(
                          child: Text('INICIO',
                              style: CustomLabels.h4
                                  .copyWith(color: Colors.white)),
                        ),
                      ),
                      GridColumn(
                        columnWidthMode: ColumnWidthMode.fill,
                        columnName: 'fechaF',
                        label: Center(
                          child: Text('FIN',
                              style: CustomLabels.h4
                                  .copyWith(color: Colors.white)),
                        ),
                      ),
                      GridColumn(
                        columnWidthMode: ColumnWidthMode.fill,
                        columnName: 'estado',
                        label: Center(
                          child: Text('Estado',
                              style: CustomLabels.h4
                                  .copyWith(color: Colors.white)),
                        ),
                      ),
                    ],
                    source:
                        DetailPlanDataSource(provider: provider, cxt: context),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}



/* 

Wrap(
              alignment: WrapAlignment.start,
              spacing: 20,
              runSpacing: 20,
              children: [
                provider.listTerreno.isEmpty
                    ? const Text('NO HAY REGISTRADO NINGUNA FINCA',
                        style: TextStyle(color: Colors.grey, fontSize: 16))
                    : const Text(''),
                for (var item in provider.listTerreno) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: InkWell(
                      onTap: () {
                        provider.selectTerreno = item;
                        Navigator.pushNamed(
                            context, '/dashboard/controlObservaciones');
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: item.disponibilidad == "1"
                                    ? Colors.green[700]
                                    : Colors.blueGrey),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.home_filled,
                                size: 80,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.all(8.0),
                              constraints: const BoxConstraints(maxWidth: 200),
                              child: Text(
                                item.ubicacion.toUpperCase(),
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ))
                        ],
                      ),
                    ),
                  )
                ]
              ],
            )

 */