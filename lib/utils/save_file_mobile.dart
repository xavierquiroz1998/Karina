import 'dart:io';
import 'package:open_file/open_file.dart' as open_file;
import 'package:path_provider/path_provider.dart' as path_provider;

class FileSaveHelper {
  static Future<void> saveAndLaunchFile(
      List<int> bytes, String fileName) async {
    String? path;
    if (Platform.isAndroid || Platform.isIOS) {
      final Directory? directory =
          await path_provider.getExternalStorageDirectory();
      path = directory!.path;
    }

    final File file = File('$path/$fileName');

    await file.writeAsBytes(bytes);

    if (Platform.isAndroid || Platform.isIOS) {
      await open_file.OpenFile.open('$path/$fileName');
    }
  }
}
