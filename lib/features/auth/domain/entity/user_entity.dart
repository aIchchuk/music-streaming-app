import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{
  final String? userId;
  final String fullName;
  final String? image;
  final String phone;
  final String username;
  final String password;

  const UserEntity({
    this.userId,
    required this.fullName,
    this.image,
    required this.phone,
    required this.username,
    required this.password
  });

  @override
  List<Object?> get props => [
    userId,
    fullName,
    image,
    phone,
    username,
    password,
  ];

}