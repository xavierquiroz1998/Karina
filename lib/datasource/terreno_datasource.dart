import 'package:flutter/material.dart';
import 'package:tesis_karina/entity/terreno.dart';
import 'package:tesis_karina/services/navigation_service.dart';

class TerrenosDataSource extends DataTableSource {
  final List<Terreno> terrenos;
  final BuildContext context;

  TerrenosDataSource(this.terrenos, this.context);

  @override
  DataRow getRow(int index) {
    final users = terrenos[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text('${index + 1}')),
      DataCell(Text(users.ubicacion)),
      DataCell(Text(users.dimension)),
      DataCell(Text(users.unidad)),
      DataCell(IconButton(
          onPressed: () {
            NavigationService.replaceTo('/dashboard/users/${users.uid}');
          },
          icon: const Icon(Icons.edit_outlined))),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => terrenos.length;

  @override
  int get selectedRowCount => 0;
}
