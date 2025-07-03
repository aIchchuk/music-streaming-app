import 'package:dartz/dartz.dart';
import 'package:music_streaming/app/use_case/usecase.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/song/domain/entity/song_entity.dart';
import 'package:music_streaming/features/song/domain/repository/song_repository.dart';

class GetSongUsecase implements UsecaseWithoutParams<List<SongEntity>> {
  final ISongRepository iSongRepository;

  GetSongUsecase({required this.iSongRepository});

  @override
  Future<Either<Failure, List<SongEntity>>> call() async {
    return await iSongRepository.getSong();
  }
}
