import 'dart:io';

import 'package:flutter/material.dart';

@immutable
sealed class RegisterEvent {}

class UserUploadImageEvent extends RegisterEvent {
  final File file;

  UserUploadImageEvent({required this.file});
}

class UserRegisterEvent extends RegisterEvent {
  final BuildContext context;
  final String fullName;
  final String phoneNo;
  final String? userImage;
  final String email;
  final String password;

  UserRegisterEvent({
    required this.context,
    required this.fullName,
    required this.phoneNo,
    required this.userImage,
    required this.email,
    required this.password,
  });
}
