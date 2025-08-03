import 'dart:io';

import 'package:music_streaming/core/network/hive_service.dart';
import 'package:music_streaming/features/song/data/data_source/song_data_source.dart';
import 'package:music_streaming/features/song/data/model/song_hive_model.dart';
import 'package:music_streaming/features/song/domain/entity/song_entity.dart';

class SongLocalDataSource implements ISongDataSource {
  final HiveService _hiveService;

  SongLocalDataSource({required HiveService hiveService})
      : _hiveService = hiveService;

  @override
  Future<void> createSong(SongEntity song) async {
    try {
      final model = SongHiveModel.fromEntity(song);
      await _hiveService.addSong(model);
    } catch (e) {
      throw Exception('Failed to create song: $e');
    }
  }

  @override
  Future<void> deleteSong(String songId) async {
    try {
      await _hiveService.deleteSong(songId);
    } catch (e) {
      throw Exception('Failed to delete song: $e');
    }
  }

  @override
  Future<List<SongEntity>> getAllSong() async {
    try {
      final songs = await _hiveService.getAllSong();
      return songs.map((e) => e.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to fetch songs: $e');
    }
  }

  @override
  Future<SongEntity> getSongById(String songId) async {
    try {
      final song = await _hiveService.getSongById(songId);
      return song.toEntity();
    } catch (e) {
      throw Exception('Song not found: $e');
    }
  }

  @override
  Future<List<SongEntity>> getSongByName(String songName) async {
    try {
      final songs = await _hiveService.getSongByName(songName);
      return songs.map((e) => e.toEntity()).toList();
    } catch (e) {
      throw Exception('Error while searching songs: $e');
    }
  }

  @override
  Future<List<SongEntity>> getFeaturedSong() async {
    try {
      final songs = await _hiveService.getFeaturedSong();
      return songs.map((e) => e.toEntity()).toList();
    } catch (e) {
      throw Exception('Error fetching featured songs: $e');
    }
  }

  @override
  Future<List<SongEntity>> getMadeForYouSong() async {
    try {
      final songs = await _hiveService.getMadeForYouSong();
      return songs.map((e) => e.toEntity()).toList();
    } catch (e) {
      throw Exception('Error fetching made-for-you songs: $e');
    }
  }

  @override
  Future<List<SongEntity>> getTrendingSong() async {
    try {
      final songs = await _hiveService.getTrendingSong();
      return songs.map((e) => e.toEntity()).toList();
    } catch (e) {
      throw Exception('Error fetching trending songs: $e');
    }
  }

  @override
  Future<SongEntity> updateSong(SongEntity song) async {
    try {
      final updatedModel = SongHiveModel.fromEntity(song);
      await _hiveService.addSong(updatedModel); // Overwrites existing
      return updatedModel.toEntity();
    } catch (e) {
      throw Exception('Failed to update song: $e');
    }
  }

  @override
  Future<String> uploadAudioFile(File audioFile) {
    // You can implement actual file storage logic here later
    throw UnimplementedError('uploadAudioFile() is not implemented yet');
  }

  @override
  Future<String> uploadCoverImage(File songImageFile) {
    // You can implement actual file storage logic here later
    throw UnimplementedError('uploadCoverImage() is not implemented yet');
  }
}
