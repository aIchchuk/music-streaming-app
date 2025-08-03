import 'package:dartz/dartz.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/auth/data/data_source/user_data_source.dart';
import 'package:music_streaming/features/auth/domain/entity/user_entity.dart';
import 'package:music_streaming/features/auth/domain/repository/user_repository.dart';

class UserRemoteRepository implements IUserRepository {
  final IUserDataSource _userRemoteDataSource;

  UserRemoteRepository({required IUserDataSource userRemoteDataSource})
      : _userRemoteDataSource = userRemoteDataSource;

  @override
  Future<Either<Failure, String>> loginUser(
    String email,
    String password,
  ) async {
    try {
      final token = await _userRemoteDataSource.loginUser(email, password);
      return Right(token);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerUser(UserEntity user) async {
    try {
      await _userRemoteDataSource.registerUser(user);
      return const Right(null);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final user = await _userRemoteDataSource.getCurrentUser();
      return Right(user);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }
}
