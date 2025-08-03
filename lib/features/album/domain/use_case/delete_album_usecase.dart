import 'package:dartz/dartz.dart';
import 'package:music_streaming/app/use_case/usecase.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/album/domain/repository/album_repository.dart';

class DeleteAlbumParams {
  final String albumId;
  DeleteAlbumParams({required this.albumId});
}

class DeleteAlbumUsecase implements UsecaseWithParams<void, DeleteAlbumParams> {
  final IAlbumRepository iAlbumRepository;

  DeleteAlbumUsecase({required this.iAlbumRepository});

  @override
  Future<Either<Failure, void>> call(DeleteAlbumParams params) {
    return iAlbumRepository.deleteAlbum(params.albumId);
  }
}
