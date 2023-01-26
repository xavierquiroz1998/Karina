import 'package:flutter/material.dart';
import 'package:tesis_karina/datasource/terreno_datasource.dart';

class TerrenosView extends StatelessWidget {
  const TerrenosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Center(
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            PaginatedDataTable(
              columns: const [
                DataColumn(label: Text('#')),
                DataColumn(label: Text('Ubicacion')),
                DataColumn(label: Text('Dimensiones')),
                DataColumn(label: Text('Unidad')),
                DataColumn(label: Text('Acciones'))
              ],
              source: TerrenosDataSource([], context),
              onPageChanged: (page) {},
            ),
          ],
        ),
      ),
    );
  }
}
