import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:music_streaming/app/use_case/usecase.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/song/domain/entity/song_entity.dart';
import 'package:music_streaming/features/song/domain/repository/song_repository.dart';

/// Params class for creating a new song
class CreateSongParams extends Equatable {
  final String songName;
  final String artistName;
  final String? albumName;
  final String? songImage;
  final String? audioFile;

  const CreateSongParams({
    required this.songName,
    required this.artistName,
    this.albumName,
    this.songImage,
    this.audioFile,
  });

  @override
  List<Object?> get props => [
        songName,
        artistName,
        albumName,
      ];
}

/// Usecase for creating a new song
class CreateSongUsecase
    implements UsecaseWithParams<void, CreateSongParams> {
  final ISongRepository _songRepository;

  CreateSongUsecase({required ISongRepository songRepository})
      : _songRepository = songRepository;

  @override
  Future<Either<Failure, void>> call(CreateSongParams params) {
    final songEntity = SongEntity(
      songName: params.songName,
      artistName: params.artistName,
      albumName: params.albumName,
      songImage: params.songImage,
      audioFile: params.audioFile,
    );

    return _songRepository.createSong(songEntity);
  }
}
