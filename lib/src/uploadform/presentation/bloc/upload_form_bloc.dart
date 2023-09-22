import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:upload_file_practicle/src/uploadform/domain/usecases/get_file_form.dart';
import 'package:upload_file_practicle/src/uploadform/domain/usecases/upload_form.dart';

part 'upload_form_event.dart';
part 'upload_form_state.dart';

class UploadFormBloc extends Bloc<UploadFormEvent, UploadFormState> {
  UploadFormBloc({
    required UploadForm uploadForm,
    required GetFormFile getFormFile,
  })  : _uploadForm = uploadForm,
        _getFormFile = getFormFile,
        super(UploadFormInitial()) {
    on<UploadFormData>(_uploadFromDataHandler);
    on<GetFile>(_getFileDataHandler);
  }

  final UploadForm _uploadForm;
  final GetFormFile _getFormFile;

  Future<void> _getFileDataHandler(
      GetFile event, Emitter<UploadFormState> emit) async {
    final result = await _getFormFile();

    result.fold(
      (failure) => emit(
        FilePickFailed(failure.errorMessage),
      ),
      (file) => emit(
        PickedFile(file),
      ),
    );
  }

  Future<void> _uploadFromDataHandler(
      UploadFormData event, Emitter<UploadFormState> emit) async {
    emit(const Uploading());

    Uint8List bytes = await event.file.readAsBytes();

    final result = await _uploadForm(
      UploadFormParams(
          isDownloadable: event.isDownloadable,
          description: event.description,
          file: event.file.path,
          fileData: bytes),
    );

    result.fold(
      (failure) => emit(
        UploadFailed(failure.errorMessage),
      ),
      (_) => emit(
        const Uploaded("Successfully Uploaded."),
      ),
    );
  }
}
