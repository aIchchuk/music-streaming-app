import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:music_streaming/app/use_case/usecase.dart';
import 'package:music_streaming/core/error/failure.dart';
import 'package:music_streaming/features/album/domain/entity/album_entity.dart';
import 'package:music_streaming/features/album/domain/repository/album_repository.dart';

class AddSongToAlbumUsecase implements UsecaseWithParams<AlbumEntity, AddRemoveSongParams> {
  final IAlbumRepository _albumRepository;

  AddSongToAlbumUsecase({required IAlbumRepository albumRepository})
      : _albumRepository = albumRepository;

  @override
  Future<Either<Failure, AlbumEntity>> call(AddRemoveSongParams params) {
    return _albumRepository.addSongToAlbum(params.albumId, params.songId);
  }
}

class AddRemoveSongParams extends Equatable {
  final String albumId;
  final String songId;

  const AddRemoveSongParams({
    required this.albumId,
    required this.songId,
  });

  @override
  List<Object> get props => [albumId, songId];
}
