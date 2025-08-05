import 'dart:io';
import 'package:music_streaming/features/album/domain/entity/album_entity.dart';

abstract interface class IAlbumDataSource {
  Future<List<AlbumEntity>> getAllAlbum();

  Future<AlbumEntity> getAlbumById(String albumId);

  Future<void> createAlbum(
    AlbumEntity album, {
    File? albumImage,
  });

  Future<AlbumEntity> updateAlbum(AlbumEntity album);

  Future<void> deleteAlbum(String albumId);

  Future<AlbumEntity> addSongToAlbum(String albumId, String songId);

  Future<AlbumEntity> removeSongFromAlbum(String albumId, String songId);
}
