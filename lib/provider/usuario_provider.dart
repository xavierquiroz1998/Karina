import 'package:flutter/material.dart';
import 'package:tesis_karina/api/solicitud_api.dart';
import 'package:tesis_karina/entity/personas.dart';
import 'package:tesis_karina/entity/usuario.dart';
import 'package:tesis_karina/utils/util_view.dart';

class UsuarioProvider extends ChangeNotifier {
  List<Usuario> listUsuario = [];
  List<Persona> listPersona = [];
  final _api = SolicitudApi();
  Usuario user = Usuario(
      idusuarios: "",
      correo: "",
      rol: "",
      estado: true,
      clave: "",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now());
  Persona persona = Persona(
      idpersonas: "",
      cedula: "",
      nombre: "",
      apellido: "",
      direccion: "",
      celular: "",
      nacimiento: DateTime.now(),
      estado: true,
      idUsuario: "");
  //usuario
  final txtUsuario = TextEditingController();
  final txtClave = TextEditingController();
  String rol = "Jornaleros";
  //PERSONA

  final txtNombre = TextEditingController();
  final txtApellido = TextEditingController();
  final txtDireccion = TextEditingController();
  final txtCelular = TextEditingController();
  final txtEmail = TextEditingController();
  final txtCedula = TextEditingController();
  final txtFecha = TextEditingController();

  List<String> listRol = ["Admin", "Jornaleros", "Jefe de cuadrilla"];

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String isImg = "";
  String idPersona = "";
  bool estado = false;

  getListInt() async {
    final resp = await _api.getApiUsuarios();
    listUsuario = resp;
    notifyListeners();
  }

  getListIntP() async {
    final resp = await _api.getApiPersonas();
    listPersona = resp;
    notifyListeners();
  }

  getUsuarioLogin(String x, String y) async {
    final resp = await _api.getApiLogin(x, y);
    return resp;
  }

  newObjeto(Usuario e) async {
    final resp = await _api.postApiUsuario(e);

    newPersonaObjeto(Persona(
        idpersonas: UtilView.numberRandonUid(),
        cedula: txtCedula.text,
        nombre: txtNombre.text,
        apellido: txtApellido.text,
        direccion: txtDireccion.text,
        celular: txtCelular.text,
        nacimiento: DateTime.now(),
        estado: true,
        idUsuario: e.idusuarios));
    listUsuario.add(e);
    print(resp);
    notifyListeners();
  }

  newPersonaObjeto(Persona e) async {
    final resp = await _api.postApiPersonas(e);
    print(resp);
  }

  updateObjeto() async {
    user.correo = txtEmail.text;
    user.clave = txtClave.text;
    final resp = await _api.putApiUsuario(user);

    persona.nombre = txtNombre.text;
    persona.apellido = txtApellido.text;
    persona.direccion = txtDireccion.text;

    final resp2 = await _api.putApiPersonas(persona);
    try {
      this.listUsuario = this.listUsuario.map((e) {
        if (user.idusuarios != e.idusuarios) return e;
        e.correo = user.correo;
        e.clave = user.clave;
        return e;
      }).toList();
      notifyListeners();
      return true;
    } catch (e) {
      throw 'Error al actualizar el usuario';
    }
  }

  singleUpdateObjeto(Usuario usuario) async {
    if (usuario.idusuarios == "") {
      final resp = await _api.putApiUsuario(usuario);
      UtilView.messageAccess(resp ? "EXITO" : "ERROR", Colors.green);
    } else {
      isImg = usuario.img;
    }
  }

  deleteObjeto(Usuario e) async {
    final resp = await _api.deleteApiUsuario(e.idusuarios);
    print(resp);
    listUsuario.remove(e);
    notifyListeners();
  }

  Future<Usuario?> getUserById(int idusuarios) async {
    final usuario = await _api.getApiUsuario(idusuarios);
    return usuario;
  }

  Future<Persona?> getPersonById(String idusuarios) async {
    final usuario = await _api.getApiPersona(idusuarios);
    persona = usuario!;
    idPersona = usuario.idpersonas;
    return usuario;
  }
}
