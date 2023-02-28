import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tesis_karina/datasource/usuario_datasource.dart';
import 'package:tesis_karina/entity/personas.dart';
import 'package:tesis_karina/entity/usuario.dart';
import 'package:tesis_karina/provider/user_form_provider.dart';
import 'package:tesis_karina/provider/usuario_provider.dart';
import 'package:tesis_karina/style/colors/custom_colors.dart';
import 'package:tesis_karina/style/custom/custom_labels.dart';
import 'package:tesis_karina/widgets/white_card.dart';

class UsuariosView extends StatefulWidget {
  const UsuariosView({Key? key}) : super(key: key);

  @override
  State<UsuariosView> createState() => _UsuariosViewState();
}

class _UsuariosViewState extends State<UsuariosView> {
  @override
  void initState() {
    Provider.of<UsuarioProvider>(context, listen: false).getListInt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UsuarioProvider>(context);
    return SingleChildScrollView(
      child: WhiteCard(
        title: 'Lista de Usuarios',
        acciones: InkWell(
            onTap: () {
              Provider.of<UserFormProvider>(context, listen: false).user =
                  Usuario(
                      idusuarios: "",
                      correo: "",
                      rol: "",
                      estado: true,
                      clave: "",
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now());

              Provider.of<UserFormProvider>(context, listen: false).person =
                  Persona(
                      idpersonas: "",
                      cedula: "",
                      nombre: "",
                      apellido: "",
                      direccion: "",
                      celular: "",
                      nacimiento: DateTime.now(),
                      estado: true,
                      idUsuario: "");

              Navigator.pushNamed(context, '/dashboard/usuario');
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
                    width: 40,
                    columnName: 'avatar',
                    label: Center(
                      child: Text('#',
                          style: CustomLabels.h4.copyWith(color: Colors.white)),
                    ),
                  ),
                  GridColumn(
                    columnWidthMode: ColumnWidthMode.fill,
                    columnName: 'correo',
                    label: Center(
                      child: Text('Correo',
                          style: CustomLabels.h4.copyWith(color: Colors.white)),
                    ),
                  ),
                  GridColumn(
                    columnWidthMode: ColumnWidthMode.fitByColumnName,
                    columnName: 'rol',
                    label: Center(
                      child: Text('Rol',
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
                source: UsuariosDataSource(provider: provider, cxt: context)),
          ),
        ),
      ),
    );
  }
}
