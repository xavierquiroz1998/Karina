import 'dart:convert';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_file/open_file.dart' as open_file;
import 'package:path_provider/path_provider.dart' as path_provider;
// ignore: depend_on_referenced_packages
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

///To save the Excel file in the device
///To save the Excel file in the device
class FileSaveHelper {
  static Future<void> saveAndLaunchFile(
      List<int> bytes, String fileName) async {
    //Get the storage folder location using path_provider package.
    String? path;
    if (Platform.isAndroid || Platform.isIOS) {
      final Directory directory =
          await path_provider.getApplicationSupportDirectory();
      path = directory.path;
    }

    final File file = File('$path/$fileName' ".xlsx");
    await file.writeAsBytes(bytes);

    if (Platform.isAndroid || Platform.isIOS) {
      await open_file.OpenFile.open('$path/$fileName');
    }
  }

  static Future<void> downloadFile(List<int> bytes, String fileName) async {
    final url = 'data:application/octet-stream;base64,${base64Encode(bytes)}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo descargar el archivo';
    }
  }
}
