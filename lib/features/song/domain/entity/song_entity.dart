import 'package:equatable/equatable.dart';

class SongEntity extends Equatable {
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

  const SongEntity({
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
