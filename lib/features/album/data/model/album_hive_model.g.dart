// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlbumHiveModelAdapter extends TypeAdapter<AlbumHiveModel> {
  @override
  final int typeId = HiveTableConstant.albumTableId;

  @override
  AlbumHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlbumHiveModel(
      albumId: fields[0] as String?,
      albumName: fields[1] as String,
      artistName: fields[2] as String,
      albumImage: fields[3] as String?,
      albumImageUrl: fields[4] as String?,
      song: (fields[5] as List).cast<SongHiveModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, AlbumHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.albumId)
      ..writeByte(1)
      ..write(obj.albumName)
      ..writeByte(2)
      ..write(obj.artistName)
      ..writeByte(3)
      ..write(obj.albumImage)
      ..writeByte(4)
      ..write(obj.albumImageUrl)
      ..writeByte(5)
      ..write(obj.song);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlbumHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
