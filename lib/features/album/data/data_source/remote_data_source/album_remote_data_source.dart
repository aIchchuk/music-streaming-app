import 'dart:io';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:music_streaming/app/constant/api_endpoints.dart';
import 'package:music_streaming/core/network/api_service.dart';
import 'package:music_streaming/features/album/data/data_source/album_data_source.dart';
import 'package:music_streaming/features/album/data/model/album_api_model.dart';
import 'package:music_streaming/features/album/domain/entity/album_entity.dart';
import 'package:http_parser/http_parser.dart'; // for MediaType

class AlbumRemoteDataSource implements IAlbumDataSource {
  final ApiService _apiService;

  AlbumRemoteDataSource({required ApiService apiService}) : _apiService = apiService;

  @override
  Future<List<AlbumEntity>> getAllAlbum() async {
    try {
      final response = await _apiService.dio.get(ApiEndpoints.getAllAlbums);
      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        final List<dynamic> albumList = responseData['data'];

        return albumList
            .map((json) => AlbumApiModel.fromJson(json as Map<String, dynamic>).toEntity())
            .toList();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Failed to get all albums: ${e.message}');
    }
  }

  @override
  Future<AlbumEntity> getAlbumById(String albumId) async {
    try {
      final response = await _apiService.dio.get('${ApiEndpoints.getAlbumById}$albumId');
      if (response.statusCode == 200) {
        return AlbumApiModel.fromJson(response.data).toEntity();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Failed to get album by ID: ${e.message}');
    }
  }



@override
Future<void> createAlbum(AlbumEntity album, {File? albumImage}) async {
  try {
    final albumModel = AlbumApiModel.fromEntity(album);

    if (albumImage != null && albumImage.existsSync()) {
      final multipartFile = await MultipartFile.fromFile(
        albumImage.path,
        filename: basename(albumImage.path), // import 'package:path/path.dart';
        contentType: MediaType('image', 'jpeg'), // or png if your file is png
      );

      final formData = FormData.fromMap({
        ...albumModel.toJson(),
        'albumImage': multipartFile,
      });

      final response = await _apiService.dio.post(ApiEndpoints.createAlbum, data: formData);
      if (response.statusCode != 201) {
        throw Exception(response.statusMessage);
      }
    } else {
      final response = await _apiService.dio.post(ApiEndpoints.createAlbum, data: albumModel.toJson());
      if (response.statusCode != 201) {
        throw Exception(response.statusMessage);
      }
    }
  } on DioException catch (e) {
    throw Exception('Failed to create album: ${e.message}');
  }
}



  @override
  Future<AlbumEntity> updateAlbum(AlbumEntity album) async {
    try {
      final albumModel = AlbumApiModel.fromEntity(album);
      final response = await _apiService.dio.put('${ApiEndpoints.updateAlbum}${album.albumId}', data: albumModel.toJson());
      if (response.statusCode == 200) {
        return AlbumApiModel.fromJson(response.data).toEntity();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Failed to update album: ${e.message}');
    }
  }

  @override
  Future<void> deleteAlbum(String albumId) async {
    try {
      final response = await _apiService.dio.delete('${ApiEndpoints.deleteAlbum}$albumId');
      if (response.statusCode != 200) {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Failed to delete album: ${e.message}');
    }
  }

  @override
  Future<AlbumEntity> addSongToAlbum(String albumId, String songId) async {
    try {
      final response = await _apiService.dio.post('${ApiEndpoints.addSongToAlbum}$albumId/$songId');
      if (response.statusCode == 200) {
        return AlbumApiModel.fromJson(response.data).toEntity();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Failed to add song to album: ${e.message}');
    }
  }

  @override
  Future<AlbumEntity> removeSongFromAlbum(String albumId, String songId) async {
    try {
      final response = await _apiService.dio.delete('${ApiEndpoints.removeSongFromAlbum}$albumId/$songId');
      if (response.statusCode == 200) {
        return AlbumApiModel.fromJson(response.data).toEntity();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Failed to remove song from album: ${e.message}');
    }
  }
}
