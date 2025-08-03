import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_streaming/app/constant/hive_table_constant.dart';
import 'package:music_streaming/features/song/domain/entity/song_entity.dart';
import 'package:uuid/uuid.dart';

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
  final String? songImage;

  @HiveField(4)
  final String? songImageUrl;

  @HiveField(5)
  final String? audioFile;

  @HiveField(6)
  final String? audioUrl;

  @HiveField(7)
  final String? albumName;

  @HiveField(8)
  final String? originalImageFileName;

  @HiveField(9)
  final String? originalAudioFileName;

  SongHiveModel({
    String? songId,
    required this.songName,
    required this.artistName,
    this.songImage,
    this.songImageUrl,
    this.audioFile,
    this.audioUrl,
    this.albumName,
    this.originalImageFileName,
    this.originalAudioFileName,
  }) : songId = songId ?? const Uuid().v4();

  const SongHiveModel.initial()
      : songId = '',
        songName = '',
        artistName = '',
        songImage = '',
        songImageUrl = '',
        audioFile = '',
        audioUrl = '',
        albumName = '',
        originalImageFileName = '',
        originalAudioFileName = '';

  factory SongHiveModel.fromEntity(SongEntity entity) {
    return SongHiveModel(
      songId: entity.songId,
      songName: entity.songName,
      artistName: entity.artistName,
      songImage: entity.songImage,
      songImageUrl: entity.songImageUrl,
      audioFile: entity.audioFile,
      audioUrl: entity.audioUrl,
      albumName: entity.albumName,
      originalImageFileName: entity.originalImageFileName,
      originalAudioFileName: entity.originalAudioFileName,
    );
  }

  SongEntity toEntity() {
    return SongEntity(
      songId: songId,
      songName: songName,
      artistName: artistName,
      songImage: songImage,
      songImageUrl: songImageUrl,
      audioFile: audioFile,
      audioUrl: audioUrl,
      albumName: albumName,
      originalImageFileName: originalImageFileName,
      originalAudioFileName: originalAudioFileName,
    );
  }

  @override
  List<Object?> get props => [
        songId,
        songName,
        artistName,
        songImage,
        songImageUrl,
        audioFile,
        audioUrl,
        albumName,
        originalImageFileName,
        originalAudioFileName,
      ];
}
