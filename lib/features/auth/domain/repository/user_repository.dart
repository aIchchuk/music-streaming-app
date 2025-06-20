
import 'dart:io';

import 'package:batch_34a/core/error/failure.dart';
import 'package:batch_34a/features/auth/domain/entity/user_entity.dart';
import 'package:dartz/dartz.dart'; // For Either




abstract interface class IUserRepository {


  Future<Either<Failure, String>> loginUser(
    String username,
    String password,
  );

  Future<Either<Failure, String>> uploadProfilePicture(File file);

  Future<Either<Failure, UserEntity>> getCurrentUser();
}