import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming/features/song/domain/use_case/add_song_usecase.dart';
import 'package:music_streaming/features/song/domain/use_case/delete_song_usecase.dart';
import 'package:music_streaming/features/song/domain/use_case/get_song_usecase.dart';
import 'package:music_streaming/features/song/presentation/view_model/song_event.dart';
import 'package:music_streaming/features/song/presentation/view_model/song_state.dart';

class SongViewModel extends Bloc<SongEvent, SongState> {
  final GetSongUsecase getSongUsecase;
  final AddSongUsecase addSongUsecase;
  final DeleteSongUsecase deleteSongUsecase;

  SongViewModel({
    required this.getSongUsecase,
    required this.addSongUsecase,
    required this.deleteSongUsecase,
  }) : super(SongState.initial()) {
    on<LoadSongEvent>(_onLoadSongs);
    on<AddSongEvent>(_onAddSong);
    on<DeleteSongEvent>(_onDeleteSong);

    // Load songs when the ViewModel is initialized
    add(LoadSongEvent());
  }

  Future<void> _onLoadSongs(
    LoadSongEvent event,
    Emitter<SongState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await getSongUsecase();
    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
      (song) {
        emit(state.copyWith(song: song, isLoading: false));
      },
    );
  }

  Future<void> _onAddSong(
    AddSongEvent event,
    Emitter<SongState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 1));
    final result = await addSongUsecase(
      AddSongParams(songName: event.songName, artistName: '', audioUrl: ''),
    );
    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
      (success) {
        emit(state.copyWith(isLoading: false));
        add(LoadSongEvent());
      },
    );
  }

  Future<void> _onDeleteSong(
    DeleteSongEvent event,
    Emitter<SongState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 1));
    final result = await deleteSongUsecase(
      DeleteSongParams(songId: event.songId),
    );
    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
      (success) {
        emit(state.copyWith(isLoading: false));
        add(LoadSongEvent());
      },
    );
  }
}