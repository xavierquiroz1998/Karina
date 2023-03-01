// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis_karina/entity/enfermedad.dart';
import 'package:tesis_karina/entity/usuario.dart';
import 'package:tesis_karina/provider/enfermedad_provider.dart';
import 'package:tesis_karina/services/notifications_service.dart';
import 'package:tesis_karina/style/colors/custom_colors.dart';
import 'package:tesis_karina/style/custom/custom_input.dart';
import 'package:tesis_karina/style/custom/custom_labels.dart';
import 'package:tesis_karina/utils/util_view.dart';
import 'package:tesis_karina/widgets/camara2.dart';
import 'package:tesis_karina/widgets/white_card.dart';

class EnfermedadPage extends StatefulWidget {
  const EnfermedadPage({Key? key}) : super(key: key);

  @override
  _EnfermedadPageState createState() => _EnfermedadPageState();
}

class _EnfermedadPageState extends State<EnfermedadPage> {
  Usuario? user;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        title: const Text('Enfermedad'),
        backgroundColor: CustomColors.customDefaut,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [_EnfermedadPageBody()],
        ),
      ),
    );
  }
}

class _EnfermedadPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ImagenContainer(),
        // Formulario de actualización
        const _EnfermedadPageForm(),
      ],
    );
  }
}

class _EnfermedadPageForm extends StatelessWidget {
  const _EnfermedadPageForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final enfermedadProvider = Provider.of<EnfermedadProvider>(context);
    return WhiteCard(
        title: 'Información general',
        acciones: const Text(''),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              TextFormField(
                controller: enfermedadProvider.txtNombre,
                decoration: CustomInputs.boxInputDecoration(
                    hint: 'Nombre de la enfermedad',
                    label: 'Enfermedad',
                    icon: Icons.new_releases_outlined),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo requerido*';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 40,
                child: DropdownButtonFormField<String>(
                  value: enfermedadProvider.isSelectE,
                  onChanged: (value) {
                    enfermedadProvider.isSelectE = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo requerido*';
                    }
                    return null;
                  },
                  dropdownColor: Colors.blueGrey,
                  items: enfermedadProvider.tiposEnfermedad.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          )),
                    );
                  }).toList(),
                  decoration: CustomInputs.boxInputDecorationDialogSearch(
                      label: 'Tipo de enfermedad', hint: 'Tipo de enfermedad'),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 40,
                child: DropdownButtonFormField<String>(
                  value: enfermedadProvider.isSelectP,
                  onChanged: (value) {
                    enfermedadProvider.isSelectP = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo requerido*';
                    }
                    return null;
                  },
                  dropdownColor: Colors.blueGrey,
                  items: enfermedadProvider.tiposPlagas.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          )),
                    );
                  }).toList(),
                  decoration: CustomInputs.boxInputDecorationDialogSearch(
                      label: 'Tipo de plagas', hint: 'Tipo de plagas'),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                  controller: enfermedadProvider.txtTratamiento,
                  decoration: CustomInputs.boxInputDecoration(
                      hint: 'Tratamiento',
                      label: 'Ingrese Tratamiento',
                      icon: Icons.new_releases_outlined)),
              const SizedBox(height: 10),
              TextFormField(
                  controller: enfermedadProvider.txtObservaciones,
                  decoration: CustomInputs.boxInputDecoration(
                      hint: 'Observacion',
                      label: 'Ingrese Observacion',
                      icon: Icons.new_releases_outlined)),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 120),
                child: ElevatedButton(
                    onPressed: () async {
                      if (enfermedadProvider.isTipo) {
                        await enfermedadProvider.newObjeto();
                        NotificationsService.showSnackbar(
                            '${enfermedadProvider.txtNombre.text} creado!');
                      } else {
                        await enfermedadProvider.updateObjeto(Enfermedades(
                            idenfermedades: enfermedadProvider
                                .isSelectEnfermedad.idenfermedades,
                            nombre: enfermedadProvider.txtNombre.text,
                            observacion:
                                enfermedadProvider.txtObservaciones.text,
                            enfermedadTipoId: enfermedadProvider.isSelectE
                                .split("/")[0]
                                .trim(),
                            plagasTipoId: enfermedadProvider.isSelectP
                                .split("/")[0]
                                .trim(),
                            fotografia: enfermedadProvider.imgBs4,
                            tratamiento: enfermedadProvider.txtTratamiento.text,
                            especificaciones:
                                enfermedadProvider.txtEspecificaciones.text,
                            estado: 1));
                      }
                      Navigator.pushNamed(context, '/dashboard/mantenimientos');
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.indigo),
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.save_outlined, size: 20),
                        Text(
                          enfermedadProvider.isTipo
                              ? " Guardar"
                              : " Actualizar",
                          textAlign: TextAlign.center,
                        )
                      ],
                    )),
              )
            ],
          ),
        ));
  }
}

class _ImagenContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final enfermedadProvider = Provider.of<EnfermedadProvider>(context);

    final image = (enfermedadProvider.imgBs4 == "")
        ? const Image(image: AssetImage('assets/no-image.jpg'))
        : Image.file(File(enfermedadProvider.fileBs4));

    return WhiteCard(
      width: 250,
      acciones: const Text(''),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Fotografia', style: CustomLabels.h2),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                width: 150,
                height: 160,
                child: Stack(
                  children: [
                    ClipOval(child: image),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Colors.white, width: 5)),
                        child: FloatingActionButton(
                          onPressed: () async {
                            final cameras = await availableCameras();
                            // Get a specific camera from the list of available cameras.
                            final firstCamera = cameras.first;

                            // ignore: use_build_context_synchronously
                            await Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) =>
                                    TakePictureScreen2(camera: firstCamera),
                              ),
                            );
                            /*  FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['jpg', 'png', 'jpeg'],
                            );

                            if (result != null) {
                              NotificationsService.showBusyIndicator(context);
                              enfermedadProvider.fotografia = base64Encode(
                                  result.files[0].bytes as List<int>);

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
                        ),
                      ),
                    )
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            /*  Text(
              user.nombre,
              style: TextStyle(fontWeight: FontWeight.bold),
            ), */
          ],
        ),
      ),
    );
  }
}
