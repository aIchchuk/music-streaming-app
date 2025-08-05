import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:music_streaming/app/use_case/usecase.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/album/domain/entity/album_entity.dart';
import 'package:music_streaming/features/album/domain/repository/album_repository.dart';

class CreateAlbumParams extends Equatable {
  final String albumName;
  final String artistName;
  final String? albumImageUrl;
  final List<String>? songIds;
  final File? albumImage;

  const CreateAlbumParams({
    required this.albumName,
    required this.artistName,
    this.albumImageUrl,
    this.songIds,
    this.albumImage,
  });

  @override
  List<Object?> get props => [
        albumName,
        artistName,
        albumImageUrl,
        songIds,
        albumImage,
      ];
}

class CreateAlbumUsecase implements UsecaseWithParams<void, CreateAlbumParams> {
  final IAlbumRepository _albumRepository;

  CreateAlbumUsecase({required IAlbumRepository albumRepository})
      : _albumRepository = albumRepository;

  @override
  Future<Either<Failure, void>> call(CreateAlbumParams params) {
    final albumEntity = AlbumEntity(
      albumName: params.albumName,
      artistName: params.artistName,
      albumImageUrl: params.albumImageUrl,
      albumImage: null,
      song: [],
    );
    return _albumRepository.createAlbum(
      albumEntity,
      albumImage: params.albumImage,
    );
  }
}
