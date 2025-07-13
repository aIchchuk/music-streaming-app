import 'dart:io';
import 'package:music_streaming/features/auth/domain/entity/user_entity.dart';

abstract interface class IUserDataSource {
  Future<void> registerUser(UserEntity user);
  Future<String> loginUser(String email, String password);

  // File
  Future<String> uploadUserImage(File file);

  Future<UserEntity> getCurrentUser();

}