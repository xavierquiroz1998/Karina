import 'package:flutter/material.dart';
import 'package:tesis_karina/entity/usuario.dart';

class UserFormProvider extends ChangeNotifier {
  Usuario? user;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  copyUserWith({
    String? rol,
    String? estado,
    String? nombre,
    String? correo,
    int? uid,
    String? img,
  }) {
    user = Usuario(
      rol: rol ?? user!.rol,
      estado: estado ?? user!.estado,
      nombre: nombre ?? user!.nombre,
      correo: correo ?? user!.correo,
      uid: uid ?? user!.uid,
      img: img ?? user!.img,
    );
    notifyListeners();
  }

  bool _validForm() {
    return formKey.currentState!.validate();
  }
}
