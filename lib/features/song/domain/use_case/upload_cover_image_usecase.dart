import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:music_streaming/app/use_case/usecase.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/song/domain/repository/song_repository.dart';

class UploadCoverImageParams {
  final File songImageFile;

  const UploadCoverImageParams({required this.songImageFile});
}

class UploadCoverImageUsecase implements UsecaseWithParams<String, UploadCoverImageParams> {
  final ISongRepository _songRepository;

  UploadCoverImageUsecase({required ISongRepository songRepository})
      : _songRepository = songRepository;

  @override
  Future<Either<Failure, String>> call(UploadCoverImageParams params) {
    return _songRepository.uploadCoverImage(params.songImageFile);
  }
}
