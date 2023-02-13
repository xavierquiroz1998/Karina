import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tesis_karina/provider/seguimiento_provider.dart';
import 'package:tesis_karina/style/custom/custom_labels.dart';
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
    final provider = Provider.of<SeguimientoProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Ingresar novedad')),
      body: ListView(
        children: [
          WhiteCard(
              title: "Cultivo seleccionado",
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
                          child: InputForm(
                        controller: provider.txtPlagas,
                        hint: "",
                        icon: Icons.assignment,
                        length: 200,
                        textInputType: TextInputType.number,
                      )),
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
                          /*  FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['jpg', 'png', 'jpeg'],
                          );

                          if (result != null) {
                            provider.imgBs4 = "";
                            Navigator.of(context).pop();
                          } else {
                            //Cancelar la busqueda de la imagen
                          } */
                        },
                        elevation: 0,
                        backgroundColor: Colors.indigo,
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
                  onTap: () {},
                  child: const Tooltip(
                      message: "Guardar", child: Icon(Icons.save))))
        ],
      ),
    );
  }
}
