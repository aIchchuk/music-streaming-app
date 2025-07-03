import 'package:dartz/dartz.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/song/data/data_source/local_data_source/song_local_data_source.dart';
import 'package:music_streaming/features/song/domain/entity/song_entity.dart';
import 'package:music_streaming/features/song/domain/repository/song_repository.dart';

class SongLocalRepository implements ISongRepository{

  final SongLocalDataSource songLocalDataSource;
  
  SongLocalRepository({required this.songLocalDataSource});

  @override
  Future<Either<Failure, void>> addSong(SongEntity song) async {
     try {
      await songLocalDataSource.addSong(song);
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: 'Failed to add Song'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSong(String songId) async {
    try{
      await songLocalDataSource.deleteSong(songId);
      return const Right(null);
    } catch(e) {
      return Left(LocalDatabaseFailure(message: 'Failed to delete Song'));
    }
  }

  @override
  Future<Either<Failure, List<SongEntity>>> getSong() async {
    try{
      final song = await songLocalDataSource.getSong();
      return Right(song);
    } catch(e) {
      return Left(LocalDatabaseFailure(message: 'Failed to get Song'));
    }
  }

}