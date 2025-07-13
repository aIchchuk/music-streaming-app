import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_streaming/app/constant/hive_table_constant.dart';
import 'package:music_streaming/features/song/domain/entity/song_entity.dart';
import 'package:uuid/uuid.dart';

// Adapter
part 'song_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.songTableId)
class SongHiveModel extends Equatable {
  @HiveField(0)
  final String? songId;

  @HiveField(1)
  final String songName;

  @HiveField(2)
  final String artistName;

  @HiveField(3)
  final String? image;

  @HiveField(4)
  final String audioUrl;

  @HiveField(5)
  final String albumName;

  @HiveField(6)
  final String? duration;

  SongHiveModel({
    String? songId,
    required this.songName,
    required this.artistName,
    this.image,
    required this.audioUrl,
    required this.albumName,
    this.duration,
  }) : songId = songId ?? const Uuid().v4();

  const SongHiveModel.initial()
      : songId = '',
        songName = '',
        artistName = '',
        image = '',
        audioUrl = '',
        albumName = '',
        duration = '';

  /// Convert from Entity to Hive Model
  factory SongHiveModel.fromEntity(SongEntity entity) {
    return SongHiveModel(
      songId: entity.songId,
      songName: entity.songName,
      artistName: entity.artistName,
      image: entity.image,
      audioUrl: entity.audioUrl,
      albumName: entity.albumName ?? '',
      duration: entity.duration,
    );
  }

  /// Convert from Hive Model to Entity
  SongEntity toEntity() {
    return SongEntity(
      songId: songId,
      songName: songName,
      artistName: artistName,
      image: image,
      audioUrl: audioUrl,
      albumName: albumName.isEmpty ? null : albumName,
      duration: duration,
    );
  }

  // To entityList

  static List<SongEntity> toEntityList(List<SongHiveModel> model) {
    return model.map((model) => model.toEntity()).toList();
  }

  @override
  List<Object?> get props => [
        songId,
        songName,
        artistName,
        image,
        audioUrl,
        albumName,
        duration,
      ];
}