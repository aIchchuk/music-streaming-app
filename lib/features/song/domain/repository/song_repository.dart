import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/song/domain/entity/song_entity.dart';

abstract interface class ISongRepository {

  Future<Either<Failure, List<SongEntity>>> getAllSong();

  Future<Either<Failure, SongEntity>> getSongById(String songId);

  Future<Either<Failure, List<SongEntity>>> getSongByName(String songName);

  Future<Either<Failure, void>> createSong( SongEntity song,
  {File? songImage,
  File? audioFile});

  Future<Either<Failure, SongEntity>> updateSong(SongEntity song);

  Future<Either<Failure, void>> deleteSong(String songId);

  Future<Either<Failure, List<SongEntity>>> getFeaturedSong();

  Future<Either<Failure, List<SongEntity>>> getMadeForYouSong();

  Future<Either<Failure, List<SongEntity>>> getTrendingSong();

}
