import 'package:batch_34a/app/use_case/usecase.dart';
import 'package:batch_34a/core/error/failure.dart';
import 'package:batch_34a/features/auth/domain/entity/user_entity.dart';
import 'package:batch_34a/features/auth/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserGetCurrentUsecase implements UsecaseWithoutParams<UserEntity> {
  final IUserRepository _userRepository;

  UserGetCurrentUsecase({required IUserRepository userRepository})
    : _userRepository = userRepository;

  @override
  Future<Either<Failure, UserEntity>> call() {
    return _userRepository.getCurrentUser();
  }
}
