

import 'package:music_streaming/core/network/hive_service.dart';
import 'package:music_streaming/features/playlist/data/data_source/playlist_data_source.dart';
import 'package:music_streaming/features/playlist/data/model/playlist_hive_model.dart';
import 'package:music_streaming/features/playlist/domain/entity/playlist_entity.dart';

class PlaylistLocalDataSource implements IPlaylistDataSource{

  final HiveService hiveService;

  PlaylistLocalDataSource({required this.hiveService});

  @override
  Future<void> addPlaylist(PlaylistEntity playlist) async {
    try{
      await hiveService.addPlaylist(PlaylistHiveModel.fromEntity(playlist));
    } catch (e) {
      throw Exception('Failed to add playlist: $e');
    }
  }

  @override
  Future<void> deletePlaylist(String playlistId) async {
    try{
      await hiveService.deletePlaylist(playlistId);
    } catch (e) {
      throw Exception('Failed to delete playlist: $e');
    }
  }

  @override
  Future<List<PlaylistEntity>> getPlaylist() async {
    try{
      final playlist = await hiveService.getAllPlaylist();
      return PlaylistHiveModel.toEntityList(playlist);
    } catch (e) {
      throw Exception('Failed to get playlist: $e');
    }
  }

  

}