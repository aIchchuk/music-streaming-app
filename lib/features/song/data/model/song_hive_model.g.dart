// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongHiveModelAdapter extends TypeAdapter<SongHiveModel> {
  @override
  final int typeId = HiveTableConstant.songTableId;

  @override
  SongHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongHiveModel(
      songId: fields[0] as String?,
      songName: fields[1] as String,
      artistName: fields[2] as String,
      songImage: fields[3] as String?,
      songImageUrl: fields[4] as String?,
      audioFile: fields[5] as String?,
      audioUrl: fields[6] as String?,
      albumName: fields[7] as String?,
      originalImageFileName: fields[8] as String?,
      originalAudioFileName: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SongHiveModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.songId)
      ..writeByte(1)
      ..write(obj.songName)
      ..writeByte(2)
      ..write(obj.artistName)
      ..writeByte(3)
      ..write(obj.songImage)
      ..writeByte(4)
      ..write(obj.songImageUrl)
      ..writeByte(5)
      ..write(obj.audioFile)
      ..writeByte(6)
      ..write(obj.audioUrl)
      ..writeByte(7)
      ..write(obj.albumName)
      ..writeByte(8)
      ..write(obj.originalImageFileName)
      ..writeByte(9)
      ..write(obj.originalAudioFileName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
