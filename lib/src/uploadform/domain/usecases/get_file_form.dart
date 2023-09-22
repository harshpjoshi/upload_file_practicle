import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:upload_file_practicle/core/errors/failure.dart';
import 'package:upload_file_practicle/core/services/file_storage.dart';
import 'package:upload_file_practicle/core/usecases/usecase.dart';
import 'package:upload_file_practicle/core/utils/typedef.dart';

class GetFormFile extends UseCaseWithOutParams<File> {
  @override
  ResultFuture<File> call() async {
    String path = await FileStorage.getExternalDocumentPath();

    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.any);

    if (result != null) {
      String? path = result.files.single.path;
      if (path != null) {
        File file = File(path);
        return Right(file);
      } else {
        return const Left(LocalFailure(message: 'File not found.'));
      }
    } else {
      // User canceled the picker
      return const Left(
          LocalFailure(message: 'File picking canceled by user.'));
    }
  }
}
