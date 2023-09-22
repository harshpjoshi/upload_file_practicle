// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_form.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UploadFormAdapter extends TypeAdapter<UploadForm> {
  @override
  final int typeId = 0;

  @override
  UploadForm read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UploadForm(
      isDownloadable: fields[0] as bool,
      description: fields[1] as String,
      file: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UploadForm obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.isDownloadable)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.file);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UploadFormAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
