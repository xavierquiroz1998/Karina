// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_officechart/officechart.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as excel;
import 'package:tesis_karina/entity/objeto_view.dart';
import 'package:tesis_karina/provider/enfermedad_provider.dart';
import 'package:tesis_karina/provider/finca_provider.dart';
import 'package:tesis_karina/provider/insumo_provider.dart';
import 'package:tesis_karina/provider/maquinaria_provider.dart';
import 'package:tesis_karina/provider/planificacion_provider.dart';
import 'package:tesis_karina/provider/terreno_provider.dart';
import 'package:tesis_karina/provider/usuario_provider.dart';
import 'package:tesis_karina/utils/save_file_mobile.dart';
import 'package:tesis_karina/utils/util_view.dart';

class ReporteProvider extends ChangeNotifier {
  Future<void> generateExcel(BuildContext context) async {
    int x = 3;
    int count = 0;
    final provider = Provider.of<PlanificacionProvider>(context, listen: false);
    await provider.getIntDetail2();
    final excel.Workbook workbook = excel.Workbook(0);
    final excel.Worksheet sheet1 = workbook.worksheets.addWithName('Ordenes');

    //Adding cell style.
    final excel.Style style1 = workbook.styles.add('Style1');
    style1.backColor = '#D9E1F2';
    style1.hAlign = excel.HAlignType.left;
    style1.vAlign = excel.VAlignType.center;
    style1.bold = true;

    sheet1.getRangeByName('A2').cellStyle = style1;
    sheet1.getRangeByName('A2:AJ2').cellStyle.backColor = '#D9E1F2';
    sheet1.getRangeByName('A2:AJ2').cellStyle.hAlign = excel.HAlignType.center;
    sheet1.getRangeByName('A2:AJ2').cellStyle.vAlign = excel.VAlignType.center;
    sheet1.getRangeByName('A2:AJ2').cellStyle.bold = true;
    sheet1.getRangeByName('A2:AJ2').columnWidth = 20.00;
    /* COLUMNAS */
    sheet1.getRangeByIndex(2, 1).text = 'ID';
    sheet1.getRangeByIndex(2, 2).text = 'FINCA';
    sheet1.getRangeByIndex(2, 3).text = 'TERRENO';
    sheet1.getRangeByIndex(2, 4).text = 'INICIO';
    sheet1.getRangeByIndex(2, 5).text = 'FIN';
    sheet1.getRangeByIndex(2, 6).text = 'USUARIO';
    sheet1.getRangeByIndex(2, 7).text = 'OBSERVACION';
    sheet1.getRangeByIndex(2, 8).text = 'ESTADO';

    for (var element in provider.listDetailPlanificacion) {
      sheet1.getRangeByIndex(x, 1).text =
          "DETALLE-${element.iddetalleplanificacion}";
      sheet1.getRangeByIndex(x, 2).text = element.actividad;
      sheet1.getRangeByIndex(x, 2).text = element.idTerreno;
      sheet1.getRangeByIndex(x, 3).text =
          UtilView.convertDateToString(element.inicio);
      sheet1.getRangeByIndex(x, 4).text =
          UtilView.convertDateToString(element.fin);
      sheet1.getRangeByIndex(x, 5).text = element.observacion;
      sheet1.getRangeByIndex(x, 6).text = element.observacion2;
      sheet1.getRangeByIndex(x, 7).text =
          element.estado ? "ACTIVO" : "TERMINADO";
      if (!element.estado) {
        count++;
      }
      x++;
    }

    sheet1.getRangeByIndex(5, 6).text = "RESULTADO";
    sheet1.getRangeByIndex(5, 7).text =
        "${provider.listDetailPlanificacion.length * count / 100}%";

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    await FileSaveHelper.saveAndLaunchFile(bytes, 'OrdenesReport.xlsx');
  }

  Future<void> generateEnfAndPlagExcel() async {
    final excel.Workbook workbook = excel.Workbook(0);
    final excel.Worksheet sheet1 = workbook.worksheets.addWithName('Plagas');
    int x = 3;
    //Adding cell style.
    final excel.Style style1 = workbook.styles.add('Style1');
    style1.backColor = '#D9E1F2';
    style1.hAlign = excel.HAlignType.left;
    style1.vAlign = excel.VAlignType.center;
    style1.bold = true;

    sheet1.getRangeByName('A2').cellStyle = style1;
    sheet1.getRangeByName('A2:AJ2').cellStyle.backColor = '#D9E1F2';
    sheet1.getRangeByName('A2:AJ2').cellStyle.hAlign = excel.HAlignType.center;
    sheet1.getRangeByName('A2:AJ2').cellStyle.vAlign = excel.VAlignType.center;
    sheet1.getRangeByName('A2:AJ2').cellStyle.bold = true;
    sheet1.getRangeByName('A2:AJ2').columnWidth = 20.00;
    /* COLUMNAS */
    sheet1.getRangeByIndex(2, 1).text = 'ID';
    sheet1.getRangeByIndex(2, 2).text = 'TERRENO';
    sheet1.getRangeByIndex(2, 3).text = 'OBSERVACION';
    sheet1.getRangeByIndex(2, 4).text = 'EVALUACION';
    sheet1.getRangeByIndex(2, 5).text = 'FECHA';
    sheet1.getRangeByIndex(2, 6).text = 'PLAGA';
    sheet1.getRangeByIndex(2, 7).text = 'TRATAMIENTO';

    sheet1.getRangeByIndex(3, 1).text = "PD-01";
    sheet1.getRangeByIndex(3, 2).text = "F-01 FINCA POLIVIO";
    sheet1.getRangeByIndex(3, 3).text =
        "OBSERVACION REGISTRADA :: 16/02/2023 ACTUAL PROCESO DE EVOLUCION 30.0% INGRESADA POR EL USUARIO :: U-01 ";
    sheet1.getRangeByIndex(3, 4).text = "2.2";
    sheet1.getRangeByIndex(3, 5).text = "20/02/2023";
    sheet1.getRangeByIndex(3, 6).text = "MOSQUITA BLANCA";
    sheet1.getRangeByIndex(3, 7).text = "FUMIGACION AL REDEDOR DEL TERRENO";

    sheet1.getRangeByIndex(5, 6).text = "VECES QUE HUBO NOVEDADES";
    sheet1.getRangeByIndex(5, 7).text = "#1";

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    await FileSaveHelper.saveAndLaunchFile(bytes, 'ExpensesReport.xlsx');
  }

  Future<void> generarChart() async {
    final excel.Workbook workbook = excel.Workbook(0);
    final excel.Worksheet sheet =
        workbook.worksheets.addWithName('ORDENES DE TRABAJOS');

// Setting value in the cell.
    sheet.getRangeByName('A11').setText('PD-01');
    sheet.getRangeByName('A12').setText('PD-02');
    sheet.getRangeByName('A13').setText('NO TERMINADAS');
    sheet.getRangeByName('B11').setNumber(10);
    sheet.getRangeByName('B12').setNumber(20);
    sheet.getRangeByName('B13').setNumber(70);

// Create an instances of chart collection.
    final ChartCollection charts = ChartCollection(sheet);

// Add the chart.
    final Chart chart1 = charts.add();

// Set Chart Type.
    chart1.chartType = ExcelChartType.pie;

// Set data range in the worksheet.
    chart1.dataRange = sheet.getRangeByName('A11:B13');
    chart1.isSeriesInRows = false;

// set charts to worksheet.
    sheet.charts = charts;

// save and dispose the workbook.
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    await FileSaveHelper.saveAndLaunchFile(bytes, 'Chart.xlsx');
  }

  Future<void> generateMantenimiento(
      List<ObjetoView> list, BuildContext context) async {
    //Creating a workbook.
    final excel.Workbook workbook = excel.Workbook();

    //Adding cell style.
    final excel.Style style1 = workbook.styles.add('Style1');
    style1.backColor = '#D9E1F2';
    style1.hAlign = excel.HAlignType.left;
    style1.vAlign = excel.VAlignType.center;
    style1.bold = true;

    if (list[1].name == "Insumos" && list[1].select) {
      final excel.Worksheet sheet1 = workbook.worksheets[0];
      sheet1.name = 'INSUMO';
      sheet1.showGridlines = false;
      int countI = 3;
      final providerI = Provider.of<InsumoProvider>(context, listen: false);
      await providerI.getListInt();

      sheet1.getRangeByName('A2').cellStyle = style1;
      sheet1.getRangeByName('A2:AJ2').cellStyle.backColor = '#D9E1F2';
      sheet1.getRangeByName('A2:AJ2').cellStyle.hAlign =
          excel.HAlignType.center;
      sheet1.getRangeByName('A2:AJ2').cellStyle.vAlign =
          excel.VAlignType.center;
      sheet1.getRangeByName('A2:AJ2').cellStyle.bold = true;
      sheet1.getRangeByName('A2:AJ2').columnWidth = 20.00;
      /* COLUMNAS */
      sheet1.getRangeByIndex(2, 1).text = 'ID';
      sheet1.getRangeByIndex(2, 2).text = 'INSUMO TIPO';
      sheet1.getRangeByIndex(2, 3).text = 'PROVEEDOR';
      sheet1.getRangeByIndex(2, 4).text = 'NOMBRE';
      sheet1.getRangeByIndex(2, 5).text = 'FECHA DE CADUCIDAD';
      sheet1.getRangeByIndex(2, 6).text = 'OBSERVACION';
      sheet1.getRangeByIndex(2, 7).text = 'UNIDADES';
      sheet1.getRangeByIndex(2, 8).text = 'ESTADO';

      for (var e in providerI.listInsumo) {
        sheet1.getRangeByIndex(countI, 1).text = e.idinsumos;
        sheet1.getRangeByIndex(countI, 2).text = e.insumoTipoId;
        sheet1.getRangeByIndex(countI, 3).text = e.proveedore.observacion;
        sheet1.getRangeByIndex(countI, 4).text = e.nombre;
        sheet1.getRangeByIndex(countI, 6).text =
            UtilView.convertDateToString(e.fechaCaducidad);
        sheet1.getRangeByIndex(countI, 7).text = e.unidades;
        sheet1.getRangeByIndex(countI, 8).text =
            e.estado == 1 ? "ACTIVO" : "INACTIVO";
        countI++;
      }
    }
    if (list[0].name == "Enfermedad" && list[0].select) {
      final excel.Worksheet sheet2 =
          workbook.worksheets.addWithName('ENFERMEDAD');
      sheet2.showGridlines = false;
      int countE = 3;
      final providerE = Provider.of<EnfermedadProvider>(context, listen: false);
      await providerE.getListInt();

      sheet2.getRangeByName('A2').cellStyle = style1;
      sheet2.getRangeByName('A2:AJ2').cellStyle.backColor = '#D9E1F2';
      sheet2.getRangeByName('A2:AJ2').cellStyle.hAlign =
          excel.HAlignType.center;
      sheet2.getRangeByName('A2:AJ2').cellStyle.vAlign =
          excel.VAlignType.center;
      sheet2.getRangeByName('A2:AJ2').cellStyle.bold = true;
      sheet2.getRangeByName('A2:AJ2').columnWidth = 20.00;
      /* COLUMNAS */
      sheet2.getRangeByIndex(2, 1).text = 'ID';
      sheet2.getRangeByIndex(2, 2).text = 'NOMBRE';
      sheet2.getRangeByIndex(2, 3).text = 'PLAGAS TIPO';
      sheet2.getRangeByIndex(2, 4).text = 'ENFERMEDAD TIPO';
      sheet2.getRangeByIndex(2, 5).text = 'ESPECIFICACIONES';
      sheet2.getRangeByIndex(2, 6).text = 'TRATAMIENTO';
      sheet2.getRangeByIndex(2, 7).text = 'OBSERVACION';
      sheet2.getRangeByIndex(2, 8).text = 'FOTOGRAFIA';
      sheet2.getRangeByIndex(2, 9).text = 'ESTADO';

      for (var e in providerE.listEnfermedad) {
        sheet2.getRangeByIndex(countE, 1).text = e.idenfermedades;
        sheet2.getRangeByIndex(countE, 2).text = e.nombre;
        sheet2.getRangeByIndex(countE, 3).text = e.plagasTipoId;
        sheet2.getRangeByIndex(countE, 4).text = e.enfermedadTipoId;
        sheet2.getRangeByIndex(countE, 5).text = e.especificaciones;
        sheet2.getRangeByIndex(countE, 6).text = e.tratamiento;
        sheet2.getRangeByIndex(countE, 7).text = e.observacion;
        sheet2.getRangeByIndex(countE, 8).text =
            e.fotografia.length > 2 ? "SI" : "NO";
        sheet2.getRangeByIndex(countE, 9).text =
            e.estado == 1 ? "ACTIVO" : "INACTIVO";
        countE++;
      }
    }
    if (list[2].name == "Maquinaria" && list[2].select) {
      final excel.Worksheet sheet3 =
          workbook.worksheets.addWithName('MAQUINARIA');
      sheet3.showGridlines = false;

      int countM = 3;
      final providerM = Provider.of<MaquinariaProvider>(context, listen: false);
      await providerM.getListInt();

      sheet3.getRangeByName('A2').cellStyle = style1;
      sheet3.getRangeByName('A2:AJ2').cellStyle.backColor = '#D9E1F2';
      sheet3.getRangeByName('A2:AJ2').cellStyle.hAlign =
          excel.HAlignType.center;
      sheet3.getRangeByName('A2:AJ2').cellStyle.vAlign =
          excel.VAlignType.center;
      sheet3.getRangeByName('A2:AJ2').cellStyle.bold = true;
      sheet3.getRangeByName('A2:AJ2').columnWidth = 20.00;
      /* COLUMNAS */
      sheet3.getRangeByIndex(2, 1).text = 'ID';
      sheet3.getRangeByIndex(2, 2).text = 'NOMBRE';
      sheet3.getRangeByIndex(2, 3).text = 'IDENTIFICACION';
      sheet3.getRangeByIndex(2, 4).text = 'MAQUINARIA TIPO';
      sheet3.getRangeByIndex(2, 5).text = 'PROCEDENCIA';
      sheet3.getRangeByIndex(2, 6).text = 'CAPACIDAD';
      sheet3.getRangeByIndex(2, 7).text = 'FECHA COMPRA';
      sheet3.getRangeByIndex(2, 8).text = 'ESTADO';

      for (var e in providerM.listMaquinaria) {
        sheet3.getRangeByIndex(countM, 1).text = e.idmaquinarias;
        sheet3.getRangeByIndex(countM, 2).text = e.nombre;
        sheet3.getRangeByIndex(countM, 3).text = e.identificacion;
        sheet3.getRangeByIndex(countM, 4).text = e.maquinariaTipoId;
        sheet3.getRangeByIndex(countM, 5).text = e.procedencia;
        sheet3.getRangeByIndex(countM, 6).text = "${e.capacidad}";
        sheet3.getRangeByIndex(countM, 7).text =
            UtilView.convertDateToString(e.fechacompra);
        sheet3.getRangeByIndex(countM, 8).text =
            e.estado == 1 ? "ACTIVO" : "INACTIVO";
        countM++;
      }
    }
    if (list[3].name == "Terrenos" && list[3].select) {
      final excel.Worksheet sheet4 = workbook.worksheets.addWithName('TERRENO');
      sheet4.showGridlines = false;
      int countT = 3;
      final providerT = Provider.of<TerrenoProvider>(context, listen: false);
      await providerT.getListInt();
      sheet4.getRangeByName('A2').cellStyle = style1;
      sheet4.getRangeByName('A2:AJ2').cellStyle.backColor = '#D9E1F2';
      sheet4.getRangeByName('A2:AJ2').cellStyle.hAlign =
          excel.HAlignType.center;
      sheet4.getRangeByName('A2:AJ2').cellStyle.vAlign =
          excel.VAlignType.center;
      sheet4.getRangeByName('A2:AJ2').cellStyle.bold = true;
      sheet4.getRangeByName('A2:AJ2').columnWidth = 20.00;
      /* COLUMNAS */
      sheet4.getRangeByIndex(2, 1).text = 'ID';
      sheet4.getRangeByIndex(2, 2).text = 'FINCA';
      sheet4.getRangeByIndex(2, 3).text = 'UBICACION';
      sheet4.getRangeByIndex(2, 4).text = 'DIMENSION';
      sheet4.getRangeByIndex(2, 5).text = 'LONGITUD';
      sheet4.getRangeByIndex(2, 6).text = 'LATITUD';
      sheet4.getRangeByIndex(2, 7).text = 'UNIDAD';
      sheet4.getRangeByIndex(2, 8).text = 'DISPONIBILIDAD';
      sheet4.getRangeByIndex(2, 9).text = 'OBSERVACION';
      sheet4.getRangeByIndex(2, 10).text = 'ESTADO';

      for (var e in providerT.listTerreno) {
        sheet4.getRangeByIndex(countT, 1).text = e.idterreno;
        sheet4.getRangeByIndex(countT, 2).text = e.finca.nombre;
        sheet4.getRangeByIndex(countT, 3).text = e.ubicacion;
        sheet4.getRangeByIndex(countT, 4).text = e.dimension;
        sheet4.getRangeByIndex(countT, 5).text = e.longitud;
        sheet4.getRangeByIndex(countT, 6).text = e.latitud;
        sheet4.getRangeByIndex(countT, 7).text = e.unidad;
        sheet4.getRangeByIndex(countT, 8).text = e.disponibilidad;
        sheet4.getRangeByIndex(countT, 9).text = e.observacion;
        sheet4.getRangeByIndex(countT, 10).text =
            e.estado ? "ACTIVO" : "INACTIVO";
        countT++;
      }
    }
    if (list[4].name == "Finca" && list[4].select) {
      final excel.Worksheet sheet5 = workbook.worksheets.addWithName('FINCA');
      sheet5.showGridlines = false;
      int countF = 3;
      final providerF = Provider.of<FincaProvider>(context, listen: false);
      await providerF.getListInt();

      sheet5.getRangeByName('A2').cellStyle = style1;
      sheet5.getRangeByName('A2:AJ2').cellStyle.backColor = '#D9E1F2';
      sheet5.getRangeByName('A2:AJ2').cellStyle.hAlign =
          excel.HAlignType.center;
      sheet5.getRangeByName('A2:AJ2').cellStyle.vAlign =
          excel.VAlignType.center;
      sheet5.getRangeByName('A2:AJ2').cellStyle.bold = true;
      sheet5.getRangeByName('A2:AJ2').columnWidth = 20.00;
      /* COLUMNAS */
      sheet5.getRangeByIndex(2, 1).text = 'ID';
      sheet5.getRangeByIndex(2, 2).text = 'NOMBRE';
      sheet5.getRangeByIndex(2, 3).text = 'DIMENSION';
      sheet5.getRangeByIndex(2, 4).text = 'UBICACION';
      sheet5.getRangeByIndex(2, 5).text = 'REFERENCIA';
      sheet5.getRangeByIndex(2, 6).text = 'ESTADO';

      for (var e in providerF.listFinca) {
        sheet5.getRangeByIndex(countF, 1).text = e.idfinca;
        sheet5.getRangeByIndex(countF, 2).text = e.nombre;
        sheet5.getRangeByIndex(countF, 3).text = e.dimension;
        sheet5.getRangeByIndex(countF, 4).text = e.ubicacion;
        sheet5.getRangeByIndex(countF, 5).text = e.referencia;
        sheet5.getRangeByIndex(countF, 6).text =
            e.estado == "1" ? "ACTIVO" : "INACTIVO";
        countF++;
      }
    }
    if (list[5].name == "Personal" && list[5].select) {
      final excel.Worksheet sheet6 =
          workbook.worksheets.addWithName('PERSONAL');
      sheet6.showGridlines = false;

      int countP = 3;
      final providerP = Provider.of<UsuarioProvider>(context, listen: false);
      await providerP.getListIntP();

      sheet6.getRangeByName('A2').cellStyle = style1;
      sheet6.getRangeByName('A2:AJ2').cellStyle.backColor = '#D9E1F2';
      sheet6.getRangeByName('A2:AJ2').cellStyle.hAlign =
          excel.HAlignType.center;
      sheet6.getRangeByName('A2:AJ2').cellStyle.vAlign =
          excel.VAlignType.center;
      sheet6.getRangeByName('A2:AJ2').cellStyle.bold = true;
      sheet6.getRangeByName('A2:AJ2').columnWidth = 20.00;
      /* COLUMNAS */
      sheet6.getRangeByIndex(2, 1).text = 'ID';
      sheet6.getRangeByIndex(2, 2).text = 'CEDULA';
      sheet6.getRangeByIndex(2, 3).text = 'NOMBRE';
      sheet6.getRangeByIndex(2, 4).text = 'APELLIDO';
      sheet6.getRangeByIndex(2, 5).text = 'DIRECCION';
      sheet6.getRangeByIndex(2, 6).text = 'CELULAR';
      sheet6.getRangeByIndex(2, 7).text = 'NACIMIENTO';
      sheet6.getRangeByIndex(2, 8).text = 'ID USUARIO';
      sheet6.getRangeByIndex(2, 8).text = 'ESTADO';

      for (var e in providerP.listPersona) {
        sheet6.getRangeByIndex(countP, 1).text = e.idUsuario;
        sheet6.getRangeByIndex(countP, 2).text = e.cedula;
        sheet6.getRangeByIndex(countP, 3).text = e.nombre;
        sheet6.getRangeByIndex(countP, 4).text = e.apellido;
        sheet6.getRangeByIndex(countP, 5).text = e.direccion;
        sheet6.getRangeByIndex(countP, 6).text = e.celular;
        sheet6.getRangeByIndex(countP, 7).text =
            UtilView.convertDateToString(e.nacimiento);
        sheet6.getRangeByIndex(countP, 8).text = e.idUsuario;
        sheet6.getRangeByIndex(countP, 9).text =
            e.estado ? "ACTIVO" : "INACTIVO";
        countP++;
      }
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    await FileSaveHelper.saveAndLaunchFile(bytes, 'MantenimientoReport.xlsx');
  }
}
