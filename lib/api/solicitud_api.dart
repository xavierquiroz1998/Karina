import 'package:tesis_karina/entity/detalle_planificacion.dart';
import 'package:tesis_karina/entity/enfermedad.dart';
import 'package:tesis_karina/entity/finca.dart';
import 'package:tesis_karina/entity/historial.dart';
import 'package:tesis_karina/entity/insumo.dart';
import 'package:tesis_karina/entity/list_insumos.dart';
import 'package:tesis_karina/entity/list_personal.dart';
import 'package:tesis_karina/entity/list_terrenos.dart';
import 'package:tesis_karina/entity/maquinaria.dart';
import 'package:tesis_karina/entity/personas.dart';
import 'package:tesis_karina/entity/planificacion.dart';
import 'package:tesis_karina/entity/response/respuesta.dart';
import 'package:tesis_karina/entity/terreno.dart';
import 'package:tesis_karina/entity/tipos_enfermedades.dart';
import 'package:tesis_karina/entity/tipos_insumos.dart';
import 'package:tesis_karina/entity/tipos_maquinarias.dart';
import 'package:tesis_karina/entity/tipos_plagas.dart';
import 'package:tesis_karina/entity/usuario.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tesis_karina/utils/util_view.dart';

class SolicitudApi {
  static String baseUrl = "http://192.168.100.73:8000/api";
  //static String baseUrl = "http://192.168.100.4:8000/api";

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
    var url = Uri.parse("$baseUrl/usuarios/${datos.idusuarios}");
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
  Future<Enfermedades?> getApiEnfermedad(String uid) async {
    var url = Uri.parse("$baseUrl/enfermedades?id=$uid");

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return utf8.decode(respuesta.bodyBytes) != ""
            ? Enfermedades.fromJson(utf8.decode(respuesta.bodyBytes))
            : null;
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<List<Enfermedades>> getApiEnfermedades() async {
    var url = Uri.parse("$baseUrl/enfermedades");
    print(url.toString());

    try {
      var respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseJsonToListEnfermedades(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<List<TipoEnfermedades>> getApiTipoEnfermedades() async {
    var url = Uri.parse("$baseUrl/tiposenfermedades");
    print(url.toString());

    try {
      var respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseJsonToListTipoEnfermedades(
            utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<List<TiposPlagas>> getApiTipoPlagas() async {
    var url = Uri.parse("$baseUrl/tiposplagas");
    print(url.toString());

    try {
      var respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseJsonToListTiposPlagas(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<Enfermedades> parseJsonToListEnfermedades(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo
        .map<Enfermedades>((json) => Enfermedades.fromMap(json))
        .toList();
  }

  List<TiposPlagas> parseJsonToListTiposPlagas(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo
        .map<TiposPlagas>((json) => TiposPlagas.fromMap(json))
        .toList();
  }

  List<TipoEnfermedades> parseJsonToListTipoEnfermedades(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo
        .map<TipoEnfermedades>((json) => TipoEnfermedades.fromMap(json))
        .toList();
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

  Future<bool> putApiEnfermedad(Enfermedades datos) async {
    var url = Uri.parse("$baseUrl/enfermedades/${datos.idenfermedades}");

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

  Future<bool> postApiEnfermedad(Enfermedades datos) async {
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

  Future<Insumos?> getApiInsumo(String uid) async {
    var url = Uri.parse("$baseUrl/insumos?id=$uid");

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return utf8.decode(respuesta.bodyBytes) != ""
            ? Insumos.fromJson(utf8.decode(respuesta.bodyBytes))
            : null;
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<List<Insumos>> getApiInsumos() async {
    var url = Uri.parse("$baseUrl/insumos");
    print(url.toString());

    try {
      var respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseJsonToListInsumos(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<Insumos> parseJsonToListInsumos(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Insumos>((json) => Insumos.fromMap(json)).toList();
  }

  Future<List<TiposInsumos>> getApiTipoInsumos() async {
    var url = Uri.parse("$baseUrl/tiposinsumos");
    print(url.toString());

    try {
      var respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseJsonToListTiposInsumos(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<TiposInsumos> parseJsonToListTiposInsumos(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo
        .map<TiposInsumos>((json) => TiposInsumos.fromMap(json))
        .toList();
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

  Future<bool> putApiInsumo(Insumos datos) async {
    var url = Uri.parse("$baseUrl/insumos/${datos.idinsumos}");
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

  Future<bool> postApiInsumo(Insumos datos) async {
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

  Future<List<TiposMaquinarias>> getApiTipoMaquinarias() async {
    var url = Uri.parse("$baseUrl/tiposmaquinarias");
    print(url.toString());

    try {
      var respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseJsonToListTiposMaquinarias(
            utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<TiposMaquinarias> parseJsonToListTiposMaquinarias(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo
        .map<TiposMaquinarias>((json) => TiposMaquinarias.fromMap(json))
        .toList();
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
    var url = Uri.parse("$baseUrl/maquinarias/${datos.idmaquinarias}");
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
    var url = Uri.parse("$baseUrl/terreno/$uid");

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

  Future<List<Terreno>> getApiFincaAndTerreno(String uid) async {
    var url = Uri.parse("$baseUrl/terreno/listFinca/$uid");

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

  Future<List<Terreno>> getApiTerrenos() async {
    var url = Uri.parse("$baseUrl/terreno");
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
    var url = Uri.parse("$baseUrl/terrenos/${datos.idterreno}");
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
    var url = Uri.parse("$baseUrl/terreno");
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
    var url = Uri.parse("$baseUrl/fincas/${datos.idfinca}");
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

  Future<List<Planificacion>> getApiTask() async {
    var url = Uri.parse("$baseUrl/planificacion");
    print(url.toString());

    try {
      var respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseJsonToListPlanificacion(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<List<Detalleplanificacion>> getApiListUserTask(
      String user, String estado) async {
    var url = Uri.parse("$baseUrl/detalleplanificacion/tareas/");

    var data = {"obs": estado, "referencia": user};

    try {
      var respuesta = await http.post(url,
          headers: {"Content-type": "application/json;charset=UTF-8"},
          body: json.encode(data));
      if (respuesta.statusCode == 200) {
        return parseJsonToListDetalleplanificacion(
            utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<bool> putApiTask(Detalleplanificacion datos) async {
    var url = Uri.parse(
        "$baseUrl/detalleplanificacion/${datos.iddetalleplanificacion}");
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

  Future<List<Detalleplanificacion>> getApiListTask() async {
    var url = Uri.parse("$baseUrl/detalleplanificacion");
    print(url.toString());

    try {
      var respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseJsonToListDetalleplanificacion(
            utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<Detalleplanificacion> parseJsonToListDetalleplanificacion(
      String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo
        .map<Detalleplanificacion>((json) => Detalleplanificacion.fromMap(json))
        .toList();
  }

  List<Planificacion> parseJsonToListPlanificacion(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo
        .map<Planificacion>((json) => Planificacion.fromMap(json))
        .toList();
  }

  Future<bool> deleteApiTask(String uid) async {
    var url = Uri.parse("$baseUrl/planificacion/$uid");
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

  Future<bool> postApiTask(Planificacion datos) async {
    var url = Uri.parse("$baseUrl/planificacion");
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

  Future<bool> postApiTaskDet(Detalleplanificacion datos) async {
    var url = Uri.parse("$baseUrl/detalleplanificacion");
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

// GUARDADO DE HISTORIAL QUE ES EL SEGUIMIENTO DEL CULTIVO

  Future<bool> postApiHist(Historial datos) async {
    var url = Uri.parse("$baseUrl/historial");
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

// FIN DEL SEGUIMIENTO DEL CULTIVO

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
    var url = Uri.parse("$baseUrl/personas/${datos.idpersonas}");
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
    var url = Uri.parse("$baseUrl/listainsumos");
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

  Future<bool> postApiListMaquinaria(Maquinaria maquinaria) async {
    var url = Uri.parse("$baseUrl/listmaquinarias");
    var data = maquinaria.toJson();

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
