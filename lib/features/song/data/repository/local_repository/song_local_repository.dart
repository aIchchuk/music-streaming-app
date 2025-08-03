import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/song/data/data_source/local_data_source/song_local_data_source.dart';
import 'package:music_streaming/features/song/domain/entity/song_entity.dart';
import 'package:music_streaming/features/song/domain/repository/song_repository.dart';

class SongLocalRepository implements ISongRepository {
  final SongLocalDataSource _songLocalDataSource;

  SongLocalRepository({required SongLocalDataSource songLocalDataSource})
      : _songLocalDataSource = songLocalDataSource;


  @override
  Future<Either<Failure, void>> createSong(SongEntity song, {File? songImage, File? audioFile}) async {
    try {
      await _songLocalDataSource.createSong(song);
      return Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Failed to create song: $e"));
    }
  }


  @override
  Future<Either<Failure, void>> deleteSong(String songId) async {
    try {
      await _songLocalDataSource.deleteSong(songId);
      return Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Failed to delete song: $e"));
    }
  }

  @override
  Future<Either<Failure, List<SongEntity>>> getAllSong() async {
    try {
      final songs = await _songLocalDataSource.getAllSong();
      return Right(songs);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Failed to get songs: $e"));
    }
  }

  @override
  Future<Either<Failure, SongEntity>> getSongById(String songId) async {
    try {
      final song = await _songLocalDataSource.getSongById(songId);
      return Right(song);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Failed to get song: $e"));
    }
  }

  @override
  Future<Either<Failure, List<SongEntity>>> getSongByName(String songName) async {
    try {
      final songs = await _songLocalDataSource.getSongByName(songName);
      return Right(songs);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Failed to search song: $e"));
    }
  }

  @override
  Future<Either<Failure, SongEntity>> updateSong(SongEntity song) async {
    try {
      final updatedSong = await _songLocalDataSource.updateSong(song);
      return Right(updatedSong);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Failed to update song: $e"));
    }
  }

  @override
  Future<Either<Failure, List<SongEntity>>> getFeaturedSong() async {
    try {
      final songs = await _songLocalDataSource.getFeaturedSong();
      return Right(songs);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Failed to get featured songs: $e"));
    }
  }

  @override
  Future<Either<Failure, List<SongEntity>>> getMadeForYouSong() async {
    try {
      final songs = await _songLocalDataSource.getMadeForYouSong();
      return Right(songs);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Failed to get made-for-you songs: $e"));
    }
  }

  @override
  Future<Either<Failure, List<SongEntity>>> getTrendingSong() async {
    try {
      final songs = await _songLocalDataSource.getTrendingSong();
      return Right(songs);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Failed to get trending songs: $e"));
    }
  }
  

}
