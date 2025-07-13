import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {

  final String? UserId;
  final String fullName;
  final String phoneNo;
  final String? userImage;
  final String email;
  final String password;


  const UserEntity({
    this.UserId,
    required this.fullName,
    required this.phoneNo,
    this.userImage,
    required this.email,
    required this.password,
  });
  
  @override
  List<Object?> get props => [
    UserId,
    fullName,
    phoneNo,
    userImage,
    email,
    password,
  ];
}