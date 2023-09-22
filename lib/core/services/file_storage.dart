import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

// To save the file in the device
class FileStorage {
  static Future<String> getExternalDocumentPath() async {
    // To check whether permission is given for this app or not.
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      // If not we will ask for permission first
      await Permission.storage.request();
    }
    Directory _directory = Directory("");
    if (Platform.isAndroid) {
      // Redirects it to download folder in android
      _directory = Directory("/storage/emulated/0/Download");
    } else {
      _directory = await getApplicationDocumentsDirectory();
    }

    final exPath = _directory.path;
    print("Saved Path: $exPath");
    await Directory(exPath).create(recursive: true);
    return exPath;
  }

  static Future<String> get _localPath async {
    if (Platform.isAndroid) {
      final directory = await getExternalStorageDirectory();
      return directory?.path ?? "";
    } else {
      // To get the external path from device of download folder
      final String directory = await getExternalDocumentPath();
      return directory;
    }
  }

  static Future<File> writeFile(Uint8List bytes, String name) async {
    final path = await _localPath;
    // Create a file for the path of
    // device and file name with extension
    List<String> newNameList = name.split(".").toList();
    String newName =
        "${newNameList.first}_${DateTime.now()}.${newNameList.last}";
    File file = File('$path/$newName');

    print("Save file at ${file.path}");

    // Write the data in the file you have created
    return file.writeAsBytes(bytes);
  }
}
