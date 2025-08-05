
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:music_streaming/app/constant/api_endpoints.dart';
import 'package:music_streaming/core/network/api_service.dart';
import 'package:music_streaming/features/song/data/data_source/song_data_source.dart';
import 'package:music_streaming/features/song/data/model/song_api_model.dart';
import 'package:music_streaming/features/song/domain/entity/song_entity.dart';

Future<FormData> createSongFormData({
  required String songName,
  required String artistName,
  String? albumName,
  File? songImage,
  File? audioFile,
}) async {
  final Map<String, dynamic> formDataMap = {
    'songName': songName,
    'artistName': artistName,
  };

  if (albumName != null) {
    formDataMap['albumName'] = albumName;
  }

  if (songImage != null && songImage.existsSync()) {
    final imageMultipart = await MultipartFile.fromFile(
      songImage.path,
      filename: basename(songImage.path),
      contentType: MediaType('image', 'jpeg'), // or 'png' based on your needs
    );
    formDataMap['songImage'] = imageMultipart;
  }

  if (audioFile != null && audioFile.existsSync()) {
    final audioMultipart = await MultipartFile.fromFile(
      audioFile.path,
      filename: basename(audioFile.path),
      contentType: MediaType('audio', 'mpeg'), // adjust to your audio file type if needed
    );
    formDataMap['audioFile'] = audioMultipart;
  }

  return FormData.fromMap(formDataMap);
}

class SongRemoteDataSource implements ISongDataSource {
  final ApiService _apiService;

  SongRemoteDataSource({required ApiService apiService}) : _apiService = apiService;

  @override
  Future<List<SongEntity>> getAllSong() async {
    try {
      final response = await _apiService.dio.get(ApiEndpoints.getAllSongs);
      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        final List<dynamic> songList = responseData['data'];

        return songList
            .map((json) => SongApiModel.fromJson(json as Map<String, dynamic>).toEntity())
            .toList();
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
Future<void> createSong(SongEntity song, {File? songImage, File? audioFile}) async {
  try {
    final formData = await createSongFormData(
      songName: song.songName,
      artistName: song.artistName,
      albumName: song.albumName,
      songImage: songImage,
      audioFile: audioFile,
    );

    final response = await _apiService.dio.post(ApiEndpoints.createSong, data: formData);

    if (response.statusCode != 200 && response.statusCode != 201) {
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
  Future<List<SongEntity>> getFeaturedSong() async {
    try {
      final response = await _apiService.dio.get(ApiEndpoints.featuredSongs);
      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        final List<dynamic> songList = responseData['data'];

        return songList
            .map((json) => SongApiModel.fromJson(json as Map<String, dynamic>).toEntity())
            .toList();
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
        final responseData = response.data as Map<String, dynamic>;
        final List<dynamic> songList = responseData['data'];

        return songList
            .map((json) => SongApiModel.fromJson(json as Map<String, dynamic>).toEntity())
            .toList();
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
        final responseData = response.data as Map<String, dynamic>;
        final List<dynamic> songList = responseData['data'];

        return songList
            .map((json) => SongApiModel.fromJson(json as Map<String, dynamic>).toEntity())
            .toList();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch trending songs: ${e.message}');
    }
  }


}
