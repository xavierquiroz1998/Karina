import 'package:tesis_karina/entity/enfermedad.dart';
import 'package:tesis_karina/entity/usuario.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SolicitudApi {
  static String baseUrl = "http://localhost:8000/api";

  // BLOQUE DE USUARIOS Y PERSONAS INCIO ---------------------------------------------------------------------------------------------------------

  Future<Usuario?> getApiLogin(String usuario, String pass) async {
    var url = Uri.parse("$baseUrl/usuarios?usuario=$usuario&clave=$pass");

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return utf8.decode(respuesta.bodyBytes) != ""
            ? Usuario.fromJson(utf8.decode(respuesta.bodyBytes))
            : null;
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<List<Usuario>> getApiUsuario() async {
    var url = Uri.parse("$baseUrl/usuarios");
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseJsonToListUsuario(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<Usuario> parseJsonToListUsuario(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Usuario>((json) => Usuario.fromMap(json)).toList();
  }

  // BLOQUE DE USUARIOS Y PERSONAS FIN ---------------------------------------------------------------------------------------------------------

  // BLOQUE DE ENFERMEDADES INCIO ---------------------------------------------------------------------------------------------------------

  Future<List<Enfermedad>> getApiEnfermedades() async {
    var url = Uri.parse("$baseUrl/enfermedades");

    print(url.toString());

    try {
      final respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseJsonToListEnfermedad(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<Enfermedad> parseJsonToListEnfermedad(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Enfermedad>((json) => Enfermedad.fromMap(json)).toList();
  }
// BLOQUE DE ENFERMEDADES FIN ---------------------------------------------------------------------------------------------------------

}
