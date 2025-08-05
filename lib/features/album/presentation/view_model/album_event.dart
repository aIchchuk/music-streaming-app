import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:music_streaming/features/album/domain/entity/album_entity.dart';

sealed class AlbumEvent extends Equatable {
  const AlbumEvent();

  @override
  List<Object?> get props => [];
}

final class GetAllAlbumEvent extends AlbumEvent {
  const GetAllAlbumEvent();
}

final class GetAlbumByIdEvent extends AlbumEvent {
  final String albumId;

  const GetAlbumByIdEvent({required this.albumId});

  @override
  List<Object?> get props => [albumId];
}

final class CreateAlbumEvent extends AlbumEvent {
  final BuildContext context;
  final String albumName;
  final String artistName;
  final File? albumImage;
  final List<String>? songIds; // Optional initial songs to add

  const CreateAlbumEvent({
    required this.context,
    required this.albumName,
    required this.artistName,
    this.albumImage,
    this.songIds,
  });

  @override
  List<Object?> get props => [
        context,
        albumName,
        artistName,
        albumImage,
        songIds,
      ];
}

final class UpdateAlbumEvent extends AlbumEvent {
  final AlbumEntity album;

  const UpdateAlbumEvent({required this.album});

  @override
  List<Object?> get props => [album];
}

final class DeleteAlbumEvent extends AlbumEvent {
  final String albumId;

  const DeleteAlbumEvent({required this.albumId});

  @override
  List<Object?> get props => [albumId];
}

final class AddSongToAlbumEvent extends AlbumEvent {
  final String albumId;
  final String songId;

  const AddSongToAlbumEvent({
    required this.albumId,
    required this.songId,
  });

  @override
  List<Object?> get props => [albumId, songId];
}

final class RemoveSongFromAlbumEvent extends AlbumEvent {
  final String albumId;
  final String songId;

  const RemoveSongFromAlbumEvent({
    required this.albumId,
    required this.songId,
  });

  @override
  List<Object?> get props => [albumId, songId];
}
