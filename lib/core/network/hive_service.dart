import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_streaming/app/constant/hive_table_constant.dart';
import 'package:music_streaming/features/album/data/model/album_hive_model.dart';
import 'package:music_streaming/features/playlist/data/model/playlist_hive_model.dart';
import 'package:music_streaming/features/song/data/model/song_hive_model.dart';
import 'package:path_provider/path_provider.dart';


class HiveService {
  Future<void> init() async {
    // Initialize the database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}toot_music_streaming.db';

    Hive.init(path);

    // Register Adapters
    Hive.registerAdapter(SongHiveModelAdapter());
    Hive.registerAdapter(PlaylistHiveModelAdapter());
    Hive.registerAdapter(AlbumHiveModelAdapter());
    
  }


  // Song Queries
  Future<void> addSong(SongHiveModel song) async {
    // Check if the song already exists
    var box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);

    await box.put(song.songId, song);
  }

  Future<void> deleteSong(String id) async {
    var box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);
    await box.delete(id);
  }

  Future<List<SongHiveModel>> getAllSong() async {
    // Sort by SongsName
    var box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);
    return box.values.toList();
  }

  // Playlist Queries
  Future<void> addPlaylist(PlaylistHiveModel playlist) async {
    var box = await Hive.openBox<PlaylistHiveModel>(HiveTableConstant.playlistBox);

    await box.put(playlist.playlistId, playlist);
  }

  Future<void> deletePlaylist(String id) async {
    var box = await Hive.openBox<PlaylistHiveModel>(HiveTableConstant.playlistBox);
    await box.delete(id);
  }

  Future<List<PlaylistHiveModel>> getAllPlaylist() async {
    var box = await Hive.openBox<PlaylistHiveModel>(HiveTableConstant.playlistBox);
    return box.values.toList();
  }

  // Album Queries
  Future<void> addAlbum(AlbumHiveModel album) async {
    var box = await Hive.openBox<AlbumHiveModel>(HiveTableConstant.albumBox);

    await box.put(album.albumId, album);
  }

  Future<void> deleteAlbum(String id) async {
    var box = await Hive.openBox<AlbumHiveModel>(HiveTableConstant.albumBox);
    await box.delete(id);
  }

  Future<List<AlbumHiveModel>> getAllAlbum() async {
    var box = await Hive.openBox<AlbumHiveModel>(HiveTableConstant.albumBox);
    return box.values.toList();
  }


}
