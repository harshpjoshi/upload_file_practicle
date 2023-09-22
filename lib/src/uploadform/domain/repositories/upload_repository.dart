import 'dart:typed_data';

import 'package:upload_file_practicle/core/utils/typedef.dart';

abstract class UploadRepository {
  const UploadRepository();

  ResultVoid uploadForm({
    required final bool isDownloadable,
    required final String description,
    required final String file,
    required final Uint8List bytes,
  });
}
