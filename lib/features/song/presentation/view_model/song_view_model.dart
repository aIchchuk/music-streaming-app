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
import 'package:music_streaming/features/song/domain/use_case/upload_audio_file_usecase.dart';
import 'package:music_streaming/features/song/domain/use_case/upload_cover_image_usecase.dart';
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
  final UploadCoverImageUsecase uploadCoverImageUsecase;
  final UploadAudioFileUsecase uploadAudioFileUsecase;

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
    required this.uploadCoverImageUsecase,
    required this.uploadAudioFileUsecase,
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
    on<UploadSongCoverImageEvent>(_onUploadCoverImage);
    on<UploadSongAudioFileEvent>(_onUploadAudioFile);

    add(const GetAllSongEvent());
  }

  Future<void> _onGetAllSong(GetAllSongEvent event, Emitter<SongState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await getAllSongUsecase();
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (getAllSong) => emit(state.copyWith(isLoading: false, isSuccess: true, songList: getAllSong)),
    );
  }

  Future<void> _onCreateSong(CreateSongEvent event, Emitter<SongState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await createSongUsecase(
      CreateSongParams(
        songName: event.songName,
        artistName: event.artistName,
        albumName: event.albumName,
        songImage: state.songImageName,
        audioFile: state.audioFileName,
      ),
    );
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (_) => add(const GetAllSongEvent()),
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
      (getFeaturedSong) => emit(state.copyWith(isLoading: false, isSuccess: true, songList: getFeaturedSong)),
    );
  }

  Future<void> _onGetMadeForYouSong(GetMadeForYouSongEvent event, Emitter<SongState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await getMadeForYouSongUsecase();
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (getMadeForYouSong) => emit(state.copyWith(isLoading: false, isSuccess: true, songList: getMadeForYouSong)),
    );
  }

  Future<void> _onGetTrendingSong(GetTrendingSongEvent event, Emitter<SongState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await getTrendingSongUsecase();
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (getTrendingSong) => emit(state.copyWith(isLoading: false, isSuccess: true, songList: getTrendingSong)),
    );
  }

  Future<void> _onGetSongById(GetSongByIdEvent event, Emitter<SongState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await getSongByIdUsecase(event.songId);
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (songById) => emit(state.copyWith(isLoading: false, isSuccess: true, selectedSong: songById,)),
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

  Future<void> _onUploadCoverImage(UploadSongCoverImageEvent event, Emitter<SongState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await uploadCoverImageUsecase(UploadCoverImageParams(songImageFile: event.songImage));
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (imageUrl) => emit(state.copyWith(isLoading: false, isSuccess: true, songImageName: imageUrl)),
    );
  }

  Future<void> _onUploadAudioFile(UploadSongAudioFileEvent event, Emitter<SongState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await uploadAudioFileUsecase(UploadAudioFileParams(audioFile: event.audioFile));
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (audioUrl) => emit(state.copyWith(isLoading: false, isSuccess: true, audioFileName: audioUrl)),
    );
  }
}
