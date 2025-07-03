import 'package:flutter/material.dart';

@immutable
sealed class RegisterEvent {}

class RegisterUserEvent extends RegisterEvent {
  final BuildContext context;
  final String name;
  final String email;
  final String password;
  final String phone;

  RegisterUserEvent({
    required this.context,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });
}
