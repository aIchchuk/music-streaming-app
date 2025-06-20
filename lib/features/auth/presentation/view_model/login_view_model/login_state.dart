import 'package:equatable/equatable.dart';

class UserLoginState extends Equatable {
  final bool isLoading;
  final bool isSuccess;

  const UserLoginState({required this.isLoading, required this.isSuccess});

  const UserLoginState.initial() : isLoading = false, isSuccess = false;

  UserLoginState copyWith({bool? isLoading, bool? isSuccess}) {
    return UserLoginState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess];
}
