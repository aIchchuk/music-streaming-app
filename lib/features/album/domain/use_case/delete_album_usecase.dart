import 'package:dartz/dartz.dart';
import 'package:music_streaming/app/use_case/usecase.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/album/domain/repository/album_repository.dart';

class DeleteAlbumUsecase implements UsecaseWithParams<void, String> {
  final IAlbumRepository _albumRepository;

  DeleteAlbumUsecase({required IAlbumRepository albumRepository})
      : _albumRepository = albumRepository;

  @override
  Future<Either<Failure, void>> call(String albumId) {
    return _albumRepository.deleteAlbum(albumId);
  }
}
