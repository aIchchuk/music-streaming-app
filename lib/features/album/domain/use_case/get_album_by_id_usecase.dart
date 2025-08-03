import 'package:dartz/dartz.dart';
import 'package:music_streaming/app/use_case/usecase.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/album/domain/entity/album_entity.dart';
import 'package:music_streaming/features/album/domain/repository/album_repository.dart';

class GetAlbumByIdParams {
  final String albumId;
  GetAlbumByIdParams({required this.albumId});
}

class GetAlbumByIdUsecase implements UsecaseWithParams<AlbumEntity, GetAlbumByIdParams> {
  final IAlbumRepository iAlbumRepository;

  GetAlbumByIdUsecase({required this.iAlbumRepository});

  @override
  Future<Either<Failure, AlbumEntity>> call(GetAlbumByIdParams params) {
    return iAlbumRepository.getAlbumById(params.albumId);
  }
}
