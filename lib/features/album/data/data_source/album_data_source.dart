import 'package:music_streaming/features/album/domain/entity/album_entity.dart';

abstract interface class IAlbumDataSource {
  Future<void> addAlbum(AlbumEntity album);
  Future<void> deleteAlbum(String albumId);
  Future<List<AlbumEntity>> getAlbum();

}
