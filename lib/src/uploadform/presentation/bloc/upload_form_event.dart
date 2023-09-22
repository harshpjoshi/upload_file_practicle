part of 'upload_form_bloc.dart';

abstract class UploadFormEvent extends Equatable {
  const UploadFormEvent();

  @override
  List<Object> get props => [];
}

class UploadFormData extends UploadFormEvent {
  const UploadFormData(
      {required this.description,
      required this.isDownloadable,
      required this.file});

  final String description;
  final bool isDownloadable;
  final File file;
}

class GetFile extends UploadFormEvent {}
