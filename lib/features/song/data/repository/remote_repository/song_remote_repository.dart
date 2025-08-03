import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/song/data/data_source/remote_data_source/song_remote_data_source.dart';
import 'package:music_streaming/features/song/domain/entity/song_entity.dart';
import 'package:music_streaming/features/song/domain/repository/song_repository.dart';

class SongRemoteRepository implements ISongRepository {
  final SongRemoteDataSource _songRemoteDataSource;

  SongRemoteRepository({required SongRemoteDataSource songRemoteDataSource})
      : _songRemoteDataSource = songRemoteDataSource;

  
  @override
  Future<Either<Failure, void>> createSong(SongEntity song, {File? songImage, File? audioFile}) async{
    try {
      await _songRemoteDataSource.createSong(song);
      return const Right(null);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSong(String songId) async {
    try {
      await _songRemoteDataSource.deleteSong(songId);
      return const Right(null);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SongEntity>>> getAllSong() async {
    try {
      final songs = await _songRemoteDataSource.getAllSong();
      return Right(songs);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SongEntity>> getSongById(String songId) async {
    try {
      final song = await _songRemoteDataSource.getSongById(songId);
      return Right(song);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SongEntity>>> getSongByName(String songName) async {
    try {
      final songs = await _songRemoteDataSource.getSongByName(songName);
      return Right(songs);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SongEntity>>> getFeaturedSong() async {
    try {
      final songs = await _songRemoteDataSource.getFeaturedSong();
      return Right(songs);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SongEntity>>> getMadeForYouSong() async {
    try {
      final songs = await _songRemoteDataSource.getMadeForYouSong();
      return Right(songs);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SongEntity>>> getTrendingSong() async {
    try {
      final songs = await _songRemoteDataSource.getTrendingSong();
      return Right(songs);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SongEntity>> updateSong(SongEntity song) async {
    try {
      final updated = await _songRemoteDataSource.updateSong(song);
      return Right(updated);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }
  


}
