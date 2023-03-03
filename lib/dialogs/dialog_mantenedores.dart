import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis_karina/entity/objeto_view.dart';
import 'package:tesis_karina/provider/reporte_provider.dart';

Future showDialogViewMantenedores(BuildContext context) async {
  List<ObjetoView> listString = [
    ObjetoView(name: "Enfermedad", select: false),
    ObjetoView(name: "Insumos", select: false),
    ObjetoView(name: "Maquinaria", select: false),
    ObjetoView(name: "Terrenos", select: false),
    ObjetoView(name: "Finca", select: false),
    ObjetoView(name: "Personal", select: false),
  ];

  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Lista de mantenedores"),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              content: SizedBox(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: listString.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 0),
                      hoverColor: Colors.grey,
                      selectedColor: Colors.green[600],
                      leading: Checkbox(
                        value: listString[index].select,
                        onChanged: (value) {
                          setState(() {
                            listString[index].select = value!;
                          });
                        },
                      ),
                      title: Text(listString[index].name),
                      trailing: const Icon(Icons.addchart_rounded),
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                    style: ButtonStyle(backgroundColor:
                        MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return Colors.black12;
                      }
                      return Colors.transparent;
                    })),
                    onPressed: () async {
                      Provider.of<ReporteProvider>(context, listen: false)
                          .generateMantenimiento(listString, context);
                    },
                    child:
                        const Text('Aceptar', style: TextStyle(fontSize: 14))),
                TextButton(
                    style: ButtonStyle(backgroundColor:
                        MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return Colors.black12;
                      }
                      return Colors.transparent;
                    })),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child:
                        const Text('Cancelar', style: TextStyle(fontSize: 14))),
              ],
            );
          },
        );
      });
}

TextStyle buildStyle() {
  return const TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
}
