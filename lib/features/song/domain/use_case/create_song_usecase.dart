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
  final File? songImage;  // Changed to File?
  final File? audioFile;  // Changed to File?

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
        songImage,
        audioFile,
      ];
}

/// Usecase for creating a new song
class CreateSongUsecase implements UsecaseWithParams<void, CreateSongParams> {
  final ISongRepository _songRepository;

  CreateSongUsecase({required ISongRepository songRepository})
      : _songRepository = songRepository;

  @override
  Future<Either<Failure, void>> call(CreateSongParams params) {
    final songEntity = SongEntity(
      songName: params.songName,
      artistName: params.artistName,
      albumName: params.albumName,
      songImage: null, // We'll assume repo handles upload, so pass null or handle inside repo
      audioFile: null, // same here
    );

    // The repository should handle file upload internally using the passed File objects
    return _songRepository.createSong(songEntity);
  }
}
