import 'package:dartz/dartz.dart';
import 'package:music_streaming/app/use_case/usecase.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/album/domain/entity/album_entity.dart';
import 'package:music_streaming/features/album/domain/repository/album_repository.dart';

class GetAllAlbumUsecase implements UsecaseWithoutParams<List<AlbumEntity>> {
  final IAlbumRepository iAlbumRepository;

  GetAllAlbumUsecase({required this.iAlbumRepository});

  @override
  Future<Either<Failure, List<AlbumEntity>>> call() {
    return iAlbumRepository.getAllAlbum();
  }
}
