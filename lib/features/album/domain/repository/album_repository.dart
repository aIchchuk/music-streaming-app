import 'package:dartz/dartz.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/album/domain/entity/album_entity.dart';

abstract interface class IAlbumRepository {
  Future<Either<Failure, void>> addAlbum(AlbumEntity album);
  Future<Either<Failure, void>> deleteAlbum(String albumId);
  Future<Either<Failure, List<AlbumEntity>>> getAlbum();
}
