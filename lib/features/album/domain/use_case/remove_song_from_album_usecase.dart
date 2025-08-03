import 'package:dartz/dartz.dart';
import 'package:music_streaming/app/use_case/usecase.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/album/domain/entity/album_entity.dart';
import 'package:music_streaming/features/album/domain/repository/album_repository.dart';

class RemoveSongFromAlbumParams {
  final String albumId;
  final String songId;

  RemoveSongFromAlbumParams({required this.albumId, required this.songId});
}

class RemoveSongFromAlbumUsecase
    implements UsecaseWithParams<AlbumEntity, RemoveSongFromAlbumParams> {
  final IAlbumRepository iAlbumRepository;

  RemoveSongFromAlbumUsecase({required this.iAlbumRepository});

  @override
  Future<Either<Failure, AlbumEntity>> call(RemoveSongFromAlbumParams params) {
    return iAlbumRepository.removeSongFromAlbum(
      albumId: params.albumId,
      songId: params.songId,
    );
  }
}
