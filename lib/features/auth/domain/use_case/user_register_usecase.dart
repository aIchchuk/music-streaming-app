import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:music_streaming/app/use_case/usecase.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/auth/domain/entity/user_entity.dart';
import 'package:music_streaming/features/auth/domain/repository/user_repository.dart';

class UserRegisterParams extends Equatable {
  final String fullName;

  final String email;
  final String password;

  const UserRegisterParams({
    required this.fullName,

    required this.email,
    required this.password,
  });

  // Optional: Initial constructor for UI state management
  const UserRegisterParams.initial()
      : fullName = '',

        email = '',
        password = '';

  @override
  List<Object?> get props => [
        fullName,

        email,
        password,
      ];
}

class UserRegisterUsecase implements UsecaseWithParams<void, UserRegisterParams> {
  final IUserRepository _userRepository;

  UserRegisterUsecase({required IUserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<Either<Failure, void>> call(UserRegisterParams params) {
    final userEntity = UserEntity(
      fullName: params.fullName,

      email: params.email,
      password: params.password,
    );

    return _userRepository.registerUser(userEntity);
  }
}
