import 'dart:io';

import 'package:batch_34a/core/network/hive_service.dart';
import 'package:batch_34a/features/auth/data/data_source/user_data_source.dart';
import 'package:batch_34a/features/auth/data/model/user_hive_model.dart';
import 'package:batch_34a/features/auth/domain/entity/user_entity.dart';


class UserLocalDatasource implements IUserDataSource {
  final HiveService _hiveService;

  UserLocalDatasource({required HiveService hiveService})
    : _hiveService = hiveService;

  @override
  Future<String> loginUser(String username, String password) async {
    try {
      final userData = await _hiveService.login(username, password);
      if (userData != null && userData.password == password) {
        return "Login successful";
      } else {
        throw Exception("Invalid username or password");
      }
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  @override
  Future<void> registerUser(UserEntity user) async {
    try {
      final userHiveModel = UserHiveModel.fromEntity(user);
      await _hiveService.register(userHiveModel);
    } catch (e) {
      throw Exception("Registration failed: $e");
    }
  }

  @override
  Future<UserEntity> getCurrentUser() async {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }

  @override
  Future<String> uploadProfilePicture(File file) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }
}
