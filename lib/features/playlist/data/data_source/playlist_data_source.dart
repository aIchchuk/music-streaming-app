
import 'package:music_streaming/features/playlist/domain/entity/playlist_entity.dart';

abstract interface class IPlaylistDataSource {
  Future<void> addPlaylist(PlaylistEntity playlist);
  Future<void> deletePlaylist(String playlistId);
  Future<List<PlaylistEntity>> getPlaylist();
}
