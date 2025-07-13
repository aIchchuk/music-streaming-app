import 'dart:io';

import 'package:music_streaming/core/network/hive_service.dart';
import 'package:music_streaming/features/auth/data/data_source/user_data_source.dart';
import 'package:music_streaming/features/auth/data/model/user_hive_model.dart';
import 'package:music_streaming/features/auth/domain/entity/user_entity.dart';

class UserLocalDataSource implements IUserDataSource {
  final HiveService _hiveService;

  UserLocalDataSource({required HiveService hiveService})
      : _hiveService = hiveService;

  @override
  Future<String> loginUser(String email, String password) async {
    try {
      final user = await _hiveService.loginUser(email, password);
      if (user != null && user.password == password) {
        return "Login successful";
      } else {
        throw Exception("Invalid email or password");
      }
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  @override
  Future<void> registerUser(UserEntity user) async {
    try {
      final userHiveModel = UserHiveModel.fromEntity(user);
      await _hiveService.registerUser(userHiveModel);
    } catch (e) {
      throw Exception("Registration failed: $e");
    }
  }

  @override
  Future<UserEntity> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<String> uploadUserImage(File file) {
    // TODO: implement uploadUserImage
    throw UnimplementedError();
  }
}
