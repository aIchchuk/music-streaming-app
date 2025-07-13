// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongHiveModelAdapter extends TypeAdapter<SongHiveModel> {
  @override
  final int typeId = HiveTableConstant.songTableId; // Use same ID as annotated

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
      image: fields[3] as String?,
      audioUrl: fields[4] as String,
      albumName: fields[5] as String,
      duration: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SongHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.songId)
      ..writeByte(1)
      ..write(obj.songName)
      ..writeByte(2)
      ..write(obj.artistName)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.audioUrl)
      ..writeByte(5)
      ..write(obj.albumName)
      ..writeByte(6)
      ..write(obj.duration);
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