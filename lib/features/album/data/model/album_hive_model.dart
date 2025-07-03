import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:music_streaming/app/constant/hive_table_constant.dart';
import 'package:music_streaming/features/song/data/model/song_hive_model.dart';
import 'package:music_streaming/features/album/domain/entity/album_entity.dart';

part 'album_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.albumTableId)
class AlbumHiveModel extends Equatable {
  @HiveField(0)
  final String? albumId;

  @HiveField(1)
  final String albumName;

  @HiveField(2)
  final String artistName;

  @HiveField(3)
  final String? image;

  @HiveField(4)
  final String releaseYear;

  @HiveField(5)
  final List<SongHiveModel> song;

  AlbumHiveModel({
    String? albumId,
    required this.albumName,
    required this.artistName,
    this.image,
    required this.releaseYear,
    required this.song,
  }) : albumId = albumId ?? const Uuid().v4();

  const AlbumHiveModel.initial()
      : albumId = '',
        albumName = '',
        artistName = '',
        image = '',
        releaseYear = '',
        song = const [];

  /// From Entity → Hive Model
  factory AlbumHiveModel.fromEntity(AlbumEntity entity) {
    return AlbumHiveModel(
      albumId: entity.albumId,
      albumName: entity.albumName,
      artistName: entity.artistName,
      image: entity.image,
      releaseYear: entity.releaseYear,
      song: entity.song.map(SongHiveModel.fromEntity).toList(),
    );
  }

  /// From Hive Model → Entity
  AlbumEntity toEntity() {
    return AlbumEntity(
      albumId: albumId,
      albumName: albumName,
      artistName: artistName,
      image: image,
      releaseYear: releaseYear,
      song: song.map((model) => model.toEntity()).toList(),
    );
  }

  // To entityList

  static List<AlbumEntity> toEntityList(List<AlbumHiveModel> model) {
    return model.map((model) => model.toEntity()).toList();
  }

  @override
  List<Object?> get props => [
        albumId,
        albumName,
        artistName,
        image,
        releaseYear,
        song,
      ];
}
