import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:music_streaming/features/song/domain/entity/song_entity.dart';

part 'song_api_model.g.dart';

@JsonSerializable()
class SongApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? songId;

  final String songName;
  final String artistName;
  final String? songImage;
  final String? songImageUrl;
  final String? audioFile;
  final String? audioUrl;
  final String? albumName;
  final String? originalImageFileName;
  final String? originalAudioFileName;

  const SongApiModel({
    this.songId,
    required this.songName,
    required this.artistName,
    this.songImage,
    this.songImageUrl,
    this.audioFile,
    this.audioUrl,
    this.albumName,
    this.originalImageFileName,
    this.originalAudioFileName,
  });

  factory SongApiModel.fromJson(Map<String, dynamic> json) =>
      _$SongApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$SongApiModelToJson(this);

  // To Entity
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

  // From Entity
  factory SongApiModel.fromEntity(SongEntity entity) {
    return SongApiModel(
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
