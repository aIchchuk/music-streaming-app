import 'package:dio/dio.dart';
import 'package:music_streaming/app/constant/api_endpoints.dart';
import 'package:music_streaming/core/network/api_service.dart';
import 'package:music_streaming/features/auth/data/data_source/user_data_source.dart';
import 'package:music_streaming/features/auth/data/model/user_api_model.dart';
import 'package:music_streaming/features/auth/domain/entity/user_entity.dart';

class UserRemoteDataSource implements IUserDataSource {
  final ApiService _apiService;

  UserRemoteDataSource({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<String> loginUser(String email, String password) async {
    try {
      final response = await _apiService.dio.post(
        ApiEndpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return response.data['token'];
      } else {
        throw Exception(response.statusMessage ?? 'Login failed');
      }
    } on DioException catch (e) {
      throw Exception('Failed to login: ${e.message}');
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }

  @override
  Future<void> registerUser(UserEntity user) async {
    try {
      final model = UserApiModel.fromEntity(user);
      final response = await _apiService.dio.post(
        ApiEndpoints.register,
        data: model.toJson(),
      );

      if (response.statusCode != 200) {
        throw Exception('Registration failed: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to register: ${e.message}');
    } catch (e) {
      throw Exception('Registration error: $e');
    }
  }

  @override
  Future<UserEntity> getCurrentUser() {
    // You can implement this when your backend supports fetching current user profile by token.
    throw UnimplementedError('getCurrentUser() is not implemented yet');
  }
}
