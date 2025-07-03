import 'package:music_streaming/core/network/hive_service.dart';
import 'package:music_streaming/features/album/data/data_source/album_data_source.dart';
import 'package:music_streaming/features/album/data/model/album_hive_model.dart';
import 'package:music_streaming/features/album/domain/entity/album_entity.dart';

class AlbumLocalDataSource implements IAlbumDataSource{

  final HiveService hiveService;

  AlbumLocalDataSource({required this.hiveService});

  @override
  Future<void> addAlbum(AlbumEntity album) async {
    try{
      await hiveService.addAlbum(AlbumHiveModel.fromEntity(album));
    } catch (e) {
      throw Exception('Failed to add album: $e');
    }
  }

  @override
  Future<void> deleteAlbum(String albumId) async {
    try{
      await hiveService.deleteAlbum(albumId);
    } catch (e) {
      throw Exception('Failed to delete album: $e');
    }
  }

  @override
  Future<List<AlbumEntity>> getAlbum() async {
    try{
      final album = await hiveService.getAllAlbum();
      return AlbumHiveModel.toEntityList(album);
    } catch (e) {
      throw Exception('Failed to get albums: $e');
    }
  }

}