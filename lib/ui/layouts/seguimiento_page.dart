import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis_karina/provider/historial_provider.dart';
import 'package:tesis_karina/provider/cultivo_task_provider.dart';
import 'package:tesis_karina/style/colors/custom_colors.dart';
import 'package:tesis_karina/widgets/white_card.dart';

class SeguiminentoPage extends StatefulWidget {
  const SeguiminentoPage({Key? key}) : super(key: key);

  @override
  State<SeguiminentoPage> createState() => _SeguiminentoPageState();
}

class _SeguiminentoPageState extends State<SeguiminentoPage> {
  @override
  void initState() {
    Provider.of<CultivoTaskProvider>(context, listen: false).getIntList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CultivoTaskProvider>(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text('Seguimiento'),
          backgroundColor: CustomColors.customDefaut),
      body: WhiteCard(
        title: 'Lista de Finca',
        acciones: const Text(''),
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 220,
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 20,
              runSpacing: 20,
              children: [
                for (var item in provider.listFinca) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: InkWell(
                      onTap: () {
                        //provider.getListTerreno(item.idfinca);
                        Provider.of<HistorialProvider>(context, listen: false)
                            .getListTerreno(item.idfinca);
                        Navigator.pushNamed(
                            context, '/dashboard/controlSeguimiento2');
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: item.referencia == "1"
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
                                item.nombre.toUpperCase(),
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ))
                        ],
                      ),
                    ),
                  )
                  /*      Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<Terreno>(
                        isExpanded: true,
                        customButton: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.red),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.discount_outlined,
                                    size: 80, color: Colors.white),
                              ),
                            ),
                            Container(
                                padding: const EdgeInsets.all(8.0),
                                constraints:
                                    const BoxConstraints(maxWidth: 200),
                                child: Text(
                                  item.observacion,
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ))
                          ],
                        ),
                        items: [
                          DropdownMenuItem<Terreno>(
                              value: item,
                              child: buildItem("Ingresar Novedad")),
                          /*   DropdownMenuItem<Terreno>(
                              value: item,
                              child: buildItem("Consultar historial")) */
                        ],
                        onChanged: (value) {
                          print(value);
                          Navigator.pushNamed(
                              context, '/dashboard/controlObservaciones');
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                        iconSize: 8,
                        itemHeight: 40,
                        itemPadding: const EdgeInsets.only(left: 14, right: 14),
                        dropdownMaxHeight: 200,
                        dropdownWidth: 200,
                        dropdownPadding: null,
                        dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.blueGrey),
                        dropdownElevation: 8,
                        scrollbarRadius: const Radius.circular(40),
                        scrollbarThickness: 6,
                        scrollbarAlwaysShow: true,
                        offset: const Offset(-20, 0),
                      ),
                    ),
                  )
              */
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildItem(String item) {
    return Row(
      children: [
        const Icon(
          Icons.assignment_turned_in_outlined,
          color: Colors.white,
          size: 18,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          item,
          maxLines: 2,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
