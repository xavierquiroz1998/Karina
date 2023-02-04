import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis_karina/entity/enfermedad.dart';
import 'package:tesis_karina/provider/enfermedad_provider.dart';
import 'package:tesis_karina/services/notifications_service.dart';
import 'package:tesis_karina/style/custom/custom_input.dart';
import 'package:tesis_karina/style/custom/custom_labels.dart';
import 'package:tesis_karina/utils/util_view.dart';
import 'package:tesis_karina/widgets/custom_outlined_button.dart';

class EnfermedadModals extends StatefulWidget {
  final Enfermedad? enfermedad;

  const EnfermedadModals({Key? key, this.enfermedad}) : super(key: key);

  @override
  _EnfermedadModalsState createState() => _EnfermedadModalsState();
}

class _EnfermedadModalsState extends State<EnfermedadModals> {
  String nombre = '';
  String? id;
  String medida = '';

  @override
  void initState() {
    super.initState();
    id = widget.enfermedad?.uid;
    nombre = widget.enfermedad?.nombre ?? '';
    medida = widget.enfermedad?.grado ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final enfermedadProvider = Provider.of<EnfermedadProvider>(context);
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 280,
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
            const SizedBox(
              height: 20,
            ),
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
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Grado:',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                      onTap: () {
                        setState(() {
                          medida = "Medio";
                        });
                      },
                      child: const Icon(Icons.emoji_emotions,
                          color: Colors.amber)),
                  const SizedBox(width: 10),
                  InkWell(
                      onTap: () {
                        setState(() {
                          medida = "Alta";
                        });
                      },
                      child:
                          const Icon(Icons.warning_rounded, color: Colors.red)),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: Text(
                      "Seleccionado: $medida",
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: CustomOutlinedButton(
                  onPressed: () async {
                    try {
                      if (id == null) {
                        await enfermedadProvider.newObjeto(Enfermedad(
                            uid: UtilView.numberRandonUid(),
                            nombre: nombre,
                            grado: medida,
                            observacion: "",
                            estado: 1));
                        NotificationsService.showSnackbar('$nombre creado!');
                      } else {
                        await enfermedadProvider.updateObjeto(Enfermedad(
                            uid: id!,
                            nombre: nombre,
                            grado: medida,
                            observacion: "",
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
