import 'package:flutter/material.dart';
import 'package:tesis_karina/style/custom/custom_labels.dart';

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
            Text('Vista de Usuarios', style: CustomLabels.h1),
            const SizedBox(height: 10),
            PaginatedDataTable(
              columns: const [
                DataColumn(label: Text('#')),
                DataColumn(label: Text('Avatar')),
                DataColumn(label: Text('Nombre')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Acciones'))
              ],
              source: usersDataSource,
              onPageChanged: (page) {},
            ),
          ],
        ),
      ),
    );
  }
}
