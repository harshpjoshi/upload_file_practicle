import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:upload_file_practicle/core/usecases/usecase.dart';
import 'package:upload_file_practicle/core/utils/typedef.dart';
import 'package:upload_file_practicle/src/uploadform/domain/repositories/upload_repository.dart';

class UploadForm extends UseCaseWithParams<void, UploadFormParams> {
  UploadForm(this._repository);

  final UploadRepository _repository;

  @override
  ResultFuture call(UploadFormParams params) async => _repository.uploadForm(
      description: params.description,
      file: params.file,
      isDownloadable: params.isDownloadable,
      bytes: params.fileData);
}

class UploadFormParams extends Equatable {
  final bool isDownloadable;
  final String description;
  final String file;
  final Uint8List fileData;

  const UploadFormParams(
      {required this.isDownloadable,
      required this.description,
      required this.file,
      required this.fileData});

  @override
  List<Object?> get props => [isDownloadable, description, file, fileData];
}
