import 'package:flutter/material.dart';
import 'package:tesis_karina/entity/usuario.dart';

class UserFormProvider extends ChangeNotifier {
  Usuario? user;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  copyUserWith({
    String? rol,
    bool? estado,
    String? nombre,
    String? correo,
    String? uid,
    String? img,
  }) {
    user = Usuario(
      rol: rol ?? user!.rol,
      estado: estado ?? user!.estado,
      correo: correo ?? user!.correo,
      idusuarios: uid ?? user!.idusuarios,
      img: img ?? user!.img,
      clave: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    notifyListeners();
  }

  bool _validForm() {
    return formKey.currentState!.validate();
  }
}
