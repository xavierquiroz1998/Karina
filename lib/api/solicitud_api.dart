import 'package:tesis_karina/entity/enfermedad.dart';
import 'package:tesis_karina/entity/finca.dart';
import 'package:tesis_karina/entity/insumo.dart';
import 'package:tesis_karina/entity/maquinaria.dart';
import 'package:tesis_karina/entity/terreno.dart';
import 'package:tesis_karina/entity/usuario.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SolicitudApi {
  static String baseUrl = "http://192.168.100.73:8000/api";

  // BLOQUE DE USUARIOS Y PERSONAS INCIO ---------------------------------------------------------------------------------------------------------

  Future<Usuario?> getApiLogin(String usuario, String pass) async {
    var url = Uri.parse("$baseUrl/usuarios/login/$usuario");
    final data = {"clave": pass, "correo": usuario};
    final bod = json.encode(data);
    try {
      http.Response respuesta = await http.post(url, body: bod);
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

  Future<List<Usuario>> getApiUsuarios() async {
    var url = Uri.parse("$baseUrl/usuarios");
    print(url.toString());
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

  Future<Usuario?> getApiUsuario(int uid) async {
    var url = Uri.parse("$baseUrl/usuarios/$uid");

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

  List<Usuario> parseJsonToListUsuario(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Usuario>((json) => Usuario.fromMap(json)).toList();
  }

  Future<bool> deleteApiUsuario(int uid) async {
    var url = Uri.parse("$baseUrl/usuarios/$uid");
    final respuesta = await http.delete(url,
        headers: {"Content-type": "application/json;charset=UTF-8"});

    try {
      if (respuesta.statusCode == 200) {
        return true;
        //return utf8.decode(respuesta.bodyBytes).contains('true');
      } else {
        throw Exception(respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('$e');
    }
  }

  Future<bool> putApiUsuario(Usuario datos) async {
    var url = Uri.parse("$baseUrl/usuarios/${datos.uid}");
    final respuesta = await http.put(url,
        body: datos.toJson(),
        headers: {"Content-type": "application/json;charset=UTF-8"});
    try {
      if (respuesta.statusCode == 200) {
        return true;
      } else {
        throw Exception(respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('$e');
    }
  }

  Future<bool> postApiUsuario(Usuario datos) async {
    var url = Uri.parse("$baseUrl/usuarios");
    final resquet = await http.post(url,
        body: datos.toJson(),
        headers: {"Content-type": "application/json;charset=UTF-8"});
    try {
      if (resquet.statusCode != 200) {
        throw Exception('${resquet.statusCode}');
      } else {
        return true;
      }
    } catch (e) {
      throw ('$e');
    }
  }

  // BLOQUE DE USUARIOS Y PERSONAS FIN ---------------------------------------------------------------------------------------------------------

  // BLOQUE DE ENFERMEDADES INCIO ---------------------------------------------------------------------------------------------------------

  Future<Enfermedad?> getApiEnfermedad(String uid) async {
    var url = Uri.parse("$baseUrl/enfermedades?id=$uid");

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return utf8.decode(respuesta.bodyBytes) != ""
            ? Enfermedad.fromJson(utf8.decode(respuesta.bodyBytes))
            : null;
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<List<Enfermedad>> getApiEnfermedades() async {
    var url = Uri.parse("$baseUrl/enfermedades");
    print(url.toString());

    try {
      var respuesta = await http.get(url);
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

  Future<bool> deleteApiEnfermedad(int uid) async {
    var url = Uri.parse("$baseUrl/enfermedades/$uid");
    final respuesta = await http.delete(url,
        headers: {"Content-type": "application/json;charset=UTF-8"});

    try {
      if (respuesta.statusCode == 200) {
        return true;
        //return utf8.decode(respuesta.bodyBytes).contains('true');
      } else {
        throw Exception(respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('$e');
    }
  }

  Future<bool> putApiEnfermedad(Enfermedad datos) async {
    var url = Uri.parse("$baseUrl/enfermedades/${datos.uid}");

    print(url.toString());

    final respuesta = await http.put(url,
        body: datos.toJson(),
        headers: {"Content-type": "application/json;charset=UTF-8"});
    try {
      if (respuesta.statusCode == 200) {
        return true;
      } else {
        throw Exception(respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('$e');
    }
  }

  Future<bool> postApiEnfermedad(Enfermedad datos) async {
    var url = Uri.parse("$baseUrl/enfermedades");
    var data = datos.toJson();

    final resquet = await http.post(url,
        body: data,
        headers: {"Content-type": "application/json;charset=UTF-8"});
    try {
      if (resquet.statusCode != 200) {
        throw Exception('${resquet.statusCode}');
      } else {
        return true;
      }
    } catch (e) {
      throw ('$e');
    }
  }

  // BLOQUE DE ENFERMEDADES FIN ---------------------------------------------------------------------------------------------------------

  // BLOQUE DE INSUMO INCIO ---------------------------------------------------------------------------------------------------------

  Future<Insumo?> getApiInsumo(String uid) async {
    var url = Uri.parse("$baseUrl/insumos?id=$uid");

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return utf8.decode(respuesta.bodyBytes) != ""
            ? Insumo.fromJson(utf8.decode(respuesta.bodyBytes))
            : null;
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<List<Insumo>> getApiInsumos() async {
    var url = Uri.parse("$baseUrl/insumos");
    print(url.toString());

    try {
      var respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseJsonToListInsumo(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<Insumo> parseJsonToListInsumo(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Insumo>((json) => Insumo.fromMap(json)).toList();
  }

  Future<bool> deleteApiInsumo(int uid) async {
    var url = Uri.parse("$baseUrl/insumos/$uid");
    final respuesta = await http.delete(url,
        headers: {"Content-type": "application/json;charset=UTF-8"});

    try {
      if (respuesta.statusCode == 200) {
        return true;
        //return utf8.decode(respuesta.bodyBytes).contains('true');
      } else {
        throw Exception(respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('$e');
    }
  }

  Future<bool> putApiInsumo(Insumo datos) async {
    var url = Uri.parse("$baseUrl/insumos/${datos.uid}");
    final respuesta = await http.put(url,
        body: datos.toJson(),
        headers: {"Content-type": "application/json;charset=UTF-8"});
    try {
      if (respuesta.statusCode == 200) {
        return true;
      } else {
        throw Exception(respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('$e');
    }
  }

  Future<bool> postApiInsumo(Insumo datos) async {
    var url = Uri.parse("$baseUrl/insumos");
    var data = datos.toJson();

    final resquet = await http.post(url,
        body: data,
        headers: {"Content-type": "application/json;charset=UTF-8"});

    try {
      if (resquet.statusCode != 200) {
        throw Exception('${resquet.statusCode}');
      } else {
        return true;
      }
    } catch (e) {
      throw ('$e');
    }
  }

  // BLOQUE DE IINSUMO FIN ---------------------------------------------------------------------------------------------------------

  // BLOQUE DE MAQUUINARIA INCIO ---------------------------------------------------------------------------------------------------------

  Future<Maquinaria?> getApiMaquinaria(String uid) async {
    var url = Uri.parse("$baseUrl/maquinarias?id=$uid");

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return utf8.decode(respuesta.bodyBytes) != ""
            ? Maquinaria.fromJson(utf8.decode(respuesta.bodyBytes))
            : null;
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<List<Maquinaria>> getApiMaquinarias() async {
    var url = Uri.parse("$baseUrl/maquinarias");
    print(url.toString());

    try {
      var respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseJsonToListMaquinaria(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<Maquinaria> parseJsonToListMaquinaria(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Maquinaria>((json) => Maquinaria.fromMap(json)).toList();
  }

  Future<bool> deleteApiMaquinaria(int uid) async {
    var url = Uri.parse("$baseUrl/maquinarias/$uid");
    final respuesta = await http.delete(url,
        headers: {"Content-type": "application/json;charset=UTF-8"});

    try {
      if (respuesta.statusCode == 200) {
        return true;
        //return utf8.decode(respuesta.bodyBytes).contains('true');
      } else {
        throw Exception(respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('$e');
    }
  }

  Future<bool> putApiMaquinaria(Maquinaria datos) async {
    var url = Uri.parse("$baseUrl/maquinarias/${datos.uid}");
    final respuesta = await http.put(url,
        body: datos.toJson(),
        headers: {"Content-type": "application/json;charset=UTF-8"});
    try {
      if (respuesta.statusCode == 200) {
        return true;
      } else {
        throw Exception(respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('$e');
    }
  }

  Future<bool> postApiMaquinaria(Maquinaria datos) async {
    var url = Uri.parse("$baseUrl/maquinarias");
    final resquet = await http.post(url,
        body: datos.toJson(),
        headers: {"Content-type": "application/json;charset=UTF-8"});
    try {
      if (resquet.statusCode != 200) {
        throw Exception('${resquet.statusCode}');
      } else {
        return true;
      }
    } catch (e) {
      throw ('$e');
    }
  }
  // BLOQUE DE MAQUINARIA FIN ---------------------------------------------------------------------------------------------------------

  // BLOQUE DE TERRENO INCIO ---------------------------------------------------------------------------------------------------------

  Future<Terreno?> getApiTerreno(String uid) async {
    var url = Uri.parse("$baseUrl/terrenos/$uid");

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return utf8.decode(respuesta.bodyBytes) != ""
            ? Terreno.fromJson(utf8.decode(respuesta.bodyBytes))
            : null;
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<List<Terreno>> getApiTerrenos() async {
    var url = Uri.parse("$baseUrl/terrenos");
    print(url.toString());

    try {
      var respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseJsonToListTerreno(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<Terreno> parseJsonToListTerreno(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Terreno>((json) => Terreno.fromMap(json)).toList();
  }

  Future<bool> deleteApiTerreno(int uid) async {
    var url = Uri.parse("$baseUrl/terrenos?$uid");
    final respuesta = await http.delete(url,
        headers: {"Content-type": "application/json;charset=UTF-8"});

    try {
      if (respuesta.statusCode == 200) {
        return true;
        //return utf8.decode(respuesta.bodyBytes).contains('true');
      } else {
        throw Exception(respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('$e');
    }
  }

  Future<bool> putApiTerreno(Terreno datos) async {
    var url = Uri.parse("$baseUrl/terrenos/${datos.uid}");
    final respuesta = await http.put(url,
        body: datos.toJson(),
        headers: {"Content-type": "application/json;charset=UTF-8"});
    try {
      if (respuesta.statusCode == 200) {
        return true;
      } else {
        throw Exception(respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('$e');
    }
  }

  Future<bool> postApiTerreno(Terreno datos) async {
    var url = Uri.parse("$baseUrl/terrenos");
    final resquet = await http.post(url,
        body: datos.toJson(),
        headers: {"Content-type": "application/json;charset=UTF-8"});
    try {
      if (resquet.statusCode != 200) {
        throw Exception('${resquet.statusCode}');
      } else {
        return true;
      }
    } catch (e) {
      throw ('$e');
    }
  }
// BLOQUE DE TERRENO FIN ---------------------------------------------------------------------------------------------------------

// BLOQUE DE FINCA INCIO ---------------------------------------------------------------------------------------------------------

  Future<Finca?> getApiFinca(String uid) async {
    var url = Uri.parse("$baseUrl/terrenos/id=$uid");

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return utf8.decode(respuesta.bodyBytes) != ""
            ? Finca.fromJson(utf8.decode(respuesta.bodyBytes))
            : null;
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<List<Finca>> getApiFincas() async {
    var url = Uri.parse("$baseUrl/fincas");
    print(url.toString());

    try {
      var respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseJsonToListFinca(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<Finca> parseJsonToListFinca(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Finca>((json) => Finca.fromMap(json)).toList();
  }

  Future<bool> deleteApiFinca(int uid) async {
    var url = Uri.parse("$baseUrl/fincas/$uid");
    final respuesta = await http.delete(url,
        headers: {"Content-type": "application/json;charset=UTF-8"});

    try {
      if (respuesta.statusCode == 200) {
        return true;
        //return utf8.decode(respuesta.bodyBytes).contains('true');
      } else {
        throw Exception(respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('$e');
    }
  }

  Future<bool> putApiFinca(Finca datos) async {
    var url = Uri.parse("$baseUrl/fincas/${datos.uid}");
    final respuesta = await http.put(url,
        body: datos.toJson(),
        headers: {"Content-type": "application/json;charset=UTF-8"});
    try {
      if (respuesta.statusCode == 200) {
        return true;
      } else {
        throw Exception(respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('$e');
    }
  }

  Future<bool> postApiFinca(Finca datos) async {
    var url = Uri.parse("$baseUrl/fincas");
    print(datos.toJson());
    final resquet = await http.post(url,
        body: datos.toJson(),
        headers: {"Content-type": "application/json;charset=UTF-8"});
    try {
      if (resquet.statusCode != 200) {
        throw Exception('${resquet.statusCode}');
      } else {
        return true;
      }
    } catch (e) {
      throw ('$e');
    }
  }

// BLOQUE DE FINCA FIN ---------------------------------------------------------------------------------------------------------
}
