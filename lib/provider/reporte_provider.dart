import 'package:flutter/material.dart';
import 'package:syncfusion_officechart/officechart.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as excel;
import 'package:tesis_karina/utils/save_file_mobile.dart';

class ReporteProvider extends ChangeNotifier {
  Future<void> generateExcel() async {
    int x = 3;
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

    sheet1.getRangeByIndex(3, 1).text = "PD-01";
    sheet1.getRangeByIndex(3, 2).text = "F-01 FINCA POLIVIO";
    sheet1.getRangeByIndex(3, 2).text = "TN-01 TERRENO NORTE";
    sheet1.getRangeByIndex(3, 3).text = "20/01/2023";
    sheet1.getRangeByIndex(3, 4).text = "20/02/2023";
    sheet1.getRangeByIndex(3, 5).text = "U-01";
    sheet1.getRangeByIndex(3, 6).text = "SIN OBSERVACIONES";
    sheet1.getRangeByIndex(3, 7).text = "TERMINADO";

    sheet1.getRangeByIndex(4, 1).text = "PD-01";
    sheet1.getRangeByIndex(4, 2).text = "F-01 FINCA POLIVIO";
    sheet1.getRangeByIndex(4, 2).text = "TN-02 TERRENO SUR";
    sheet1.getRangeByIndex(4, 3).text = "20/01/2023";
    sheet1.getRangeByIndex(4, 4).text = "20/02/2023";
    sheet1.getRangeByIndex(4, 5).text = "U-01";
    sheet1.getRangeByIndex(4, 6).text =
        "LA TAREA SE CERRO CON ANTERIORIDAD POR UN CAMBIO DE CLIMA EN LAS PLANTACIONES";
    sheet1.getRangeByIndex(4, 7).text = "TERMINADO";

    sheet1.getRangeByIndex(5, 6).text = "RESULTADO";
    sheet1.getRangeByIndex(5, 7).text = "50%";

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    await FileSaveHelper.saveAndLaunchFile(bytes, 'OrdenesReport.xlsx');
  }

  Future<void> generateEnfAndPlagExcel() async {
    final excel.Workbook workbook = excel.Workbook(0);
    final excel.Worksheet sheet1 = workbook.worksheets.addWithName('Plagas');

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
}
