import 'dart:io';

import 'package:batch_34a/app/use_case/usecase.dart';
import 'package:batch_34a/core/error/failure.dart';
import 'package:batch_34a/features/auth/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';


class UploadImageParams {
  final File file;

  const UploadImageParams({required this.file});
}

class UserImageUploadUsecase implements UsecaseWithParams<String, UploadImageParams> {
  final IUserRepository _userRepository;

  UserImageUploadUsecase({required IUserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<Either<Failure, String>> call(UploadImageParams params) {
    return _userRepository.uploadProfilePicture(params.file);
  }
}
