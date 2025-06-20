import 'dart:io';

import 'package:batch_34a/core/error/failure.dart';
import 'package:batch_34a/features/auth/data/data_source/local_data_source/user_local_data_source.dart';
import 'package:batch_34a/features/auth/domain/entity/user_entity.dart';
import 'package:batch_34a/features/auth/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserLocalRepository implements IUserRepository {
  final UserLocalDatasource _userLocalDatasource;

  UserLocalRepository({
    required UserLocalDatasource userLocalDatasource,
  }) : _userLocalDatasource = userLocalDatasource;

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> loginUser(
    String username,
    String password,
  ) async {
    try {
      final result = await _userLocalDatasource.loginUser(
        username,
        password,
      );
      return Right(result);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Failed to login: $e"));
    }
  }

  @override
  Future<Either<Failure, void>> registerUser(UserEntity user) async {
    try {
      await _userLocalDatasource.registerUser(user);
      return Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Failed to register: $e"));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      final result = await _userLocalDatasource.uploadProfilePicture(file);
      return Right(result);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Failed to upload profile picture: $e"));
    }
  }
}
