import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:tesis_karina/entity/usuario.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class UtilView {
  static late Usuario usuarioUtil;

  static String cadenaMenu(String cadena) {
    cadena.lastIndexOf(' ');
    int count = 0;
    for (var i = 0; i < cadena.length; i++) {
      count = count + (cadena[i] == ' ' ? 1 : 0);
    }
    return '';
  }

  static String splitCharacter(String cadena, int index) {
    return cadena.split(' -')[index];
  }

  static String convertDateToString(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  static DateTime convertStringToDate(String cadena) {
    return DateFormat("dd/MM/yyyy").parse(cadena);
  }

  static DateTime dateFormatNew(String cadena) {
    int? dia = 0;
    int? mes = 0;
    int? anio = 0;
    if (cadena.contains("-")) {
      dia = int.tryParse(cadena.substring(9, 10));
      mes = int.tryParse(cadena.substring(6, 7));
      anio = int.tryParse(cadena.substring(0, 4));
    } else {
      dia = int.tryParse(cadena.substring(6, 10));
      mes = int.tryParse(cadena.substring(3, 5));
      anio = int.tryParse(cadena.substring(0, 2));
    }

    return DateTime(anio!, mes!, dia!);
  }

  static String dateFormatDMY(String cadena) {
    DateTime date = DateTime.parse(cadena);
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  static String dateFormatYMD2(String cadena) {
    DateTime date = DateTime.parse(cadena);
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  static String dateSumDay(int day) {
    DateTime date = DateTime.now().add(Duration(days: day));
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  static bool dateRange(String inicio, String fin, int value) {
    DateTime dateInicio = DateFormat("dd/MM/yyyy").parse(inicio);
    DateTime dateFin = DateFormat("dd/MM/yyyy").parse(fin);
    return (dateFin.year >= dateInicio.year) &&
        (dateFin.month - dateInicio.month == value);
  }

  static messageNewAccess(
      String titulo, String message, Color color, BuildContext context) {
    final materialBanner = MaterialBanner(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      backgroundColor: Colors.transparent,
      forceActionsBelow: true,
      content: AwesomeSnackbarContent(
        title: titulo,
        message: message,
        contentType: ContentType.success,
        inMaterialBanner: true,
      ),
      actions: const [SizedBox.shrink()],
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(materialBanner);
  }

  static messageSnackNewAccess(String mensaje, BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        message: mensaje,
      ),
    );
  }

  static messageSnackNewError(String mensaje, BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        message: mensaje,
      ),
    );
  }

  static messageDanger(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 4,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 17.0,
      webPosition: "center",
      webBgColor: "red",
    );
  }

  static messageAccess(String message, Color color) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 12.0,
      webPosition: "center",
      webBgColor: 'rgb(46,64,83)',
    );
  }

  static messageWarning(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 17.0,
      webPosition: "center",
      webBgColor: "orange",
    );
  }

  static buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  static String getSecuenceString(String numero, int log) {
    int fix = numero.length; //tamaño del numero
    String resp = ""; // nuevo String a devolver
    String nuevo = "${int.parse(numero) + 1}";
    if (fix <= log) {
      resp = nuevo.padLeft(log, '0');
    }
    return resp;
  }

  static String dateFormatYMD1(String cadena) {
    DateTime date = DateTime.utc(
        int.parse(cadena.substring(6, 10)),
        int.parse(cadena.substring(3, 5)),
        int.parse(cadena.substring(0, 2)),
        DateTime.now().hour,
        DateTime.now().minute,
        DateTime.now().second);

    String formattedDate = DateFormat('yyyy-MM-ddTHH:mm:ss')
        .format(date.add(const Duration(hours: -5)));
    return formattedDate;
  }

  static String dateFormatYMD(String cadena) {
    DateTime date = DateTime.utc(int.parse(cadena.substring(6, 10)),
        int.parse(cadena.substring(3, 5)), int.parse(cadena.substring(0, 2)));
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return formattedDate;
  }

  static String processEtapaUtil(int value) {
    String resp = "";
    switch (value) {
      case 1:
        resp = "FASE VEGETATIVA";
        break;
      case 2:
        resp = "FASE REPRODUCTIVA";
        break;
      case 3:
        resp = "FASE MADURACIÓN";
        break;
      default:
        resp = "FINALIZACION";
        break;
    }
    return resp;
  }

  static String processNivelUtil(int value) {
    String resp = "";
    switch (value) {
      case 0:
        resp = "Germinación";
        break;
      case 1:
        resp = "Plántula";
        break;
      case 2:
        resp = "Macollamiento";
        break;
      case 3:
        resp = "Elongavion del tallo";
        break;
      case 4:
        resp = "Embuchamiento";
        break;
      case 5:
        resp = "Espigamiento";
        break;
      case 6:
        resp = "Floración";
        break;
      case 7:
        resp = "Etapa lechosa";
        break;
      case 8:
        resp = "Etapa de maduración";
        break;
      case 9:
        resp = "Senescencia";
        break;
      default:
        resp = "";
        break;
    }
    return resp;
  }

  static double porcentajeProceso(int valx, int valy) {
    double resp = 0;
    switch (valx) {
      case 1:
        if (valy == 0) {
          resp = 10;
        } else if (valy == 1) {
          resp = 20;
        } else {
          resp = 30;
        }

        break;
      case 2:
        if (valy == 3) {
          resp = 40;
        } else if (valy == 4) {
          resp = 50;
        } else if (valy == 5) {
          resp = 60;
        } else {
          resp = 70;
        }

        break;
      case 3:
        if (valy == 7) {
          resp = 80;
        } else if (valy == 8) {
          resp = 90;
        } else {
          resp = 100;
        }
        break;
      default:
        resp = 0;
        break;
    }
    return resp;
  }

  static double porcentajeRaiting(int valx, int valy) {
    double resp = 0;
    switch (valx) {
      case 1:
        if (valy == 0) {
          resp = 0.5;
        } else if (valy == 1) {
          resp = 1;
        } else {
          resp = 1.5;
        }

        break;
      case 2:
        if (valy == 3) {
          resp = 2;
        } else if (valy == 4) {
          resp = 2.5;
        } else if (valy == 5) {
          resp = 3;
        } else {
          resp = 3.5;
        }

        break;
      case 3:
        if (valy == 7) {
          resp = 4;
        } else if (valy == 8) {
          resp = 4.5;
        } else {
          resp = 5;
        }
        break;
      default:
        resp = 0;
        break;
    }
    return resp;
  }

/*   static Color convertColor(String color) {
    Color colorPrimario = Palette.azulMarino;
    if (color != "") {
      final colorF = color.replaceAll("#", "0xFF");
      return colorPrimario = Color(int.parse(colorF.toUpperCase()));
    }
    return colorPrimario;
  } */

  static String numberRandonUid() {
    var uuid = const Uuid();
    return uuid.v1();
  }

  static int convertInteger(String color) {
    int colorPrimario = int.parse(color != "" ? color : "0xee29");
    return colorPrimario;
  }
}
