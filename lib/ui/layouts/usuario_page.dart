// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis_karina/entity/usuario.dart';
import 'package:tesis_karina/provider/user_form_provider.dart';
import 'package:tesis_karina/provider/usuario_provider.dart';
import 'package:tesis_karina/services/notifications_service.dart';
import 'package:tesis_karina/style/custom/custom_input.dart';
import 'package:tesis_karina/style/custom/custom_labels.dart';
import 'package:email_validator/email_validator.dart';
import 'package:tesis_karina/widgets/white_card.dart';

class UsuarioPage extends StatefulWidget {
  const UsuarioPage({Key? key}) : super(key: key);

  @override
  _UsuarioPageState createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
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
        title: const Text('Usuario'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [_UsuarioPageBody()],
        ),
      ),
    );
  }
}

class _UsuarioPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AvatarContainer(),
        // Formulario de actualización
        const _UsuarioPageForm(),
      ],
    );
  }
}

class _UsuarioPageForm extends StatelessWidget {
  const _UsuarioPageForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userFormProvider = Provider.of<UserFormProvider>(context);
    final usuarioProvider = Provider.of<UsuarioProvider>(context);
    final user = userFormProvider.user!;

    return WhiteCard(
        title: 'Información general',
        acciones: const Text(''),
        child: Form(
          key: userFormProvider.formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              /*  TextFormField(
                initialValue: user.,
                decoration: CustomInputs.boxInputDecoration(
                    hint: 'Nombre del usuario',
                    label: 'Nombre',
                    icon: Icons.supervised_user_circle_outlined),
                onChanged: (value) =>
                    userFormProvider.copyUserWith(nombre: value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese un nombre.';
                  }
                  if (value.length < 2) {
                    return 'El nombre debe de ser de dos letras como mínimo.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20), */
              TextFormField(
                initialValue: user.correo,
                decoration: CustomInputs.boxInputDecoration(
                    hint: 'Correo del usuario',
                    label: 'Correo',
                    icon: Icons.mark_email_read_outlined),
                onChanged: (value) =>
                    userFormProvider.copyUserWith(correo: value),
                validator: (value) {
                  if (!EmailValidator.validate(value ?? '')) {
                    return 'Email no válido';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 120),
                child: ElevatedButton(
                    onPressed: () async {
                      final saved = await usuarioProvider
                          .updateObjeto(userFormProvider.user!);
                      if (saved) {
                        NotificationsService.showSnackbar(
                            'Usuario actualizado');
                        Navigator.of(context).pop();
                      } else {
                        NotificationsService.showSnackbarError(
                            'No se pudo guardar');
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.indigo),
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.save_outlined, size: 20),
                        Text(
                          'Guardar',
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

class _AvatarContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userFormProvider = Provider.of<UserFormProvider>(context);
    final user = userFormProvider.user!;

    final image = (user.img == "")
        ? const Image(image: AssetImage('assets/no-image.jpg'))
        : FadeInImage.assetNetwork(
            placeholder: 'assets/loader.gif', image: user.img);

    return WhiteCard(
      width: 250,
      acciones: const Text(''),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Perfil',
              style: CustomLabels.h2,
            ),
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
                            /*  FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['jpg', 'png', 'jpeg'],
                            );

                            if (result != null) {
                              NotificationsService.showBusyIndicator(context);

                              /*    final newUser =
                                  await userFormProvider.uploadImage(
                                      '/uploads/usuarios/${user.uid}',
                                      result.files.first.bytes!); */

/*                               Provider.of<UsersProvider>(context, listen: false)
                                  .refreshUser(newUser); */

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
