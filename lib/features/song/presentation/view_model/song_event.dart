
sealed class SongEvent {

}

final class LoadSongEvent extends SongEvent {

}

final class AddSongEvent extends SongEvent {
  final String songName;

  AddSongEvent({required this.songName});
}

final class DeleteSongEvent extends SongEvent {
  final String songId;

  DeleteSongEvent({required this.songId});
}


