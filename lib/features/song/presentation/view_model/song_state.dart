import 'package:equatable/equatable.dart';
import 'package:music_streaming/features/song/domain/entity/song_entity.dart';

class SongState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final List<SongEntity> songList;
  final SongEntity? selectedSong;
  final String? songImageName;
  final String? audioFileName;
  final String? errorMessage;
  

  const SongState({
    required this.isLoading,
    required this.isSuccess,
    required this.songList,
    this.selectedSong,
    this.songImageName,
    this.audioFileName,
    this.errorMessage,
  });

  const SongState.initial()
      : isLoading = false,
        isSuccess = false,
        songList = const [],
        selectedSong = null,
        songImageName = null,
        audioFileName = null,
        errorMessage = null;

  SongState copyWith({
    bool? isLoading,
    bool? isSuccess,
    List<SongEntity>? songList,
    SongEntity? selectedSong,
    String? songImageName,
    String? audioFileName,
    String? errorMessage,
  }) {
    return SongState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      songList: songList ?? this.songList,
      selectedSong: selectedSong ?? this.selectedSong,
      songImageName: songImageName ?? this.songImageName,
      audioFileName: audioFileName ?? this.audioFileName,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        songList,
        selectedSong,
        songImageName,
        audioFileName,
        errorMessage,
      ];
}
