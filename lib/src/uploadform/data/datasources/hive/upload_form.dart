import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'upload_form.g.dart';

@HiveType(typeId: 0)
class UploadForm {
  @HiveField(0)
  final bool isDownloadable;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String file;

  UploadForm({
    required this.isDownloadable,
    required this.description,
    required this.file,
  });
}
