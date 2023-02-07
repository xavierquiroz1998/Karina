import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis_karina/provider/task_provider.dart';
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
      body: WhiteCard(
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
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  child: Padding(
                                padding: const EdgeInsets.all(9),
                                child: Text(provider.listTask[i].observacion,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(fontSize: 15)),
                              )),
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: InkWell(
                                    onTap: () {}, child: const Icon(Icons.add)),
                              )
                            ],
                          ),
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
                                        onTap: () {},
                                        child: const Icon(Icons.cancel,
                                            color: Colors.red))),
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: InkWell(
                                        onTap: () {},
                                        child: Icon(Icons.warning_rounded,
                                            color: Colors.yellow[700]))),
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: InkWell(
                                        onTap: () {},
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
    );
  }
}
