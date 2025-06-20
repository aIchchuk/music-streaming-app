import 'package:batch_34a/app/use_case/usecase.dart';
import 'package:batch_34a/core/error/failure.dart';
import 'package:batch_34a/features/auth/domain/entity/user_entity.dart';
import 'package:batch_34a/features/auth/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';


class RegisterUserParams extends Equatable {
  final String fullName;
  final String phone;
  final String username;
  final String password;
  final String? image;

  const RegisterUserParams({
    required this.fullName,
    required this.phone,
    required this.username,
    required this.password,
    this.image,
  });

  // initial constructor
  const RegisterUserParams.initial({
    required this.fullName,
    required this.phone,
    required this.username,
    required this.password,
    this.image,
  });

  @override
  List<Object?> get props => [
    fullName,
    phone,
    username,
    password,
  ];
}

class UserRegisterUsecase
    implements UsecaseWithParams<void, RegisterUserParams> {
  final IUserRepository _userRepository;

  UserRegisterUsecase({required IUserRepository userRepository})
    : _userRepository = userRepository;

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final userEntity = UserEntity(
      userId: null,
      fullName: params.fullName,
      phone: params.phone,
      username: params.username,
      password: params.password,
      image: params.image,
    );
    return _userRepository.registerUser(userEntity);
  }
}
