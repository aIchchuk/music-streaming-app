import 'package:equatable/equatable.dart';


class SongEntity extends Equatable {
  final String? songId;
  final String songName;
  final String artistName;
  final String? image;
  final String audioUrl;
  final String? albumName;
  final String? duration;

  const SongEntity(
    {
      this.songId, 
      required this.songName,
      required this.artistName,
      this.image,
      required this.audioUrl,
      this.albumName,
      this.duration
    }
  );

  @override
  List<Object?> get props => [
    songId,
    songName,
    artistName,
    image,
    audioUrl,
    albumName,
    duration
    ];
}