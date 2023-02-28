import 'package:flutter/material.dart';
import 'package:tesis_karina/entity/personas.dart';
import 'package:tesis_karina/entity/usuario.dart';

class UserFormProvider extends ChangeNotifier {
  Usuario? user;
  Persona? person;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  copyUserWith({
    String? rol,
    bool? estado,
    String? nombre,
    String? correo,
    String? clave,
    String? uid,
    String? img,
  }) {
    user = Usuario(
      rol: rol ?? user!.rol,
      estado: estado ?? user!.estado,
      correo: correo ?? user!.correo,
      idusuarios: uid ?? user!.idusuarios,
      img: img ?? user!.img,
      clave: clave ?? user!.clave,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    notifyListeners();
  }

  copyUserWith2(
      {String? uid,
      bool? estado,
      String? cedula,
      String? nombre,
      String? apellido,
      String? direccion,
      String? uidUsuario,
      DateTime? nacimiento}) {
    person = Persona(
        idpersonas: uid ?? person!.idUsuario,
        cedula: cedula ?? person!.cedula,
        nombre: nombre ?? person!.nombre,
        apellido: apellido ?? person!.apellido,
        direccion: direccion ?? person!.direccion,
        celular: cedula ?? person!.celular,
        nacimiento: nacimiento ?? person!.nacimiento,
        estado: estado ?? person!.estado,
        idUsuario: uidUsuario ?? person!.idUsuario);
    notifyListeners();
  }

  bool _validForm() {
    return formKey.currentState!.validate();
  }
}
