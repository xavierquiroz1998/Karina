import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tesis_karina/entity/tipos_plagas.dart';
import 'package:tesis_karina/provider/cultivo_task_provider.dart';
import 'package:tesis_karina/provider/seguimiento3_provider.dart';
import 'package:tesis_karina/style/colors/custom_colors.dart';
import 'package:tesis_karina/style/custom/custom_input.dart';
import 'package:tesis_karina/style/custom/custom_labels.dart';
import 'package:tesis_karina/utils/util_view.dart';
import 'package:tesis_karina/widgets/camara.dart';
import 'package:tesis_karina/widgets/input_form.dart';
import 'package:tesis_karina/widgets/white_card.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class ObservacionPage extends StatefulWidget {
  const ObservacionPage({Key? key}) : super(key: key);

  @override
  State<ObservacionPage> createState() => _ObservacionPageState();
}

class _ObservacionPageState extends State<ObservacionPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Seguimiento3Provider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingresar novedad'),
        backgroundColor: CustomColors.customDefaut,
      ),
      body: ListView(
        children: [
          WhiteCard(
              title: "Observaciones sobre el terreno",
              // ignore: sort_child_properties_last
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: 100,
                          child: Text("Novedades", style: CustomLabels.h11)),
                      Expanded(
                          child: InputForm(
                        controller: provider.txtNovedad,
                        hint: "",
                        maxLines: 4,
                        icon: Icons.assignment,
                        length: 200,
                        textInputType: TextInputType.number,
                      )),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      SizedBox(
                          width: 100,
                          child: Text("Hay,Plagas?", style: CustomLabels.h11)),
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: DropdownButtonFormField<TiposPlagas>(
                            onChanged: (value) {
                              provider.selectTpPlaga = value!;
                            },
                            value: provider.selectTpPlaga,
                            dropdownColor: Colors.blueGrey,
                            items: provider.listTplaga.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      item.observacion,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    )),
                              );
                            }).toList(),
                            decoration:
                                CustomInputs.boxInputDecorationDialogSearch(
                                    label: 'Tipo de plagas',
                                    hint: 'Tipo de plagas'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        Text('Progreso del evolución', style: CustomLabels.h11),
                  ),
                  const Divider(thickness: 1),
                  FAProgressBar(
                    currentValue: provider.porcentajeProgreso,
                    maxValue: 100,
                    displayText: '%',
                    animatedDuration: const Duration(milliseconds: 1100),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        Text('Evaluación del cultivo', style: CustomLabels.h11),
                  ),
                  const Divider(thickness: 1),
                  RatingBar.builder(
                    initialRating: provider.valoracion,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      provider.valoracion = rating;
                    },
                  ),
                  const SizedBox(height: 15),
                  const Divider(thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            Text('Carga fotografica', style: CustomLabels.h11),
                      ),
                      FloatingActionButton(
                        onPressed: () async {
                          final cameras = await availableCameras();
                          // Get a specific camera from the list of available cameras.
                          final firstCamera = cameras.first;

                          // ignore: use_build_context_synchronously
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  TakePictureScreen(camera: firstCamera),
                            ),
                          );
                        },
                        elevation: 0,
                        backgroundColor: provider.imgBs4 == ""
                            ? Colors.indigo
                            : Colors.green[700],
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          size: 20,
                        ),
                      )
                    ],
                  )
                ],
              ),
              acciones: InkWell(
                  onTap: () {
                    provider.saveGuardarHist();
                    UtilView.messageAccess("Guardado exitoso", Colors.green);
                    Navigator.pushReplacementNamed(
                        context, '/dashboard/controlTareas');
                  },
                  child: const Tooltip(
                      message: "Guardar", child: Icon(Icons.save))))
        ],
      ),
    );
  }
}
