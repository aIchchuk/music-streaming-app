import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:music_streaming/features/album/domain/entity/album_entity.dart';
import 'package:music_streaming/features/song/data/model/song_api_model.dart';

part 'album_api_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AlbumApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? albumId;

  final String albumName;
  final String artistName;
  final String? albumImage;
  final String? albumImageUrl;
  final List<SongApiModel> song;

  const AlbumApiModel({
    this.albumId,
    required this.albumName,
    required this.artistName,
    this.albumImage,
    this.albumImageUrl,
    required this.song,
  });

  factory AlbumApiModel.fromJson(Map<String, dynamic> json) =>
      _$AlbumApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumApiModelToJson(this);

  factory AlbumApiModel.fromEntity(AlbumEntity entity) {
    return AlbumApiModel(
      albumId: entity.albumId,
      albumName: entity.albumName,
      artistName: entity.artistName,
      albumImage: entity.albumImage,
      albumImageUrl: entity.albumImageUrl,
      song: entity.song.map(SongApiModel.fromEntity).toList(),
    );
  }

  AlbumEntity toEntity() {
    return AlbumEntity(
      albumId: albumId,
      albumName: albumName,
      artistName: artistName,
      albumImage: albumImage,
      albumImageUrl: albumImageUrl,
      song: song.map((model) => model.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
        albumId,
        albumName,
        artistName,
        albumImage,
        albumImageUrl,
        song,
      ];
}
