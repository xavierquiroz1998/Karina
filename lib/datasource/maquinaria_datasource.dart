import 'package:flutter/material.dart';
import 'package:tesis_karina/entity/usuario.dart';
import 'package:tesis_karina/services/navigation_service.dart';

class MaquinariasDataSource extends DataTableSource {
  final List<Usuario> usuarios;
  final BuildContext context;

  MaquinariasDataSource(this.usuarios, this.context);

  @override
  DataRow getRow(int index) {
    final users = usuarios[index];

    final image = (users.img == null)
        ? const Image(image: AssetImage('no-image.jpg'), width: 35, height: 35)
        : FadeInImage.assetNetwork(
            placeholder: 'loader.gif',
            image: users.img!,
            width: 35,
            height: 35);

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text('${index + 1}')),
      DataCell(ClipOval(
        child: image,
      )),
      //DataCell(Text(users.uid)),
      DataCell(Text(users.nombre)),
      DataCell(Text(users.correo)),

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
  int get rowCount => usuarios.length;

  @override
  int get selectedRowCount => 0;
}
