import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming/app/constant/api_endpoints.dart';
import 'package:music_streaming/features/album/presentation/view_model/album_event.dart';
import 'package:music_streaming/features/album/presentation/view_model/album_state.dart';
import 'package:music_streaming/features/album/presentation/view_model/album_view_model.dart';

class AlbumView extends StatelessWidget {
  const AlbumView({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch all albums when the widget builds
    context.read<AlbumViewModel>().add(const GetAllAlbumEvent());

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: BlocBuilder<AlbumViewModel, AlbumState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator(color: Colors.greenAccent));
              }

              if (state.errorMessage != null) {
                return Center(
                  child: Text(
                    'Error: ${state.errorMessage}',
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                );
              }

              if (state.albumList.isEmpty) {
                return const Center(
                  child: Text('No albums found.', style: TextStyle(color: Colors.white)),
                );
              }

              return ListView(
                children: [
                  const SizedBox(height: 12),
                  const Text(
                    'Recommended Albums',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  _buildAlbumSection(state.albumList),

                  const SizedBox(height: 24),
                  const Text(
                    'Your Library',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  _buildAlbumSection(state.albumList.reversed.toList()),

                  const SizedBox(height: 24),
                  _buildCallToActionCard(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAlbumSection(List albumList) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: albumList.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final album = albumList[index];
          return _buildAlbumCard(album.albumName, album.albumImageUrl);
        },
      ),
    );
  }

  Widget _buildAlbumCard(String albumName, String? imageUrl) {
    final image = (imageUrl != null && imageUrl.isNotEmpty)
        ? (imageUrl.startsWith('http')
            ? imageUrl
            : '${ApiEndpoints.serverAddress}$imageUrl')
        : null;

    return Container(
      width: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey.shade900,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        image: image != null
            ? DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.35), BlendMode.darken),
              )
            : null,
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            albumName,
            style: TextStyle(
              color: Colors.white.withOpacity(0.95),
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget _buildCallToActionCard() {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 32),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.greenAccent.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.greenAccent.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          const Icon(Icons.add_circle_outline, color: Colors.greenAccent, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Create Your Album',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Upload tracks and build your own collection!',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
