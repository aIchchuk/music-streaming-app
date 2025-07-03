


import 'package:music_streaming/core/network/hive_service.dart';
import 'package:music_streaming/features/song/data/data_source/song_data_source.dart';
import 'package:music_streaming/features/song/data/model/song_hive_model.dart';
import 'package:music_streaming/features/song/domain/entity/song_entity.dart';


class SongLocalDataSource  implements ISongDataSource{

  final HiveService hiveService;


  SongLocalDataSource({required this.hiveService});

  @override
  Future<void> addSong(SongEntity song) async{
    try{
      await hiveService.addSong(SongHiveModel.fromEntity(song));
    } catch (e) {
      throw Exception('Failed to add song: $e');
    }
  }

  @override
  Future<void> deleteSong(String songId) async{
    try{
      await hiveService.deleteSong(songId);
    } catch (e) {
      throw Exception('Failed to delete song: $e');
    }
  }

  @override
  Future<List<SongEntity>> getSong() async{
    try{
      final song = await hiveService.getAllSong();
      return SongHiveModel.toEntityList(song);
    } catch (e) {
      throw Exception('Failed to get batches: $e');
    }
  }

  
  
}