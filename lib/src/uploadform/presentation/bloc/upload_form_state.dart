part of 'upload_form_bloc.dart';

abstract class UploadFormState extends Equatable {
  final File? file;
  const UploadFormState({this.file});

  @override
  List<Object> get props => [];
}

class UploadFormInitial extends UploadFormState {
  @override
  List<Object> get props => [];
}

class Uploading extends UploadFormState {
  const Uploading() : super(file: null);
}

class Uploaded extends UploadFormState {
  const Uploaded(this.message) : super(file: null);

  final String message;
}

class UploadFailed extends UploadFormState {
  const UploadFailed(this.message) : super(file: null);

  final String message;
}

class PickingFile extends UploadFormState {}

class PickedFile extends UploadFormState {
  PickedFile(this.file) : super(file: file);

  final File file;
}

class FilePickFailed extends UploadFormState {
  const FilePickFailed(this.message);
  final String message;
}
