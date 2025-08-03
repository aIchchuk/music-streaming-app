import 'package:dartz/dartz.dart';
import 'package:music_streaming/app/use_case/usecase.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/album/domain/entity/album_entity.dart';
import 'package:music_streaming/features/album/domain/repository/album_repository.dart';

class AddSongToAlbumParams {
  final String albumId;
  final String songId;

  AddSongToAlbumParams({required this.albumId, required this.songId});
}

class AddSongToAlbumUsecase implements UsecaseWithParams<AlbumEntity, AddSongToAlbumParams> {
  final IAlbumRepository iAlbumRepository;

  AddSongToAlbumUsecase({required this.iAlbumRepository});

  @override
  Future<Either<Failure, AlbumEntity>> call(AddSongToAlbumParams params) {
    return iAlbumRepository.addSongToAlbum(
      albumId: params.albumId,
      songId: params.songId,
    );
  }
}
