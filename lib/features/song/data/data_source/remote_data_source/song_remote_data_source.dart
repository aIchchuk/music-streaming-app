import 'dart:io';
import 'package:dio/dio.dart';
import 'package:music_streaming/app/constant/api_endpoints.dart';
import 'package:music_streaming/core/network/api_service.dart';
import 'package:music_streaming/features/song/data/data_source/song_data_source.dart';
import 'package:music_streaming/features/song/data/model/song_api_model.dart';
import 'package:music_streaming/features/song/domain/entity/song_entity.dart';

class SongRemoteDataSource implements ISongDataSource {
  final ApiService _apiService;

  SongRemoteDataSource({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<List<SongEntity>> getAllSong() async {
    try {
      final response = await _apiService.dio.get(ApiEndpoints.getAllSongs);
      if (response.statusCode == 200) {
        final data = response.data as List;
        return data.map((json) => SongApiModel.fromJson(json).toEntity()).toList();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Failed to get all songs: ${e.message}');
    }
  }

  @override
  Future<SongEntity> getSongById(String songId) async {
    try {
      final response = await _apiService.dio.get('${ApiEndpoints.getSongById}$songId');
      if (response.statusCode == 200) {
        return SongApiModel.fromJson(response.data).toEntity();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Failed to get song by ID: ${e.message}');
    }
  }

  @override
  Future<List<SongEntity>> getSongByName(String songName) async {
    try {
      final response = await _apiService.dio.get('${ApiEndpoints.getSongByName}$songName');
      if (response.statusCode == 200) {
        final data = response.data as List;
        return data.map((json) => SongApiModel.fromJson(json).toEntity()).toList();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Failed to get song by name: ${e.message}');
    }
  }

  @override
  Future<void> createSong(SongEntity song) async {
    try {
      final songModel = SongApiModel.fromEntity(song);
      final response = await _apiService.dio.post(ApiEndpoints.createSong, data: songModel.toJson());
      if (response.statusCode != 200) {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Failed to create song: ${e.message}');
    }
  }

  @override
  Future<SongEntity> updateSong(SongEntity song) async {
    try {
      final songModel = SongApiModel.fromEntity(song);
      final response = await _apiService.dio.put('${ApiEndpoints.updateSong}${song.songId}', data: songModel.toJson());
      if (response.statusCode == 200) {
        return SongApiModel.fromJson(response.data).toEntity();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Failed to update song: ${e.message}');
    }
  }

  @override
  Future<void> deleteSong(String songId) async {
    try {
      final response = await _apiService.dio.delete('${ApiEndpoints.deleteSong}$songId');
      if (response.statusCode != 200) {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Failed to delete song: ${e.message}');
    }
  }

  @override
  Future<String> uploadCoverImage(File songImageFile) async {
    try {
      String fileName = songImageFile.path.split('/').last;
      FormData formData = FormData.fromMap({
        'songImage': await MultipartFile.fromFile(songImageFile.path, filename: fileName),
      });

      final response = await _apiService.dio.post(ApiEndpoints.uploadCoverImage, data: formData);
      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Failed to upload cover image: ${e.message}');
    }
  }

  @override
  Future<String> uploadAudioFile(File audioFile) async {
    try {
      String fileName = audioFile.path.split('/').last;
      FormData formData = FormData.fromMap({
        'audioFile': await MultipartFile.fromFile(audioFile.path, filename: fileName),
      });

      final response = await _apiService.dio.post(ApiEndpoints.uploadAudioFile, data: formData);
      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Failed to upload audio file: ${e.message}');
    }
  }

  @override
  Future<List<SongEntity>> getFeaturedSong() async {
    try {
      final response = await _apiService.dio.get(ApiEndpoints.featuredSongs);
      if (response.statusCode == 200) {
        final data = response.data as List;
        return data.map((json) => SongApiModel.fromJson(json).toEntity()).toList();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch featured songs: ${e.message}');
    }
  }

  @override
  Future<List<SongEntity>> getMadeForYouSong() async {
    try {
      final response = await _apiService.dio.get(ApiEndpoints.madeForYouSongs);
      if (response.statusCode == 200) {
        final data = response.data as List;
        return data.map((json) => SongApiModel.fromJson(json).toEntity()).toList();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch made-for-you songs: ${e.message}');
    }
  }

  @override
  Future<List<SongEntity>> getTrendingSong() async {
    try {
      final response = await _apiService.dio.get(ApiEndpoints.trendingSongs);
      if (response.statusCode == 200) {
        final data = response.data as List;
        return data.map((json) => SongApiModel.fromJson(json).toEntity()).toList();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch trending songs: ${e.message}');
    }
  }
}
