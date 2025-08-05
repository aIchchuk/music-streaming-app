import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:music_streaming/features/song/domain/entity/song_entity.dart';


sealed class SongEvent extends Equatable {
  const SongEvent();

  @override
  List<Object?> get props => [];
}

final class GetAllSongEvent extends SongEvent {
  const GetAllSongEvent();
}

final class GetSongByIdEvent extends SongEvent {
  final String songId;

  const GetSongByIdEvent({required this.songId});

  @override
  List<Object?> get props => [songId];
}

final class GetSongByNameEvent extends SongEvent {
  final String songName;

  const GetSongByNameEvent({required this.songName});

  @override
  List<Object?> get props => [songName];
}

final class CreateSongEvent extends SongEvent {
  final BuildContext context;
  final String songName;
  final String artistName;
  final String? albumName;
  final File? songImage;
  final File? audioFile;

  const CreateSongEvent({
    required this.context,
    required this.songName,
    required this.artistName,
    this.albumName,
    this.songImage,
    this.audioFile,
  });

  @override
  List<Object?> get props => [
        context,
        songName,
        artistName,
        albumName,
        songImage,
        audioFile,
      ];
}

final class UpdateSongEvent extends SongEvent {
  final SongEntity song;

  const UpdateSongEvent({required this.song});

  @override
  List<Object?> get props => [song];
}

final class DeleteSongEvent extends SongEvent {
  final String songId;

  const DeleteSongEvent({required this.songId});

  @override
  List<Object?> get props => [songId];
}

final class GetFeaturedSongEvent extends SongEvent {
  const GetFeaturedSongEvent();
}

final class GetMadeForYouSongEvent extends SongEvent {
  const GetMadeForYouSongEvent();
}

final class GetTrendingSongEvent extends SongEvent {
  const GetTrendingSongEvent();
}
