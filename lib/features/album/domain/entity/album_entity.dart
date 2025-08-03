import 'package:equatable/equatable.dart';
import 'package:music_streaming/features/song/domain/entity/song_entity.dart';

class AlbumEntity extends Equatable {
  final String? albumId;
  final String albumName;
  final String artistName;
  final String? albumImage;     // Local file path
  final String? albumImageUrl;  // External URL
  final List<SongEntity> song;  // Referenced song list

  const AlbumEntity({
    this.albumId,
    required this.albumName,
    required this.artistName,
    this.albumImage,
    this.albumImageUrl,
    required this.song,
  });

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
