import 'package:equatable/equatable.dart';
import 'package:music_streaming/features/song/domain/entity/song_entity.dart';


class SongState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final List<SongEntity> songList;
  final SongEntity? selectedSong;
  final String? errorMessage;

  /// New flag to indicate whether the songs should be displayed (after pressing button)
  final bool hasFetchedSongs;

  const SongState({
    required this.isLoading,
    required this.isSuccess,
    required this.songList,
    this.selectedSong,
    this.errorMessage,
    this.hasFetchedSongs = false,   // Default to false
  });

  const SongState.initial()
      : isLoading = false,
        isSuccess = false,
        songList = const [],
        selectedSong = null,
        errorMessage = null,
        hasFetchedSongs = false;

  SongState copyWith({
    bool? isLoading,
    bool? isSuccess,
    List<SongEntity>? songList,
    SongEntity? selectedSong,
    String? errorMessage,
    bool? hasFetchedSongs,
  }) {
    return SongState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      songList: songList ?? this.songList,
      selectedSong: selectedSong ?? this.selectedSong,
      errorMessage: errorMessage,
      hasFetchedSongs: hasFetchedSongs ?? this.hasFetchedSongs,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        songList,
        selectedSong,
        errorMessage,
        hasFetchedSongs,
      ];
}
