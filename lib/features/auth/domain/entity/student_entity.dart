

import 'package:equatable/equatable.dart';

class StudentEntity extends Equatable{
  final String? userId;
  final String fullName;
  final String? image;
  final String username;
  final String password;

  const StudentEntity({
    this.userId,
    required this.fullName,
    this.image,
    required this.username,
    required this.password
  });

  @override
  List<Object?> get props => [
    userId,
    fullName,
    image,
    username,
    password,
  ];

}