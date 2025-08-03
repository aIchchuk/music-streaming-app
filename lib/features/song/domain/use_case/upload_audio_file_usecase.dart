import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:music_streaming/app/use_case/usecase.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/song/domain/repository/song_repository.dart';

class UploadAudioFileParams {
  final File audioFile;

  const UploadAudioFileParams({required this.audioFile});
}

class UploadAudioFileUsecase implements UsecaseWithParams<String, UploadAudioFileParams> {
  final ISongRepository _songRepository;

  UploadAudioFileUsecase({required ISongRepository songRepository})
      : _songRepository = songRepository;

  @override
  Future<Either<Failure, String>> call(UploadAudioFileParams params) {
    return _songRepository.uploadAudioFile(params.audioFile);
  }
}
