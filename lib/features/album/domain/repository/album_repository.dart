import 'package:dartz/dartz.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/album/domain/entity/album_entity.dart';

abstract interface class IAlbumRepository {
  // Create a new album
  Future<Either<Failure, AlbumEntity>> createAlbum(AlbumEntity album);

  // Delete an album by its ID
  Future<Either<Failure, void>> deleteAlbum(String albumId);

  // Update a album by ID
  // Future<Either<Failure, albumEntity>> updateAlbum(String id, AlbumEntity updatedAlbum);

  // Get all albums (with songs populated)
  Future<Either<Failure, List<AlbumEntity>>> getAllAlbum();

  // Get a specific album by ID
  Future<Either<Failure, AlbumEntity>> getAlbumById(String albumId);

  // Add a song to a specific album
  Future<Either<Failure, AlbumEntity>> addSongToAlbum({
    required String albumId,
    required String songId,
  });

  // Remove a song from a specific album
  Future<Either<Failure, AlbumEntity>> removeSongFromAlbum({
    required String albumId,
    required String songId,
  });

}
