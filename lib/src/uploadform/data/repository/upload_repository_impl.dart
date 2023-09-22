import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:path/path.dart';
import 'package:upload_file_practicle/core/errors/failure.dart';
import 'package:upload_file_practicle/core/errors/local_exception.dart';
import 'package:upload_file_practicle/core/services/file_storage.dart';
import 'package:upload_file_practicle/core/utils/typedef.dart';
import 'package:upload_file_practicle/src/uploadform/data/datasources/upload_form_local_data_source.dart';
import 'package:upload_file_practicle/src/uploadform/data/modal/upload_form_modal.dart';
import 'package:upload_file_practicle/src/uploadform/domain/repositories/upload_repository.dart';

class UploadRepositoryImpl implements UploadRepository {
  final UploadFormLocalDataSource uploadFormLocalDataSource;

  const UploadRepositoryImpl({required this.uploadFormLocalDataSource});

  @override
  ResultVoid uploadForm(
      {required bool isDownloadable,
      required String description,
      required String file,
      required Uint8List bytes}) async {
    try {
      await FileStorage.writeFile(bytes, basename(file));
      await uploadFormLocalDataSource.uploadForm(
        UploadFormModal(
            description: description,
            file: file,
            isDownloadable: isDownloadable),
      );
      return const Right(null);
    } on LocalException catch (e) {
      return Left(
        LocalFailure.fromException(e),
      );
    }
  }
}
