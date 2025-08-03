import 'package:dartz/dartz.dart';
import 'package:music_streaming/app/use_case/usecase.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/song/domain/entity/song_entity.dart';
import 'package:music_streaming/features/song/domain/repository/song_repository.dart';

class GetSongByIdUsecase implements UsecaseWithParams<SongEntity, String> {
  final ISongRepository _songRepository;

  GetSongByIdUsecase({required ISongRepository songRepository})
      : _songRepository = songRepository;

  @override
  Future<Either<Failure, SongEntity>> call(String id) {
    return _songRepository.getSongById(id);
  }
}
