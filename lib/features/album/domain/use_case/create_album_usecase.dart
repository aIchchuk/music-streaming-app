import 'package:dartz/dartz.dart';
import 'package:music_streaming/app/use_case/usecase.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/album/domain/entity/album_entity.dart';
import 'package:music_streaming/features/album/domain/repository/album_repository.dart';

class CreateAlbumUsecase implements UsecaseWithParams<AlbumEntity, AlbumEntity> {
  final IAlbumRepository iAlbumRepository;

  CreateAlbumUsecase({required this.iAlbumRepository});

  @override
  Future<Either<Failure, AlbumEntity>> call(AlbumEntity album) {
    return iAlbumRepository.createAlbum(album);
  }
}
