import 'dart:io';

import 'package:batch_34a/features/auth/domain/entity/user_entity.dart';



abstract interface class IUserDataSource {
  Future<void> registerUser(UserEntity userData);

  Future<String> loginUser(String username, String password);

  Future<String> uploadProfilePicture(File file);

  Future<UserEntity> getCurrentUser();
}
