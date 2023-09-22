import 'package:dartz/dartz.dart';
import 'package:upload_file_practicle/src/uploadform/data/modal/upload_form_modal.dart';

abstract class UploadFormLocalDataSource {
  Future<bool> initDb();
  Future<Unit> uploadForm(UploadFormModal modal);
}
