import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis_karina/dialogs/dialog_mantenedores.dart';
import 'package:tesis_karina/provider/reporte_provider.dart';
import 'package:tesis_karina/style/colors/custom_colors.dart';
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
      appBar: AppBar(
        title: const Text('Generacion de reportes'),
        backgroundColor: CustomColors.customDefaut,
      ),
      body: WhiteCard(
        title: 'Tipos de reporte',
        acciones:
            InkWell(onTap: () {}, child: const Icon(Icons.calendar_month)),
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 220,
            child: SingleChildScrollView(
              child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: InkWell(
                        onTap: () {
                          provider.generateExcel(context);
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
                                constraints:
                                    const BoxConstraints(maxWidth: 200),
                                child: const Text(
                                  "ORDENES DE TRABAJOS",
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
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
                                constraints:
                                    const BoxConstraints(maxWidth: 200),
                                child: const Text(
                                  "CULTIVADO/EVOLUCION ",
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
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
                                constraints:
                                    const BoxConstraints(maxWidth: 200),
                                child: const Text(
                                  "INSUMOS/PLAGAS/ENFERMEDADES ",
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: InkWell(
                        onTap: () {
                          showDialogViewMantenedores(context);
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
                                child: Icon(Icons.assignment_rounded,
                                    size: 80, color: Colors.white),
                              ),
                            ),
                            Container(
                                padding: const EdgeInsets.all(8.0),
                                constraints:
                                    const BoxConstraints(maxWidth: 200),
                                child: const Text(
                                  "MANTENEDORES",
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: InkWell(
                        onTap: () {
                          provider.generateInsumosExcel(context);
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
                                constraints:
                                    const BoxConstraints(maxWidth: 200),
                                child: const Text(
                                  "Insumos",
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
