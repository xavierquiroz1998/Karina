import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_officechart/officechart.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as excel;
import 'package:tesis_karina/utils/save_file_mobile.dart';

class ReporteProvider extends ChangeNotifier {
  Future<void> generateExcel() async {
    int x = 3;
    final excel.Workbook workbook = excel.Workbook(0);
    final excel.Worksheet sheet1 = workbook.worksheets.addWithName('Reportes');

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
    sheet1.getRangeByIndex(2, 1).text = 'ANIO';
    sheet1.getRangeByIndex(2, 2).text = 'MES';
    sheet1.getRangeByIndex(2, 3).text = 'TIPOSUST';
    sheet1.getRangeByIndex(2, 4).text = 'DEVIVA';
    sheet1.getRangeByIndex(2, 5).text = 'TIPOSEC';
    sheet1.getRangeByIndex(2, 6).text = 'CEDULA';
    sheet1.getRangeByIndex(2, 7).text = 'TIPOVTARET';
    sheet1.getRangeByIndex(2, 8).text = 'FECHA_REG';
    sheet1.getRangeByIndex(2, 9).text = 'SERIE_FAC';
    sheet1.getRangeByIndex(2, 10).text = 'NUM_FAC';

/*     for (var element in listExcel) {
      sheet1.getRangeByIndex(x, 1).text = element.substring(0, 4);
      x++;
    } */

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    await FileSaveHelper.saveAndLaunchFile(bytes, 'ExpensesReport.xlsx');
  }

  Future<void> generarChart() async {
    // Create a new Excel document.
    final excel.Workbook workbook = excel.Workbook();

// Accessing worksheet via index.
    final excel.Worksheet sheet = workbook.worksheets[0];

// Setting value in the cell.
    sheet.getRangeByName('A1').setText('John');
    sheet.getRangeByName('A2').setText('Amy');
    sheet.getRangeByName('A3').setText('Jack');
    sheet.getRangeByName('A4').setText('Tiya');
    sheet.getRangeByName('B1').setNumber(10);
    sheet.getRangeByName('B2').setNumber(12);
    sheet.getRangeByName('B3').setNumber(20);
    sheet.getRangeByName('B4').setNumber(21);

// Create an instances of chart collection.
    final ChartCollection charts = ChartCollection(sheet);

// Add the chart.
    final Chart chart = charts.add();

// Set Chart Type.
    chart.chartType = ExcelChartType.column;

// Set data range in the worksheet.
    chart.dataRange = sheet.getRangeByName('A1:B4');

// set charts to worksheet.
    sheet.charts = charts;

// save and dispose the workbook.
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    await FileSaveHelper.saveAndLaunchFile(bytes, 'Chart');
  }

  bool isNumber(String number) {
    bool result = false;
    try {
      final x = number.trim();
      double.parse(x);
      result = true;
    } catch (e) {
      result = false;
    }
    return result;
  }
}
