import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis_karina/provider/reporte_provider.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReporteProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Reportes')),
      body: InkWell(
          onTap: () {
            provider.generarChart();
          },
          child: const Text('data')),
    );
  }
}
