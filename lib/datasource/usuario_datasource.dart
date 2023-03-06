// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tesis_karina/dialogs/dialog_acep_canc.dart';
import 'package:tesis_karina/entity/usuario.dart';
import 'package:tesis_karina/provider/user_form_provider.dart';
import 'package:tesis_karina/provider/usuario_provider.dart';
import 'package:tesis_karina/utils/util_view.dart';

class UsuariosDataSource extends DataGridSource {
  late List<DataGridRow> listData;
  late BuildContext context;
  late UsuarioProvider usuarioProvider;

  UsuariosDataSource(
      {required UsuarioProvider provider, required BuildContext cxt}) {
    context = cxt;
    usuarioProvider = provider;
    listData = usuarioProvider.listUsuario
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'avatar', value: e.img),
              DataGridCell<String>(columnName: 'correo', value: e.correo),
              DataGridCell<String>(columnName: 'rol', value: e.rol),
              DataGridCell<Usuario>(columnName: 'acciones', value: e),
            ]))
        .toList();
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    final image =
        (row.getCells()[0].value == null || row.getCells()[0].value == "")
            ? const Image(
                image: AssetImage('assets/no-image.jpg'), width: 20, height: 20)
            : FadeInImage.assetNetwork(
                placeholder: 'assets/loader.gif',
                image: row.getCells()[0].value.toString(),
                width: 20,
                height: 20);

    return DataGridRowAdapter(
      cells: <Widget>[
        Container(alignment: Alignment.center, child: ClipOval(child: image)),
        Container(
            alignment: Alignment.center,
            child: Text(row.getCells()[1].value.toString())),
        Container(
            alignment: Alignment.center,
            child: Text(row.getCells()[2].value.toString())),
        Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                    onTap: () async {
                      if (UtilView.usuarioUtil.rol == "Admin") {
                        final opt = await usuarioProvider
                            .getPersonById(row.getCells()[3].value.idusuarios);

                        Provider.of<UserFormProvider>(context, listen: false)
                            .user = row.getCells()[3].value;
                        Provider.of<UserFormProvider>(context, listen: false)
                            .person = opt;

                        Navigator.pushNamed(context, '/dashboard/usuario');
                      } else {
                        UtilView.messageSnackNewError(
                            "NO CONTIENE PERMISOS", context);
                      }
                      /* Provider.of<UsuarioProvider>(context, listen: false)
                          .getUserById(row.getCells()[4].value.uid); */
                    },
                    child: const Icon(Icons.edit_outlined,
                        color: Colors.blueGrey)),
                const SizedBox(width: 5),
                InkWell(
                    onTap: () async {
                      if (UtilView.usuarioUtil.rol == "Admin") {
                        final respuesta = await dialogAcepCanc(
                            context,
                            "Seguro que deseas eliminar?",
                            Icons.delete,
                            Colors.red);

                        if (respuesta) {
                          usuarioProvider.deleteObjeto(row.getCells()[3].value);
                        }
                      } else {
                        UtilView.messageSnackNewError(
                            "NO CONTIENE PERMISOS", context);
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
