import 'package:equatable/equatable.dart';
import 'package:music_streaming/features/song/domain/entity/song_entity.dart';

class AlbumEntity extends Equatable {
  final String? albumId;
  final String albumName;
  final String artistName;
  final String? image;
  final String releaseYear;
  final List<SongEntity> song; // ✅ List of songs in the album

  const AlbumEntity({
    this.albumId,
    required this.albumName,
    required this.artistName,
    this.image,
    required this.releaseYear,
    required this.song,
  });

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
