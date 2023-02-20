import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis_karina/provider/reporte_provider.dart';
import 'package:tesis_karina/utils/util_view.dart';
import 'package:tesis_karina/widgets/white_card.dart';

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
      appBar: AppBar(title: const Text('Generacion de reportes')),
      body: WhiteCard(
        title: 'Tipos de reporte',
        acciones: const Text(''),
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 220,
            child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 20,
                runSpacing: 20,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: InkWell(
                      onTap: () {
                        provider.generateExcel();
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.green[700]),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.assignment_add,
                                size: 80,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.all(8.0),
                              constraints: const BoxConstraints(maxWidth: 200),
                              child: Text(
                                "ORDENES DE TRABAJOS",
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ))
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: InkWell(
                      onTap: () {
                        provider.generarChart();
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.green[700]),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.local_offer_sharp,
                                size: 80,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.all(8.0),
                              constraints: const BoxConstraints(maxWidth: 200),
                              child: Text(
                                "CULTIVADO/EVOLUCION ",
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ))
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: InkWell(
                      onTap: () {
                        provider.generateEnfAndPlagExcel();
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.green[700]),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.medical_information,
                                size: 80,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.all(8.0),
                              constraints: const BoxConstraints(maxWidth: 200),
                              child: Text(
                                "INSUMOS/PLAGAS/ENFERMEDADES ",
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ))
                        ],
                      ),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
