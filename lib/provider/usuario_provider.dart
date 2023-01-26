import 'package:flutter/material.dart';
import 'package:tesis_karina/entity/usuario.dart';

class UsuarioProvider extends ChangeNotifier {
  List<Usuario> listUsuario = [];
  getListInt() async {
    //final resp = await _api.getProductPaginado(empresa, cantidad, limit);
    notifyListeners();
  }
}
