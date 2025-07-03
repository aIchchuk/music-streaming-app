import 'package:equatable/equatable.dart';
import 'package:music_streaming/features/song/domain/entity/song_entity.dart';

class PlaylistEntity extends Equatable {
  final String? playlistId;
  final String playlistName;
  final String? image;
  final List<SongEntity> song; // ✅ List of songs
  final String createdBy;

  const PlaylistEntity({
    this.playlistId,
    required this.playlistName,
    this.image,
    required this.song,
    required this.createdBy,
  });

  @override
  List<Object?> get props => [
        playlistId,
        playlistName,
        image,
        song,
        createdBy,
      ];
}
