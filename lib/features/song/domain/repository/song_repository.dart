import 'package:dartz/dartz.dart';
import 'package:music_streaming/features/song/domain/entity/song_entity.dart';
import 'package:music_streaming/core/error/failure.dart';

abstract interface class ISongRepository{

  Future<Either<Failure, void>> addSong(SongEntity song);
  Future<Either<Failure, List<SongEntity>>> getSong();
  Future<Either<Failure, void>> deleteSong(String songId);


}