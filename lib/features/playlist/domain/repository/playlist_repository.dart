import 'package:dartz/dartz.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/playlist/domain/entity/playlist_entity.dart';

abstract interface class IPlaylistRepository {
  Future<Either<Failure, void>> addPlaylist(PlaylistEntity playlist);
  Future<Either<Failure, void>> deletePlaylist(String playlistId);
  Future<Either<Failure, List<PlaylistEntity>>> getPlaylist();
}
