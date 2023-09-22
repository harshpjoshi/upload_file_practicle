import 'package:equatable/equatable.dart';

class UploadFormEntity extends Equatable {
  final bool isDownloadable;
  final String description;
  final String file;

  const UploadFormEntity({
    required this.isDownloadable,
    required this.description,
    required this.file,
  });

  @override
  List<Object?> get props => [isDownloadable, description, file];
}
