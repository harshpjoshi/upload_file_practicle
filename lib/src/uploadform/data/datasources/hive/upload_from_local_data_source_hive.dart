import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:upload_file_practicle/core/errors/local_exception.dart';
import 'package:upload_file_practicle/src/uploadform/data/datasources/hive/upload_form.dart';
import 'package:upload_file_practicle/src/uploadform/data/datasources/upload_form_local_data_source.dart';
import 'package:upload_file_practicle/src/uploadform/data/modal/upload_form_modal.dart';

class UploadFormLocalDataSourceHive implements UploadFormLocalDataSource {
  final _kUploadFromBox = 'upload_form_box';

  @override
  Future<bool> initDb() async {
    try {
      if (!foundation.kIsWeb) {
        final appDocumentDir = await getApplicationDocumentsDirectory();
        Hive.init(appDocumentDir.path);
      }
      Hive.registerAdapter(UploadFormAdapter());
      await Hive.openBox<UploadForm>(_kUploadFromBox);
      return true;
    } catch (e) {
      throw const LocalException(message: "Hive initialization failed");
    }
  }

  @override
  Future<Unit> uploadForm(UploadFormModal modal) async {
    try {
      final tasksBox = Hive.box<UploadForm>(_kUploadFromBox);
      final convertedTask = UploadForm(
          file: modal.file,
          description: modal.description,
          isDownloadable: modal.isDownloadable);
      await tasksBox.add(convertedTask);
      return Future.value(unit);
    } catch (_) {
      throw const LocalException(message: "Hive Insert Failed");
    }
  }
}
