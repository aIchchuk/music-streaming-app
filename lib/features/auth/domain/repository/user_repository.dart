import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/auth/domain/entity/user_entity.dart';

abstract interface class IUserRepository {
  Future<Either<Failure, void>> registerUser(UserEntity user);
  Future<Either<Failure, String>> loginUser(String email, String password);

  // File
  Future<Either<Failure, String>> uploadUserImage(File file);

  Future<Either<Failure, UserEntity>> getCurrentUser();
}