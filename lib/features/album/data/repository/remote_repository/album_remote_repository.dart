import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/album/data/data_source/remote_data_source/album_remote_data_source.dart';
import 'package:music_streaming/features/album/domain/entity/album_entity.dart';
import 'package:music_streaming/features/album/domain/repository/album_repository.dart';

class AlbumRemoteRepository implements IAlbumRepository {
  final AlbumRemoteDataSource _albumRemoteDataSource;

  AlbumRemoteRepository({required AlbumRemoteDataSource albumRemoteDataSource})
      : _albumRemoteDataSource = albumRemoteDataSource;

  @override
  Future<Either<Failure, void>> createAlbum(AlbumEntity album, {File? albumImage}) async {
    try {
      await _albumRemoteDataSource.createAlbum(album, albumImage: albumImage);
      return const Right(null);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAlbum(String albumId) async {
    try {
      await _albumRemoteDataSource.deleteAlbum(albumId);
      return const Right(null);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AlbumEntity>>> getAllAlbum() async {
    try {
      final albums = await _albumRemoteDataSource.getAllAlbum();
      return Right(albums);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AlbumEntity>> getAlbumById(String albumId) async {
    try {
      final album = await _albumRemoteDataSource.getAlbumById(albumId);
      return Right(album);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AlbumEntity>> addSongToAlbum(String albumId, String songId) async {
    try {
      final album = await _albumRemoteDataSource.addSongToAlbum(albumId, songId);
      return Right(album);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AlbumEntity>> removeSongFromAlbum(String albumId, String songId) async {
    try {
      final album = await _albumRemoteDataSource.removeSongFromAlbum(albumId, songId);
      return Right(album);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AlbumEntity>> updateAlbum(AlbumEntity album) async {
    try {
      final updatedAlbum = await _albumRemoteDataSource.updateAlbum(album);
      return Right(updatedAlbum);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }
}
