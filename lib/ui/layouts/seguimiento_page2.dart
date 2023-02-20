import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis_karina/provider/seguimiento_provider.dart';
import 'package:tesis_karina/widgets/white_card.dart';

class SeguiminentoPage2 extends StatefulWidget {
  const SeguiminentoPage2({Key? key}) : super(key: key);

  @override
  State<SeguiminentoPage2> createState() => _SeguiminentoPage2State();
}

class _SeguiminentoPage2State extends State<SeguiminentoPage2> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SeguimientoProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Seguimiento')),
      body: WhiteCard(
        title: 'Lista de terrenos ${provider.selectFinca}',
        acciones: const Text(''),
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 220,
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 20,
              runSpacing: 20,
              children: [
                provider.listTerreno.isEmpty
                    ? const Text('NO HAY REGISTRADO NINGUNA FINCA',
                        style: TextStyle(color: Colors.grey, fontSize: 16))
                    : const Text(''),
                for (var item in provider.listTerreno) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: InkWell(
                      onTap: () {
                        provider.selectTerreno = item;
                        Navigator.pushNamed(
                            context, '/dashboard/controlObservaciones');
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: item.disponibilidad == "1"
                                    ? Colors.green[700]
                                    : Colors.blueGrey),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.home_filled,
                                size: 80,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.all(8.0),
                              constraints: const BoxConstraints(maxWidth: 200),
                              child: Text(
                                item.observacion.toUpperCase(),
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ))
                        ],
                      ),
                    ),
                  )
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
