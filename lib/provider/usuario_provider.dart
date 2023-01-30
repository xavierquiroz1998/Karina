import 'package:flutter/material.dart';
import 'package:tesis_karina/api/solicitud_api.dart';
import 'package:tesis_karina/entity/usuario.dart';

class UsuarioProvider extends ChangeNotifier {
  List<Usuario> listUsuario = [];
  final _api = SolicitudApi();

  final txtNombre = TextEditingController();
  final txtApellido = TextEditingController();
  final txtDireccion = TextEditingController();
  final txtCelular = TextEditingController();
  final txtEmail = TextEditingController();
  final txtCedula = TextEditingController();
  final txtFecha = TextEditingController();

  getListInt() async {
    final resp = await _api.getApiUsuarios();
    listUsuario = resp;
    notifyListeners();
  }

  getUsuarioLogin(String x, String y) async {
    final resp = await _api.getApiLogin(x, y);
    return resp;
  }

  newObjeto(Usuario e) async {
    final resp = await _api.postApiUsuario(e);
    listUsuario.add(e);
    print(resp);
    notifyListeners();
  }

  updateObjeto(Usuario e) async {
    final resp = await _api.putApiUsuario(e);
    try {
      listUsuario = listUsuario.map((en) {
        if (en.uid != e.uid) return e;
        e.nombre = e.nombre;
        return e;
      }).toList();
      notifyListeners();
      return true;
    } catch (e) {
      throw 'Error al actualizar el usuario';
    }
  }

  deleteObjeto(Usuario e) async {
    final resp = await _api.deleteApiUsuario(e.uid);
    print(resp);
    listUsuario.remove(e);
    notifyListeners();
  }

  Future<Usuario?> getUserById(int uid) async {
    final usuario = await _api.getApiUsuario(uid);
    return usuario;
  }
}
