import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_streaming/app/constant/hive_table_constant.dart';
import 'package:music_streaming/features/playlist/domain/entity/playlist_entity.dart';
import 'package:music_streaming/features/song/data/model/song_hive_model.dart';

import 'package:uuid/uuid.dart';

part 'playlist_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.playlistTableId)
class PlaylistHiveModel extends Equatable {
  @HiveField(0)
  final String? playlistId;

  @HiveField(1)
  final String playlistName;

  @HiveField(2)
  final String? image;

  @HiveField(3)
  final List<SongHiveModel> song;

  @HiveField(4)
  final String createdBy;

  PlaylistHiveModel({
    String? playlistId,
    required this.playlistName,
    this.image,
    required this.song,
    required this.createdBy,
  }) : playlistId = playlistId ?? const Uuid().v4();

  const PlaylistHiveModel.initial()
      : playlistId = '',
        playlistName = '',
        image = '',
        song = const [],
        createdBy = '';

  /// Convert from Entity to Hive Model
  factory PlaylistHiveModel.fromEntity(PlaylistEntity entity) {
    return PlaylistHiveModel(
      playlistId: entity.playlistId,
      playlistName: entity.playlistName,
      image: entity.image,
      song: entity.song.map(SongHiveModel.fromEntity).toList(),
      createdBy: entity.createdBy,
    );
  }

  /// Convert from Hive Model to Entity
  PlaylistEntity toEntity() {
    return PlaylistEntity(
      playlistId: playlistId,
      playlistName: playlistName,
      image: image,
      song: song.map((model) => model.toEntity()).toList(),
      createdBy: createdBy,
    );
  }

  // To entityList

  static List<PlaylistEntity> toEntityList(List<PlaylistHiveModel> model) {
    return model.map((model) => model.toEntity()).toList();
  }

  @override
  List<Object?> get props => [
        playlistId,
        playlistName,
        image,
        song,
        createdBy,
      ];
}
