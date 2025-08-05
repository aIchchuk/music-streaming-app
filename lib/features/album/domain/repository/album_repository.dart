import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/album/domain/entity/album_entity.dart';

abstract interface class IAlbumRepository {
  Future<Either<Failure, List<AlbumEntity>>> getAllAlbum();

  Future<Either<Failure, AlbumEntity>> getAlbumById(String albumId);

  Future<Either<Failure, void>> createAlbum(
    AlbumEntity album, {
    File? albumImage,
  });

  Future<Either<Failure, AlbumEntity>> updateAlbum(AlbumEntity album);

  Future<Either<Failure, void>> deleteAlbum(String albumId);

  Future<Either<Failure, AlbumEntity>> addSongToAlbum(String albumId, String songId);

  Future<Either<Failure, AlbumEntity>> removeSongFromAlbum(String albumId, String songId);
}
