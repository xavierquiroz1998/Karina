import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis_karina/entity/enfermedad.dart';
import 'package:tesis_karina/provider/enfermedad_provider.dart';
import 'package:tesis_karina/services/notifications_service.dart';
import 'package:tesis_karina/style/custom/custom_input.dart';
import 'package:tesis_karina/style/custom/custom_labels.dart';
import 'package:tesis_karina/utils/util_view.dart';
import 'package:tesis_karina/widgets/camara.dart';
import 'package:tesis_karina/widgets/camara2.dart';
import 'package:tesis_karina/widgets/custom_outlined_button.dart';

class EnfermedadModals extends StatefulWidget {
  final Enfermedades? enfermedad;

  const EnfermedadModals({Key? key, this.enfermedad}) : super(key: key);

  @override
  _EnfermedadModalsState createState() => _EnfermedadModalsState();
}

class _EnfermedadModalsState extends State<EnfermedadModals> {
  String nombre = '';
  String? id;
  String observacion = '';

  @override
  void initState() {
    super.initState();
    id = widget.enfermedad?.idenfermedades;
    nombre = widget.enfermedad?.nombre ?? '';
    observacion = widget.enfermedad?.observacion ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final enfermedadProvider = Provider.of<EnfermedadProvider>(context);
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 400,
        decoration: builBoxDecoration(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15, top: 15),
                  child: Text(
                    widget.enfermedad?.nombre ?? 'Nueva Enfermedad',
                    style: CustomLabels.h1.copyWith(color: Colors.white),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ))
              ],
            ),
            Divider(
              color: Colors.white.withOpacity(0.3),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                initialValue: widget.enfermedad?.nombre ?? '',
                onChanged: (value) => nombre = value,
                decoration: CustomInputs.boxInputDecoration(
                    hint: 'Nombre de la enfermedad',
                    label: 'Enfermedad',
                    icon: Icons.new_releases_outlined),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: DropdownButtonFormField<String>(
                      value: enfermedadProvider.isSelectE,
                      onChanged: (value) {
                        enfermedadProvider.isSelectE = value!;
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
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              )),
                        );
                      }).toList(),
                      decoration: CustomInputs.boxInputDecorationDialogSearch(
                          label: 'Tipo de enfermedad',
                          hint: 'Tipo de enfermedad'),
                    ),
                  ),
                ),
                InkWell(
                  child: const Tooltip(
                      message: "Ingresar imagen",
                      child: Icon(
                        Icons.photo_camera_rounded,
                        color: Colors.white,
                      )),
                  onTap: () async {
                    final cameras = await availableCameras();
                    // Get a specific camera from the list of available cameras.
                    final firstCamera = cameras.first;

                    // ignore: use_build_context_synchronously
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            TakePictureScreen2(camera: firstCamera),
                      ),
                    );
                  },
                )
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: DropdownButtonFormField<String>(
                value: enfermedadProvider.isSelectP,
                onChanged: (value) {
                  enfermedadProvider.isSelectP = value!;
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
                              color: Colors.white,
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
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                initialValue: widget.enfermedad?.observacion ?? '',
                onChanged: (value) => observacion = value,
                decoration: CustomInputs.boxInputDecoration(
                    hint: 'Observacion',
                    label: 'Ingrese Observacion',
                    icon: Icons.new_releases_outlined),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: CustomOutlinedButton(
                  onPressed: () async {
                    try {
                      if (id == null) {
                        await enfermedadProvider.newObjeto(Enfermedades(
                            idenfermedades: UtilView.numberRandonUid(),
                            nombre: nombre,
                            observacion: observacion,
                            enfermedadTipoId: enfermedadProvider.isSelectE
                                .split("/")[0]
                                .trim(),
                            plagasTipoId: enfermedadProvider.isSelectP
                                .split("/")[0]
                                .trim(),
                            fotografia: "-",
                            tratamiento: "-",
                            especificaciones: "-",
                            estado: 1));
                        NotificationsService.showSnackbar('$nombre creado!');
                      } else {
                        await enfermedadProvider.updateObjeto(Enfermedades(
                            idenfermedades: id!,
                            nombre: nombre,
                            observacion: observacion,
                            enfermedadTipoId: enfermedadProvider.isSelectE
                                .split("/")[0]
                                .trim(),
                            plagasTipoId: enfermedadProvider.isSelectP
                                .split("/")[0]
                                .trim(),
                            fotografia: widget.enfermedad!.fotografia,
                            tratamiento: widget.enfermedad!.tratamiento,
                            especificaciones:
                                widget.enfermedad!.especificaciones,
                            estado: 1));
                        NotificationsService.showSnackbar(
                            '$nombre actualizado!');
                      }
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    } catch (e) {
                      //Navigator.of(context).pop();
                      NotificationsService.showSnackbarError(
                          'Error no se pudo completar la tarea');
                    }
                  },
                  text: 'Guardar'),
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration builBoxDecoration() => const BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      color: Color(0xff0F2041),
      boxShadow: [BoxShadow(color: Colors.black26)]);
}
