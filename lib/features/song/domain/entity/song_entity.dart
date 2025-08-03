import 'package:equatable/equatable.dart';

class SongEntity extends Equatable {
  final String? songId;
  final String songName;
  final String artistName;
  final String? songImage;         // Optional local file path or URL
  final String? songImageUrl;      // Optional image URL
  final String? audioFile;         // Optional local file path or URL
  final String? audioUrl;          // Optional audio URL
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
