import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming/app/constant/api_endpoints.dart';
import 'package:music_streaming/features/song/presentation/view_model/song_event.dart';
import 'package:music_streaming/features/song/presentation/view_model/song_state.dart';
import 'package:music_streaming/features/song/presentation/view_model/song_view_model.dart';

String resolveImageUrl(String? imageUrl) {
  if (imageUrl == null || imageUrl.isEmpty) return '';

  if (imageUrl.startsWith('http')) {
    // Replace localhost with emulator IP if needed
    if (imageUrl.contains('localhost')) {
      return imageUrl.replaceFirst('localhost', '10.0.2.2');
    }
    // Return as-is if it's a valid absolute URL without localhost
    return imageUrl;
  }

  // Otherwise, append baseUrl (strip any leading slash)
  final cleanedPath = imageUrl.startsWith('/') ? imageUrl.substring(1) : imageUrl;
  return '${ApiEndpoints.baseUrl}/$cleanedPath';
}


class SongView extends StatelessWidget {
  const SongView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F), // Dark background
      appBar: AppBar(
        title: const Text('Songs'),
        backgroundColor: const Color(0xFF0F0F0F),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCreateSongDialog(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Filter buttons (optional, can style differently or hide)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterButton(context, 'All', () => context.read<SongViewModel>().add(const GetAllSongEvent())),
                    _buildFilterButton(context, 'Featured', () => context.read<SongViewModel>().add(const GetFeaturedSongEvent())),
                    _buildFilterButton(context, 'Trending', () => context.read<SongViewModel>().add(const GetTrendingSongEvent())),
                    _buildFilterButton(context, 'Made For You', () => context.read<SongViewModel>().add(const GetMadeForYouSongEvent())),
                  ].map((w) => Padding(padding: const EdgeInsets.only(right: 8), child: w)).toList(),
                ),
              ),

              const SizedBox(height: 24),

              Expanded(
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
                    if (state.songList.isEmpty) {
                      return const Center(
                        child: Text('No songs found.', style: TextStyle(color: Colors.white)),
                      );
                    }

                    // Split your UI into multiple horizontal sections, e.g.:
                    return ListView(
                      children: [
                        _buildSectionTitle('Recently Played'),
                        SizedBox(
                          height: 180,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.songList.length,
                            itemBuilder: (context, index) {
                              final song = state.songList[index];
                              return _buildSongCard(song.songName, song.artistName, song.songImageUrl);
                            },
                          ),
                        ),

                        _buildSectionTitle('Artists you like'),
                        SizedBox(
                          height: 180,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.songList.length, // replace with actual artists list
                            itemBuilder: (context, index) {
                              final song = state.songList[index];
                              return _buildArtistCard(song.artistName, song.songImageUrl);
                            },
                          ),
                        ),

                        _buildSectionTitle('Albums featuring songs you like'),
                        SizedBox(
                          height: 180,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.songList.length, // replace with actual albums list
                            itemBuilder: (context, index) {
                              final song = state.songList[index];
                              return _buildAlbumCard(song.albumName ?? song.songName, song.songImageUrl);
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton(BuildContext context, String label, VoidCallback onTap) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade800,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: onTap,
      child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }


  Widget _buildSongCard(String songName, String artistName, String? imageUrl) {
  final image = resolveImageUrl(imageUrl);

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
      image: image.isNotEmpty
          ? DecorationImage(
              image: NetworkImage(image),
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


    Widget _buildArtistCard(String artistName, String? imageUrl) {
    final image = resolveImageUrl(imageUrl);

    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
        image: image.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.35), BlendMode.darken),
              )
            : null,
        color: Colors.grey.shade800,
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            artistName,
            style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 15, fontWeight: FontWeight.w600),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget _buildAlbumCard(String albumName, String? imageUrl) {
    final image = resolveImageUrl(imageUrl);

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
        image: image.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(image),
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



  Future<void> _showCreateSongDialog(BuildContext context) async {
    final _formKey = GlobalKey<FormState>();
    context: context;
    String songName = '';
    String artistName = '';
    String? albumName;
    File? songImage;
    File? audioFile;

    // Helper to pick files using file_picker package
    Future<File?> pickFile(String type) async {
      final result = await FilePicker.platform.pickFiles(
        type: type == 'image' ? FileType.image : FileType.audio,
      );
      if (result != null && result.files.isNotEmpty) {
        return File(result.files.single.path!);
      }
      return null;
    }

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: const Text('Create New Song', style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Song Name',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white38)),
                    ),
                    validator: (val) => val == null || val.isEmpty ? 'Enter song name' : null,
                    onSaved: (val) => songName = val!.trim(),
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Artist Name',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white38)),
                    ),
                    validator: (val) => val == null || val.isEmpty ? 'Enter artist name' : null,
                    onSaved: (val) => artistName = val!.trim(),
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Album Name (optional)',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white38)),
                    ),
                    onSaved: (val) => albumName = val?.trim(),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            final picked = await pickFile('image');
                            if (picked != null) {
                              songImage = picked;
                              // Just call setState on dialog? No setState here, but dialog will rebuild on validation only.
                            }
                          },
                          icon: const Icon(Icons.image),
                          label: const Text('Pick Image'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (songImage != null) const Icon(Icons.check_circle, color: Colors.green),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            final picked = await pickFile('audio');
                            if (picked != null) {
                              audioFile = picked;
                            }
                          },
                          icon: const Icon(Icons.music_note),
                          label: const Text('Pick Audio'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (audioFile != null) const Icon(Icons.check_circle, color: Colors.green),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
            ),
            ElevatedButton(
              onPressed: () {
                final form = _formKey.currentState;
                if (form != null && form.validate()) {
                  if (songImage == null || audioFile == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please pick both image and audio file')),
                    );
                    return;
                  }
                  form.save();
                  context.read<SongViewModel>().add(
                    CreateSongEvent(
                      context: context,
                      songName: songName,
                      artistName: artistName,
                      albumName: albumName,
                      songImage: songImage!,
                      audioFile: audioFile!,
                    ),
                  );
                  Navigator.pop(dialogContext);
                }
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }
}
