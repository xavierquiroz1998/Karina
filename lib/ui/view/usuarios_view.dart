import 'package:flutter/material.dart';
import 'package:tesis_karina/datasource/usuario_datasource.dart';

class UsuariosView extends StatelessWidget {
  const UsuariosView({Key? key}) : super(key: key);

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
                DataColumn(label: Text('Avatar')),
                DataColumn(label: Text('Nombre')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Acciones'))
              ],
              source: UsuariosDataSource([], context),
              onPageChanged: (page) {},
            ),
          ],
        ),
      ),
    );
  }
}
