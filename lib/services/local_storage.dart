import 'package:shared_preferences/shared_preferences.dart';
import 'package:tesis_karina/entity/usuario.dart';

class LocalStorage {
  static late SharedPreferences prefs;

  static Future<void> configurePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future createCache(Usuario usuario) async {
    prefs.setString('usuario', "");
    // print("1");
  }

  static Future readCache(String usuario) async {
    var cache = prefs.getString(usuario);
    // print("2");
    return cache;
  }

  static Future removeCache(String usuario) async {
    prefs.remove(usuario);
  }

  //METODOS ADICIONALES 

  static Future createCacheSingle(String value, String referencia) async {
    prefs.setString(referencia, value);
    // print("1.5");
  }

  static Future createCacheSinglebool(bool value, String referencia) async {
    prefs.setBool(referencia, value);
    // print("1.6");
  }
}
