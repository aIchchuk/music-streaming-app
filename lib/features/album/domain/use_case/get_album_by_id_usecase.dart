import 'package:dartz/dartz.dart';
import 'package:music_streaming/app/use_case/usecase.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/album/domain/entity/album_entity.dart';
import 'package:music_streaming/features/album/domain/repository/album_repository.dart';

class GetAlbumByIdUsecase implements UsecaseWithParams<AlbumEntity, String> {
  final IAlbumRepository _albumRepository;

  GetAlbumByIdUsecase({required IAlbumRepository albumRepository})
      : _albumRepository = albumRepository;

  @override
  Future<Either<Failure, AlbumEntity>> call(String albumId) {
    return _albumRepository.getAlbumById(albumId);
  }
}
