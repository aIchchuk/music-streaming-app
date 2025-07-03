
import 'package:music_streaming/features/song/domain/entity/song_entity.dart';

abstract interface class ISongDataSource{

  Future<void> addSong(SongEntity song);
  Future<void> deleteSong(String songId);
  Future<List<SongEntity>> getSong();


}