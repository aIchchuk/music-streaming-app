import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming/features/song/presentation/view_model/song_view_model.dart';
import 'package:music_streaming/features/song/presentation/view_model/song_state.dart';
import 'package:music_streaming/app/constant/api_endpoints.dart';

// Reuse your resolveImageUrl from earlier for network images
String resolveImageUrl(String? imageUrl) {
  if (imageUrl == null || imageUrl.isEmpty) return '';

  if (imageUrl.startsWith('http')) {
    if (imageUrl.contains('localhost')) {
      return imageUrl.replaceFirst('localhost', '10.0.2.2');
    }
    return imageUrl;
  }
  final cleanedPath = imageUrl.startsWith('/') ? imageUrl.substring(1) : imageUrl;
  return '${ApiEndpoints.baseUrl}/$cleanedPath';
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<SongViewModel, SongState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.errorMessage != null) {
                return Center(
                  child: Text(
                    'Error: ${state.errorMessage}',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }

              // Extract unique albums from songs
              final albums = <String, String?>{};
              for (var song in state.songList) {
                final albumName = song.albumName ?? 'Unknown Album';
                if (!albums.containsKey(albumName)) {
                  albums[albumName] = song.songImageUrl;
                }
              }

              return ListView(
                children: [
                  // Filter Row (you can customize or connect to filter logic)
                  Row(
                    children: [
                      _buildFilterChip('A', isCircle: true),
                      const SizedBox(width: 8),
                      _buildFilterChip('All', selected: true),
                      const SizedBox(width: 8),
                      _buildFilterChip('Music'),
                      const SizedBox(width: 8),
                      _buildFilterChip('Podcasts'),
                    ],
                  ),
                  const SizedBox(height: 20),

                  _buildSectionTitle('All Songs'),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.songList.length,
                      itemBuilder: (context, index) {
                        final song = state.songList[index];
                        final image = resolveImageUrl(song.songImageUrl);
                        return _buildSongCard(song.songName, song.artistName, image);
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  _buildSectionTitle('All Albums'),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: albums.length,
                      itemBuilder: (context, index) {
                        final albumName = albums.keys.elementAt(index);
                        final albumImage = resolveImageUrl(albums[albumName]);
                        return _buildAlbumCard(albumName, albumImage);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, {bool selected = false, bool isCircle = false}) {
    return isCircle
        ? CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(label, style: const TextStyle(color: Colors.white)),
          )
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: selected ? Colors.green : Colors.grey.shade800,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(label, style: TextStyle(color: selected ? Colors.black : Colors.white)),
          );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildSongCard(String songName, String artistName, String imageUrl) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
        image: imageUrl.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
              )
            : null,
        color: Colors.grey.shade900,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                songName,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Text(
                artistName,
                style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAlbumCard(String albumName, String imageUrl) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
        image: imageUrl.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
              )
            : null,
        color: Colors.grey.shade900,
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            albumName,
            style: TextStyle(color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.bold, fontSize: 16),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
