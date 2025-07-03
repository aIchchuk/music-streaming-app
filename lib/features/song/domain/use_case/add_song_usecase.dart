import 'package:dartz/dartz.dart';
import 'package:music_streaming/app/use_case/usecase.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/song/domain/entity/song_entity.dart';
import 'package:music_streaming/features/song/domain/repository/song_repository.dart';

class AddSongParams {
  final String songName;
  final String artistName;
  final String audioUrl;

  AddSongParams({
    required this.songName,
    required this.artistName,
    required this.audioUrl,
  });
}

class AddSongUsecase implements UsecaseWithParams<void, AddSongParams> {
  final ISongRepository iSongRepository;

  AddSongUsecase({required this.iSongRepository});

  @override
  Future<Either<Failure, void>> call(AddSongParams params) {
    final song = SongEntity(
      songName: params.songName,
      artistName: params.artistName,
      audioUrl: params.audioUrl,
    );
    return iSongRepository.addSong(song);
  }
}
