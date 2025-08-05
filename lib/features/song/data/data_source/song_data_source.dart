import 'dart:io';

import 'package:music_streaming/features/song/domain/entity/song_entity.dart';

abstract interface class ISongDataSource {
  Future<List<SongEntity>> getAllSong();

  Future<SongEntity> getSongById(String songId);

  Future<List<SongEntity>> getSongByName(String songName);

  Future<void> createSong(SongEntity song, {File? songImage, File? audioFile});

  Future<SongEntity> updateSong(SongEntity song);

  Future<void> deleteSong(String songId);

  Future<List<SongEntity>> getFeaturedSong();

  Future<List<SongEntity>> getMadeForYouSong();

  Future<List<SongEntity>> getTrendingSong();
}
