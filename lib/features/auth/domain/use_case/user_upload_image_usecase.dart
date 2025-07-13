import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:music_streaming/app/use_case/usecase.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/auth/domain/repository/user_repository.dart';

class UserUploadImageParams {
  final File file;

  const UserUploadImageParams({required this.file});
}

class UserUploadImageUsecase implements UsecaseWithParams<String, UserUploadImageParams> {
  final IUserRepository _userRepository;

  UserUploadImageUsecase({required IUserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<Either<Failure, String>> call(UserUploadImageParams params) {
    return _userRepository.uploadUserImage(params.file);
  }
}
