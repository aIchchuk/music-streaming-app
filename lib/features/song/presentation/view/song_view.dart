import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming/app/constant/api_endpoints.dart';
import 'package:music_streaming/features/song/presentation/view_model/song_event.dart';
import 'package:music_streaming/features/song/presentation/view_model/song_state.dart';
import 'package:music_streaming/features/song/presentation/view_model/song_view_model.dart';

class SongView extends StatelessWidget {
  const SongView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Songs')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<SongViewModel>().add(const GetAllSongEvent());
                },
                child: const Text('Get All Songs'),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<SongViewModel, SongState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state.errorMessage != null) {
                      return Center(child: Text('Error: ${state.errorMessage}'));
                    } else if (state.songList.isEmpty) {
                      return const Center(child: Text('No songs found.'));
                    } else {
                      return ListView.builder(
                        itemCount: state.songList.length,
                        itemBuilder: (context, index) {
                          final song = state.songList[index];
                          
                          return ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                song.songImageUrl!.startsWith('/')
                                  ? '${ApiEndpoints.serverAddress}${song.songImageUrl}'
                                  : '${ApiEndpoints.coverImages}${song.songImageUrl}'
                                ,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                              ),
                            ),
                            title: Text(song.songName),
                            subtitle: Text(song.artistName),
                            trailing: const Icon(Icons.music_note),
                          );


                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
