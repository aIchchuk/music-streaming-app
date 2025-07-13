import 'package:equatable/equatable.dart';
import 'package:music_streaming/features/song/domain/entity/song_entity.dart';

class SongState extends Equatable{
  final bool isLoading;
  final List<SongEntity> song;
  final String? errorMessage;
  

  const SongState({required this.isLoading, required this.song, this.errorMessage});


  // initial Constructor
  SongState.initial() : song = [], isLoading = false, errorMessage = null;

  // copyState
  SongState copyWith({
    bool? isLoading,
    List<SongEntity>? song,
    String? errorMessage,
  }) {
    return SongState(
      isLoading: isLoading ?? this.isLoading,
      song: song ?? this.song,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }


  @override
  List<Object?> get props => [isLoading, song, errorMessage];

  

}