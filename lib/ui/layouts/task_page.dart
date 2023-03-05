// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tesis_karina/dialogs/dialog_acep_canc.dart';
import 'package:tesis_karina/dialogs/dialog_adiciones.dart';
import 'package:tesis_karina/dialogs/dialog_comentario.dart';
import 'package:tesis_karina/dialogs/dialog_cosecha.dart';
import 'package:tesis_karina/provider/seguimiento3_provider.dart';
import 'package:tesis_karina/provider/cultivo_task_provider.dart';
import 'package:tesis_karina/provider/task_provider.dart';
import 'package:tesis_karina/style/buttons/custom_form_button.dart';
import 'package:tesis_karina/style/colors/custom_colors.dart';
import 'package:tesis_karina/utils/util_view.dart';
import 'package:tesis_karina/widgets/white_card.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  void initState() {
    Provider.of<TaskProvider>(context, listen: false).getListTaskUsuer();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tareas'),
        backgroundColor: CustomColors.customDefaut,
      ),
      body: ListView(
        children: [
          WhiteCard(
              title: 'Lista de activiades [Pendientes]',
              // ignore: sort_child_properties_last
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: Colors.grey,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 200,
                    child: provider.listTask.isNotEmpty
                        ? ListView.builder(
                            itemCount: provider.listTask.length,
                            itemBuilder: (context, i) {
                              return Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                            child: Padding(
                                          padding: const EdgeInsets.all(9),
                                          child: Text(
                                              "ID: ${provider.listTask[i].actividad}",
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        )),
                                        Container(
                                          margin: const EdgeInsets.all(5),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          color: provider.listTask[i]
                                                      .observacion ==
                                                  "-"
                                              ? Colors.grey[600]
                                              : Colors.orangeAccent[700],
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  if (provider.listTask[i]
                                                          .observacion ==
                                                      "-") {
                                                    final opt = await dialogAcepCanc(
                                                        context,
                                                        "Deseas asignarte la tarea?",
                                                        Icons
                                                            .check_circle_outline_outlined,
                                                        Colors.blueGrey);

                                                    if (opt) {
                                                      provider.listTask[i]
                                                              .inicio =
                                                          UtilView.convertStringToDate(
                                                              DateFormat(
                                                                      "dd/MM/yyyy")
                                                                  .format(provider
                                                                      .listTask[
                                                                          i]
                                                                      .inicio));
                                                      provider.listTask[i].fin =
                                                          UtilView.convertStringToDate(
                                                              DateFormat(
                                                                      "dd/MM/yyyy")
                                                                  .format(provider
                                                                      .listTask[
                                                                          i]
                                                                      .fin));

                                                      provider.listTask[i]
                                                              .observacion =
                                                          provider
                                                              .codigoPersona;

                                                      provider.userTask(
                                                          provider.listTask[i]);

                                                      UtilView.messageAccess(
                                                          "Inicio del proceso ${UtilView.convertDateToString(DateTime.now())}",
                                                          Colors.green);
                                                    }
                                                  } else {
                                                    UtilView.messageWarning(
                                                        "Tarea en proceso");
                                                  }
                                                },
                                                child: Text(
                                                  provider.listTask[i]
                                                              .observacion ==
                                                          "-"
                                                      ? "Pendiente"
                                                      : "En proceso",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Icon(provider.listTask[i]
                                                          .observacion ==
                                                      "-"
                                                  ? Icons.assignment_ind
                                                  : provider.listTask[i].estado
                                                      ? Icons.timer
                                                      : Icons.error)
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                            child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 9),
                                          child: Text(
                                              "Etapa: ${UtilView.processEtapaUtil(provider.listTask[i].etapa).toLowerCase()}",
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        )),
                                        Flexible(
                                            child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 9),
                                          child: Text(
                                              "Process: ${UtilView.processNivelUtil(provider.listTask[i].nivel)}",
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold)),
                                        )),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                            child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 9),
                                          child: Text(
                                              "Inicio: ${UtilView.convertDateToString(provider.listTask[i].inicio)}",
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        )),
                                        Flexible(
                                            child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 9),
                                          child: Text(
                                              "Fin: ${UtilView.convertDateToString(provider.listTask[i].fin)}",
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        )),
                                      ],
                                    ),
                                    const Divider(color: Colors.black),
                                    provider.listTask[i].observacion != "-"
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 6),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        border: Border.all(
                                                          color: Colors.grey
                                                              .withOpacity(0.3),
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    10))),
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5),
                                                    padding:
                                                        const EdgeInsets.all(3),
                                                    child: InkWell(
                                                        onTap: () async {
                                                          String resp =
                                                              await dialogComentario(
                                                                  context,
                                                                  "¿Deseas Terminar el proceso?");
                                                          if (resp != "") {
                                                            provider.listTask[i]
                                                                .inicio = UtilView.convertStringToDate(DateFormat(
                                                                    "dd/MM/yyyy")
                                                                .format(provider
                                                                    .listTask[i]
                                                                    .inicio));

                                                            provider.listTask[i]
                                                                    .observacion =
                                                                resp;

                                                            provider.listTask[i]
                                                                    .fin =
                                                                DateTime.now();

                                                            provider.listTask[i]
                                                                .nivel = (provider
                                                                    .listTask[i]
                                                                    .nivel +
                                                                1);

                                                            if (provider.listTask[i].nivel == 4 ||
                                                                provider
                                                                        .listTask[
                                                                            i]
                                                                        .nivel ==
                                                                    7 ||
                                                                provider
                                                                        .listTask[
                                                                            i]
                                                                        .nivel ==
                                                                    11) {
                                                              provider
                                                                  .listTask[i]
                                                                  .etapa = (provider
                                                                      .listTask[
                                                                          i]
                                                                      .etapa +
                                                                  1);
                                                            }

                                                            if (provider
                                                                        .listTask[
                                                                            i]
                                                                        .etapa ==
                                                                    3 &&
                                                                provider
                                                                        .listTask[
                                                                            i]
                                                                        .nivel ==
                                                                    9) {
                                                              provider
                                                                  .listTask[i]
                                                                  .observacion = "C";

                                                              provider
                                                                  .listTask[i]
                                                                  .estado = false;

                                                              final respuesta =
                                                                  await dialogCosechaKg(
                                                                      context,
                                                                      provider
                                                                          .listTask[i]);

                                                              if (respuesta) {
                                                                provider.closeTask(
                                                                    provider
                                                                        .listTask[i]);

                                                                provider
                                                                    .listTask
                                                                    .remove(provider
                                                                        .listTask[i]);
                                                              }
                                                            } else {
                                                              provider.update(
                                                                  provider
                                                                      .listTask[i]);
                                                            }
                                                          }
                                                        },
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: const [
                                                            Icon(
                                                                Icons.check_box,
                                                                size: 20,
                                                                color: Colors
                                                                    .black),
                                                            Text(
                                                              'Sigs Proceso',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          ],
                                                        ))),
                                                Container(
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Colors.amber[700],
                                                        border: Border.all(
                                                          color: Colors.grey
                                                              .withOpacity(0.3),
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    10))),
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5),
                                                    padding:
                                                        const EdgeInsets.all(3),
                                                    child: InkWell(
                                                        onTap: () async {
                                                          provider
                                                              .inializacion();
                                                          final resp =
                                                              await dialogAdiciones(
                                                                  context,
                                                                  provider);
                                                          if (resp) {
                                                            provider.saveList(
                                                                provider
                                                                    .listTask[i]
                                                                    .iddetalleplanificacion);
                                                          }
                                                        },
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: const [
                                                            Icon(
                                                                Icons
                                                                    .assignment_add,
                                                                size: 20,
                                                                color: Colors
                                                                    .black),
                                                            Text(
                                                              'Agregar',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          ],
                                                        ))),
                                                if (provider
                                                        .listTask[i].nivel ==
                                                    0)
                                                  Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.blue,
                                                          border: Border.all(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.3),
                                                          ),
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3),
                                                      child: InkWell(
                                                          onTap: () async {
                                                            final seguimiento =
                                                                Provider.of<
                                                                        Seguimiento3Provider>(
                                                                    context,
                                                                    listen:
                                                                        false);
                                                            seguimiento
                                                                .getListTerrenoOne(
                                                                    provider
                                                                        .listTask[
                                                                            i]
                                                                        .idTerreno);
                                                            seguimiento
                                                                    .selectT =
                                                                provider
                                                                    .listTask[i]
                                                                    .idTerreno;
                                                            seguimiento
                                                                    .selectDetail =
                                                                provider
                                                                    .listTask[i];

                                                            Navigator.pushNamed(
                                                                context,
                                                                '/dashboard/controlSeguimiento3');
                                                          },
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: const [
                                                              Icon(
                                                                  Icons
                                                                      .assistant_photo_rounded,
                                                                  size: 20,
                                                                  color: Colors
                                                                      .black),
                                                              Text(
                                                                'Observacion',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            ],
                                                          ))),
                                              ],
                                            ),
                                          )
                                        : const Text('')
                                  ],
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: Text(
                              'Estas al dia con tus tareas',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                  )
                ],
              ),
              acciones: const Icon(Icons.emoji_objects_rounded)),
        ],
      ),
    );
  }
}
