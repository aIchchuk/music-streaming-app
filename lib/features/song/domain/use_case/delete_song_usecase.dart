import 'package:dartz/dartz.dart';
import 'package:music_streaming/app/use_case/usecase.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/song/domain/repository/song_repository.dart';

class DeleteSongParams {
  final String songId;

  DeleteSongParams({required this.songId});
}

class DeleteSongUsecase implements UsecaseWithParams<void, DeleteSongParams> {
  final ISongRepository iSongRepository;

  DeleteSongUsecase({required this.iSongRepository});

  @override
  Future<Either<Failure, void>> call(DeleteSongParams params) async {
    return await iSongRepository.deleteSong(params.songId);
  }
}
