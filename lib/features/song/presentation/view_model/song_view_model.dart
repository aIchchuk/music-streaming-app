import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming/features/song/domain/use_case/create_song_usecase.dart';
import 'package:music_streaming/features/song/domain/use_case/delete_song_usecase.dart';
import 'package:music_streaming/features/song/domain/use_case/get_all_song_usecase.dart';
import 'package:music_streaming/features/song/domain/use_case/get_featured_song_usecase.dart';
import 'package:music_streaming/features/song/domain/use_case/get_made_for_you_song_usecase.dart';
import 'package:music_streaming/features/song/domain/use_case/get_song_by_id_usecase.dart';
import 'package:music_streaming/features/song/domain/use_case/get_song_by_name_usecase.dart';
import 'package:music_streaming/features/song/domain/use_case/get_trending_song_usecase.dart';
import 'package:music_streaming/features/song/domain/use_case/update_song_usecase.dart';
import 'package:music_streaming/features/song/presentation/view_model/song_event.dart';
import 'package:music_streaming/features/song/presentation/view_model/song_state.dart';


class SongViewModel extends Bloc<SongEvent, SongState> {
  final GetAllSongUsecase getAllSongUsecase;
  final CreateSongUsecase createSongUsecase;
  final DeleteSongUsecase deleteSongUsecase;
  final GetFeaturedSongUsecase getFeaturedSongUsecase;
  final GetMadeForYouSongUsecase getMadeForYouSongUsecase;
  final GetTrendingSongUsecase getTrendingSongUsecase;
  final GetSongByIdUsecase getSongByIdUsecase;
  final GetSongByNameUsecase getSongByNameUsecase;
  final UpdateSongUsecase updateSongUsecase;

  SongViewModel({
    required this.getAllSongUsecase,
    required this.createSongUsecase,
    required this.deleteSongUsecase,
    required this.getFeaturedSongUsecase,
    required this.getMadeForYouSongUsecase,
    required this.getTrendingSongUsecase,
    required this.getSongByIdUsecase,
    required this.getSongByNameUsecase,
    required this.updateSongUsecase,
  }) : super(const SongState.initial()) {
    on<GetAllSongEvent>(_onGetAllSong);
    on<CreateSongEvent>(_onCreateSong);
    on<DeleteSongEvent>(_onDeleteSong);
    on<GetFeaturedSongEvent>(_onGetFeaturedSong);
    on<GetMadeForYouSongEvent>(_onGetMadeForYouSong);
    on<GetTrendingSongEvent>(_onGetTrendingSong);
    on<GetSongByIdEvent>(_onGetSongById);
    on<GetSongByNameEvent>(_onGetSongByName);
    on<UpdateSongEvent>(_onUpdateSong);

    add(const GetAllSongEvent());
  }

  Future<void> _onGetAllSong(GetAllSongEvent event, Emitter<SongState> emit) async {
    emit(state.copyWith(
      isLoading: false,
      errorMessage: null,
    ));

    final result = await getAllSongUsecase();

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
        hasFetchedSongs: false,
      )),
      (songs) => emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        songList: songs,
        errorMessage: null,
        hasFetchedSongs: true,
      )),
    );
  }


  Future<void> _onCreateSong(CreateSongEvent event, Emitter<SongState> emit) async {
    emit(state.copyWith(isLoading: true));

    final params = CreateSongParams(
      songName: event.songName,
      artistName: event.artistName,
      albumName: event.albumName,
      songImage: event.songImage,
      audioFile: event.audioFile,
    );

    final result = await createSongUsecase(params);

    await result.fold(
      (failure) async {
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
      (_) async {
        // Instead of add(), call the _onGetAllSong method directly and await it
        await _onGetAllSong(const GetAllSongEvent(), emit);
      },
    );
  }


  Future<void> _onDeleteSong(DeleteSongEvent event, Emitter<SongState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await deleteSongUsecase(event.songId);
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (_) => add(const GetAllSongEvent()),
    );
  }

  Future<void> _onGetFeaturedSong(GetFeaturedSongEvent event, Emitter<SongState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await getFeaturedSongUsecase();
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (songs) => emit(state.copyWith(isLoading: false, isSuccess: true, songList: songs)),
    );
  }

  Future<void> _onGetMadeForYouSong(GetMadeForYouSongEvent event, Emitter<SongState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await getMadeForYouSongUsecase();
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (songs) => emit(state.copyWith(isLoading: false, isSuccess: true, songList: songs)),
    );
  }

  Future<void> _onGetTrendingSong(GetTrendingSongEvent event, Emitter<SongState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await getTrendingSongUsecase();
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (songs) => emit(state.copyWith(isLoading: false, isSuccess: true, songList: songs)),
    );
  }

  Future<void> _onGetSongById(GetSongByIdEvent event, Emitter<SongState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await getSongByIdUsecase(event.songId);
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (song) => emit(state.copyWith(isLoading: false, isSuccess: true, selectedSong: song)),
    );
  }

  Future<void> _onGetSongByName(GetSongByNameEvent event, Emitter<SongState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await getSongByNameUsecase(event.songName);
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (songs) => emit(state.copyWith(isLoading: false, isSuccess: true, songList: songs)),
    );
  }

  Future<void> _onUpdateSong(UpdateSongEvent event, Emitter<SongState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await updateSongUsecase(event.song);
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (_) => add(const GetAllSongEvent()),
    );
  }
}
