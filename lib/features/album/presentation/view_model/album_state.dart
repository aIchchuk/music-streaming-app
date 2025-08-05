import 'package:equatable/equatable.dart';
import 'package:music_streaming/features/album/domain/entity/album_entity.dart';

class AlbumState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final List<AlbumEntity> albumList;
  final AlbumEntity? selectedAlbum;
  final String? errorMessage;

  /// New flag to indicate whether the albums should be displayed (after pressing button)
  final bool hasFetchedAlbums;

  const AlbumState({
    required this.isLoading,
    required this.isSuccess,
    required this.albumList,
    this.selectedAlbum,
    this.errorMessage,
    this.hasFetchedAlbums = false,   // Default to false
  });

  const AlbumState.initial()
      : isLoading = false,
        isSuccess = false,
        albumList = const [],
        selectedAlbum = null,
        errorMessage = null,
        hasFetchedAlbums = false;

  AlbumState copyWith({
    bool? isLoading,
    bool? isSuccess,
    List<AlbumEntity>? albumList,
    AlbumEntity? selectedAlbum,
    String? errorMessage,
    bool? hasFetchedAlbums,
  }) {
    return AlbumState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      albumList: albumList ?? this.albumList,
      selectedAlbum: selectedAlbum ?? this.selectedAlbum,
      errorMessage: errorMessage,
      hasFetchedAlbums: hasFetchedAlbums ?? this.hasFetchedAlbums,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        albumList,
        selectedAlbum,
        errorMessage,
        hasFetchedAlbums,
      ];
}
