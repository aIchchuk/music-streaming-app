import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming/features/album/domain/use_case/create_album_usecase.dart';
import 'package:music_streaming/features/album/domain/use_case/delete_album_usecase.dart';
import 'package:music_streaming/features/album/domain/use_case/get_all_album_usecase.dart';
import 'package:music_streaming/features/album/domain/use_case/get_album_by_id_usecase.dart';
import 'package:music_streaming/features/album/domain/use_case/add_song_to_album_usecase.dart';
import 'package:music_streaming/features/album/domain/use_case/remove_song_from_album_usecase.dart' hide AddRemoveSongParams;
import 'package:music_streaming/features/album/domain/use_case/update_album_usecase.dart';
import 'package:music_streaming/features/album/presentation/view_model/album_event.dart';
import 'package:music_streaming/features/album/presentation/view_model/album_state.dart';

import 'package:music_streaming/features/album/domain/use_case/add_song_to_album_usecase.dart' as add_usecase;
import 'package:music_streaming/features/album/domain/use_case/remove_song_from_album_usecase.dart' as remove_usecase;

class AlbumViewModel extends Bloc<AlbumEvent, AlbumState> {
  final GetAllAlbumUsecase getAllAlbumUsecase;
  final CreateAlbumUsecase createAlbumUsecase;
  final DeleteAlbumUsecase deleteAlbumUsecase;
  final GetAlbumByIdUsecase getAlbumByIdUsecase;
  final AddSongToAlbumUsecase addSongToAlbumUsecase;
  final RemoveSongFromAlbumUsecase removeSongFromAlbumUsecase;
  final UpdateAlbumUsecase updateAlbumUsecase;

  AlbumViewModel({
    required this.getAllAlbumUsecase,
    required this.createAlbumUsecase,
    required this.deleteAlbumUsecase,
    required this.getAlbumByIdUsecase,
    required this.addSongToAlbumUsecase,
    required this.removeSongFromAlbumUsecase,
    required this.updateAlbumUsecase,
  }) : super(const AlbumState.initial()) {
    on<GetAllAlbumEvent>(_onGetAllAlbum);
    on<CreateAlbumEvent>(_onCreateAlbum);
    on<DeleteAlbumEvent>(_onDeleteAlbum);
    on<GetAlbumByIdEvent>(_onGetAlbumById);
    on<AddSongToAlbumEvent>(_onAddSongToAlbum);
    on<RemoveSongFromAlbumEvent>(_onRemoveSongFromAlbum);
    on<UpdateAlbumEvent>(_onUpdateAlbum);

    add(const GetAllAlbumEvent());
  }

  Future<void> _onGetAllAlbum(GetAllAlbumEvent event, Emitter<AlbumState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await getAllAlbumUsecase();

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
        hasFetchedAlbums: false,
      )),
      (albums) => emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        albumList: albums,
        errorMessage: null,
        hasFetchedAlbums: true,
      )),
    );
  }

  Future<void> _onCreateAlbum(CreateAlbumEvent event, Emitter<AlbumState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    // Create params from event properties (notice event fields, no direct AlbumEntity)
    final params = CreateAlbumParams(
      albumName: event.albumName,
      artistName: event.artistName,
      albumImage: event.albumImage,
      // You can also pass songIds if you want to support that
      songIds: event.songIds,
    );

    final result = await createAlbumUsecase(params);

    await result.fold(
      (failure) async {
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
      (_) async {
        // Refresh album list after creation
        await _onGetAllAlbum(const GetAllAlbumEvent(), emit);
      },
    );
  }

  Future<void> _onDeleteAlbum(DeleteAlbumEvent event, Emitter<AlbumState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await deleteAlbumUsecase(event.albumId);

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (_) => add(const GetAllAlbumEvent()),
    );
  }

  Future<void> _onGetAlbumById(GetAlbumByIdEvent event, Emitter<AlbumState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await getAlbumByIdUsecase(event.albumId);

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (album) => emit(state.copyWith(isLoading: false, isSuccess: true, selectedAlbum: album)),
    );
  }

  Future<void> _onAddSongToAlbum(AddSongToAlbumEvent event, Emitter<AlbumState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    // Wrap params in AddRemoveSongParams
    final params = AddRemoveSongParams(
      albumId: event.albumId,
      songId: event.songId,
    );

    final result = await addSongToAlbumUsecase(
      add_usecase.AddRemoveSongParams(albumId: event.albumId, songId: event.songId),
    );


    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (_) => add(const GetAllAlbumEvent()),
    );
  }

  Future<void> _onRemoveSongFromAlbum(RemoveSongFromAlbumEvent event, Emitter<AlbumState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final params = AddRemoveSongParams(
      albumId: event.albumId,
      songId: event.songId,
    );

    final result = await removeSongFromAlbumUsecase(
      remove_usecase.AddRemoveSongParams(albumId: event.albumId, songId: event.songId),
    );


    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (_) => add(const GetAllAlbumEvent()),
    );
  }

  Future<void> _onUpdateAlbum(UpdateAlbumEvent event, Emitter<AlbumState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await updateAlbumUsecase(event.album);

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (_) => add(const GetAllAlbumEvent()),
    );
  }
}
