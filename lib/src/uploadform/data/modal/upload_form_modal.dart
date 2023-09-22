import 'dart:convert';

import 'package:upload_file_practicle/core/utils/typedef.dart';
import 'package:upload_file_practicle/src/uploadform/domain/entities/upload_form_entity.dart';

class UploadFormModal extends UploadFormEntity {
  const UploadFormModal({
    required super.description,
    required super.file,
    required super.isDownloadable,
  });

  factory UploadFormModal.fromJson(String source) =>
      UploadFormModal.fromMap(jsonDecode(source) as DataMap);

  UploadFormModal.fromMap(DataMap map)
      : this(
          description: map['description'] as String,
          isDownloadable: map['isDownloadable'] as bool,
          file: map['file'] as String,
        );

  DataMap toMap() => {
        'description': description,
        'isDownloadable': isDownloadable,
        'file': file,
      };

  String toJson() => jsonEncode(toMap());

  UploadFormModal copyWith({
    String? description,
    bool? isDownloadable,
    String? file,
  }) {
    return UploadFormModal(
      isDownloadable: isDownloadable ?? this.isDownloadable,
      file: file ?? this.file,
      description: description ?? this.description,
    );
  }
}
