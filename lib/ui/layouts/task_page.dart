import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis_karina/dialogs/dialog_comentario.dart';
import 'package:tesis_karina/provider/task_provider.dart';
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
      appBar: AppBar(title: const Text('Generar Tareas')),
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
                    height: MediaQuery.of(context).size.height - 200,
                    child: ListView.builder(
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
                                    child: Text(provider.listTask[i].actividad,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  )),
                                  Container(
                                    margin: const EdgeInsets.all(5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    color:
                                        provider.listTask[i].observacion == "-"
                                            ? Colors.amber
                                            : Colors.green,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (provider
                                                    .listTask[i].observacion ==
                                                "-") {
                                              UtilView.messageAccess(
                                                  "Tarea asignada",
                                                  Colors.green);
                                            } else {
                                              UtilView.messageWarning(
                                                  "Tarea en proceso");
                                            }
                                          },
                                          child: Text(
                                            provider.listTask[i].observacion ==
                                                    "-"
                                                ? "Pendiente"
                                                : provider
                                                    .listTask[i].observacion,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Icon(provider.listTask[i].observacion ==
                                                "-"
                                            ? Icons.assignment_ind
                                            : provider.listTask[i].estado
                                                ? Icons.check_sharp
                                                : Icons.error)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Flexible(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 9),
                                child: Text(
                                    "Inicio: ${UtilView.convertDateToString(provider.listTask[i].inicio)}",
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                              )),
                              Flexible(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 9),
                                child: Text(
                                    "Finalización: ${UtilView.convertDateToString(provider.listTask[i].fin)}",
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                              )),
                              const Divider(color: Colors.black),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: InkWell(
                                            onTap: () {
                                              dialogComentario(context);
                                            },
                                            child: const Icon(Icons.cancel,
                                                color: Colors.red))),
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: InkWell(
                                            onTap: () {
                                              dialogComentario(context);
                                            },
                                            child: Icon(Icons.warning_rounded,
                                                color: Colors.yellow[700]))),
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: InkWell(
                                            onTap: () {
                                              dialogComentario(context);
                                            },
                                            child: const Icon(Icons.check,
                                                color: Colors.green)))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
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
