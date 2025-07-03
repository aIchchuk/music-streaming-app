import 'package:dartz/dartz.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/album/data/data_source/local_data_source/album_local_data_source.dart';
import 'package:music_streaming/features/album/domain/entity/album_entity.dart';
import 'package:music_streaming/features/album/domain/repository/album_repository.dart';

class AlbumLocalRepository implements IAlbumRepository {
  final AlbumLocalDataSource albumLocalDataSource;

  AlbumLocalRepository({required this.albumLocalDataSource});

  @override
  Future<Either<Failure, void>> addAlbum(AlbumEntity album) async {
    try {
      await albumLocalDataSource.addAlbum(album);
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: 'Failed to add Album'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAlbum(String albumId) async {
    try {
      await albumLocalDataSource.deleteAlbum(albumId);
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: 'Failed to delete Album'));
    }
  }

  
  @override
  Future<Either<Failure, List<AlbumEntity>>> getAlbum() async {
   try {
      final album = await albumLocalDataSource.getAlbum();
      return Right(album);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: 'Failed to get Album'));
    }
  }
}
