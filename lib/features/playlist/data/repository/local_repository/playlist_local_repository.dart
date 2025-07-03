import 'package:dartz/dartz.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/playlist/data/data_source/local_data_source/playlist_local_data_source.dart';
import 'package:music_streaming/features/playlist/domain/entity/playlist_entity.dart';
import 'package:music_streaming/features/playlist/domain/repository/playlist_repository.dart';

class PlaylistLocalRepository implements IPlaylistRepository {
  final PlaylistLocalDataSource playlistLocalDataSource;

  PlaylistLocalRepository({required this.playlistLocalDataSource});

  @override
  Future<Either<Failure, void>> addPlaylist(PlaylistEntity playlist) async {
    try {
      await playlistLocalDataSource.addPlaylist(playlist);
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: 'Failed to add Playlist'));
    }
  }

  @override
  Future<Either<Failure, void>> deletePlaylist(String playlistId) async {
    try {
      await playlistLocalDataSource.deletePlaylist(playlistId);
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: 'Failed to delete Playlist'));
    }
  }

  
  @override
  Future<Either<Failure, List<PlaylistEntity>>> getPlaylist() async{
    try{
      final playlist = await playlistLocalDataSource.getPlaylist();
      return Right(playlist);
    } catch(e) {
      return Left(LocalDatabaseFailure(message: 'Failed to get Playlist'));
    }
  }
}
