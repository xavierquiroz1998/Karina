import 'package:tesis_karina/entity/Task.dart';
import 'package:tesis_karina/entity/enfermedad.dart';
import 'package:tesis_karina/entity/finca.dart';
import 'package:tesis_karina/entity/hist_task.dart';
import 'package:tesis_karina/entity/insumo.dart';
import 'package:tesis_karina/entity/list_insumos.dart';
import 'package:tesis_karina/entity/list_personal.dart';
import 'package:tesis_karina/entity/list_terrenos.dart';
import 'package:tesis_karina/entity/maquinaria.dart';
import 'package:tesis_karina/entity/personas.dart';
import 'package:tesis_karina/entity/response/respuesta.dart';
import 'package:tesis_karina/entity/terreno.dart';
import 'package:tesis_karina/entity/usuario.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tesis_karina/utils/util_view.dart';

class SolicitudApi {
  //static String baseUrl = "http://192.168.100.15:8001/api";
  static String baseUrl = "http://192.168.100.73:8000/api";

// #region BLOQUE DE USUARIOS Y PERSONAS

  Future<Usuario?> getApiLogin(String usuario, String pass) async {
    var url = Uri.parse("$baseUrl/usuarios/login/");

    final data = {"clave": pass, "correo": usuario};
    final bod = json.encode(data);

    try {
      http.Response respuesta = await http.post(url, body: bod, headers: {
        "Content-type": "application/json;charset=UTF-8",
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Credentials": "true",
      });
      if (respuesta.statusCode == 200) {
        return utf8.decode(respuesta.bodyBytes) != ""
            ? Usuario.fromJson(utf8.decode(respuesta.bodyBytes))
            : null;
      } else if (respuesta.statusCode == 400 || respuesta.statusCode == 500) {
        UtilView.messageDanger(
            Respuesta.fromJson(utf8.decode(respuesta.bodyBytes)).msg);
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }

    return null;
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

  Future<bool> deleteApiUsuario(String uid) async {
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

// #endregion

// #region BLOQUE DE ENFERMEDADES INCIO
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

  Future<bool> deleteApiEnfermedad(String uid) async {
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

// #endregion

// #region // BLOQUE DE INSUMO INCIO

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

  Future<bool> deleteApiInsumo(String uid) async {
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

// #endregion

// #region BLOQUE DE MAQUUINARIA INCIO
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

  Future<bool> deleteApiMaquinaria(String uid) async {
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

  // #endregion // BLOQUE DE MAQUINARIA FIN ---------------------------------------------------------------------------------------------------------

// #region BLOQUE DE TERRENO INCIO
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

  Future<bool> deleteApiTerreno(String uid) async {
    var url = Uri.parse("$baseUrl/terrenos/$uid");
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

// #endregion

// #region BLOQUE DE FINCA INCIO
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

  Future<bool> deleteApiFinca(String uid) async {
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

// #endregion

// #region BLOQUE TASK INICIO

  Future<List<Task>> getApiTask() async {
    var url = Uri.parse("$baseUrl/task");
    print(url.toString());

    try {
      var respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseJsonToListTask(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<List<HistTask>> getApiListUserTask(String user, String estado) async {
    var url = Uri.parse("$baseUrl/listtask/tareas");

    var data = {"obs": estado, "referencia": user};

    try {
      var respuesta = await http.post(url,
          headers: {"Content-type": "application/json;charset=UTF-8"},
          body: json.encode(data));
      if (respuesta.statusCode == 200) {
        return parseJsonToListHistTask(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<List<HistTask>> getApiListTask() async {
    var url = Uri.parse("$baseUrl/listtask");
    print(url.toString());

    try {
      var respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseJsonToListHistTask(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<HistTask> parseJsonToListHistTask(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<HistTask>((json) => HistTask.fromMap(json)).toList();
  }

  List<Task> parseJsonToListTask(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Task>((json) => Task.fromMap(json)).toList();
  }

  Future<bool> deleteApiTask(String uid) async {
    var url = Uri.parse("$baseUrl/task/$uid");
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

  Future<bool> putApiTask(Task datos) async {
    var url = Uri.parse("$baseUrl/task/${datos.uid}");
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

  Future<bool> postApiTask(Task datos) async {
    var url = Uri.parse("$baseUrl/task");
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

// #endregion

// #region BLOQUE DE PERSONAS INCIO
  Future<Persona?> getApiPersona(String uid) async {
    var url = Uri.parse("$baseUrl/personas/id=$uid");

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return utf8.decode(respuesta.bodyBytes) != ""
            ? Persona.fromJson(utf8.decode(respuesta.bodyBytes))
            : null;
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<List<Persona>> getApiPersonas() async {
    var url = Uri.parse("$baseUrl/personas");
    print(url.toString());

    try {
      var respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseJsonToListPersonas(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<Persona> parseJsonToListPersonas(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Persona>((json) => Persona.fromMap(json)).toList();
  }

  Future<bool> deleteApiPersonas(String uid) async {
    var url = Uri.parse("$baseUrl/personas/$uid");
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

  Future<bool> putApiPersonas(Persona datos) async {
    var url = Uri.parse("$baseUrl/personas/${datos.uid}");
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

  Future<bool> postApiPersonas(Persona datos) async {
    var url = Uri.parse("$baseUrl/personas");
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

// #endregion

  Future<bool> postApiListInsumo(ListInsumos insumos) async {
    var url = Uri.parse("$baseUrl/listinsumo");
    var data = insumos.toJson();

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

  Future<bool> postApiListPersonal(ListPersonal personal) async {
    var url = Uri.parse("$baseUrl/listpersonal");
    var data = personal.toJson();

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

  Future<bool> postApiListTerrenos(ListTerrenos terreno) async {
    var url = Uri.parse("$baseUrl/listterreno");
    var data = terreno.toJson();

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
}
