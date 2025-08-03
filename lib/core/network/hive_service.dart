import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_streaming/app/constant/hive_table_constant.dart';
import 'package:music_streaming/features/album/data/model/album_hive_model.dart';
import 'package:music_streaming/features/auth/data/model/user_hive_model.dart';
import 'package:music_streaming/features/playlist/data/model/playlist_hive_model.dart';
import 'package:music_streaming/features/song/data/model/song_hive_model.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/toot_music_streaming.db';
    Hive.init(path);

    // Register Adapters
    Hive.registerAdapter(SongHiveModelAdapter());
    Hive.registerAdapter(PlaylistHiveModelAdapter());
    Hive.registerAdapter(AlbumHiveModelAdapter());
    Hive.registerAdapter(UserHiveModelAdapter());
  }

  // ---------------- SONG QUERIES ---------------- //

  Future<void> createSong(SongHiveModel song) async {
    final box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);
    await box.put(song.songId, song);
  }

  Future<void> deleteSong(String id) async {
    final box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);
    await box.delete(id);
  }

  Future<List<SongHiveModel>> getAllSong() async {
    final box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);
    return box.values.toList();
  }

  Future<SongHiveModel> getSongById(String id) async {
    final box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);
    final song = box.get(id);
    if (song == null) {
      throw Exception('Song not found');
    }
    return song;
  }

  Future<List<SongHiveModel>> getSongByName(String songName) async {
    final box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);
    return box.values
        .where((song) =>
            song.songName.toLowerCase().contains(songName.toLowerCase()))
        .toList();
  }

  Future<List<SongHiveModel>> getFeaturedSong() async {
    final box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);
    final allSongs = box.values.toList();
    allSongs.shuffle();
    return allSongs.take(6).toList();
  }

  Future<List<SongHiveModel>> getMadeForYouSong() async {
    final box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);
    final allSongs = box.values.toList();
    allSongs.shuffle();
    return allSongs.take(4).toList();
  }

  Future<List<SongHiveModel>> getTrendingSong() async {
    final box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);
    final allSongs = box.values.toList();
    allSongs.shuffle();
    return allSongs.take(4).toList();
  }

  // ---------------- PLAYLIST QUERIES ---------------- //

  Future<void> addPlaylist(PlaylistHiveModel playlist) async {
    final box = await Hive.openBox<PlaylistHiveModel>(HiveTableConstant.playlistBox);
    await box.put(playlist.playlistId, playlist);
  }

  Future<void> deletePlaylist(String id) async {
    final box = await Hive.openBox<PlaylistHiveModel>(HiveTableConstant.playlistBox);
    await box.delete(id);
  }

  Future<List<PlaylistHiveModel>> getAllPlaylist() async {
    final box = await Hive.openBox<PlaylistHiveModel>(HiveTableConstant.playlistBox);
    return box.values.toList();
  }

  // ---------------- ALBUM QUERIES ---------------- //

  Future<void> addAlbum(AlbumHiveModel album) async {
    final box = await Hive.openBox<AlbumHiveModel>(HiveTableConstant.albumBox);
    await box.put(album.albumId, album);
  }

  Future<void> deleteAlbum(String id) async {
    final box = await Hive.openBox<AlbumHiveModel>(HiveTableConstant.albumBox);
    await box.delete(id);
  }

  Future<List<AlbumHiveModel>> getAllAlbum() async {
    final box = await Hive.openBox<AlbumHiveModel>(HiveTableConstant.albumBox);
    return box.values.toList();
  }

  // ---------------- USER QUERIES ---------------- //

  Future<void> registerUser(UserHiveModel user) async {
    final box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    await box.put(user.email, user); // Email used as unique key
  }

  Future<UserHiveModel?> loginUser(String email, String password) async {
    final box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);

    return box.values.firstWhere(
      (user) => user.email == email && user.password == password,
      orElse: () => throw Exception('Invalid username or password'),
    );
  }
}
