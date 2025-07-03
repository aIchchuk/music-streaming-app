// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaylistHiveModelAdapter extends TypeAdapter<PlaylistHiveModel> {
  @override
  final int typeId = HiveTableConstant.playlistTableId; // Use your constant

  @override
  PlaylistHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlaylistHiveModel(
      playlistId: fields[0] as String?,
      playlistName: fields[1] as String,
      image: fields[2] as String?,
      song: (fields[3] as List).cast<SongHiveModel>(),
      createdBy: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PlaylistHiveModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.playlistId)
      ..writeByte(1)
      ..write(obj.playlistName)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.song)
      ..writeByte(4)
      ..write(obj.createdBy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaylistHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
