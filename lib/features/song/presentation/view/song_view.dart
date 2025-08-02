import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming/features/song/presentation/view_model/song_event.dart';
import 'package:music_streaming/features/song/presentation/view_model/song_state.dart';
import 'package:music_streaming/features/song/presentation/view_model/song_view_model.dart';

class SongView extends StatefulWidget {
  const SongView({super.key});

  @override
  State<SongView> createState() => _SongViewState();
}

class _SongViewState extends State<SongView> {
  bool showCreateForm = false;

  final _formKey = GlobalKey<FormState>();
  final _songNameController = TextEditingController();
  final _artistNameController = TextEditingController();
  final _audioUrlController = TextEditingController();
  final _releaseYearController = TextEditingController();
  final _albumNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 15),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: showCreateForm ? _buildCreateForm(screenWidth) : _buildInitialButtons(),
      ),
    );
  }

  Widget _buildInitialButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            // Logic for playing songs (placeholder)
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.deepOrange,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('Play Songs', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              showCreateForm = true;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.deepOrange,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('Create Song', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildCreateForm(double screenWidth) {
    return Center(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: screenWidth < 400 ? screenWidth * 0.9 : 400,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                const SizedBox(
                  height: 120,
                  width: 120,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/songs.png'),
                  ),
                ),
                const SizedBox(height: 30),
                _buildTextField(_songNameController, 'Song Name'),
                const SizedBox(height: 20),
                _buildTextField(_artistNameController, 'Artist Name'),
                const SizedBox(height: 20),
                _buildTextField(_albumNameController, 'Album Name'),
                const SizedBox(height: 20),
                _buildTextField(_releaseYearController, 'Release Year'),
                const SizedBox(height: 20),
                _buildTextField(_audioUrlController, 'Audio Url'),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    context.read<SongViewModel>().add(
                      AddSongEvent(songName: _songNameController.text),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.deepOrange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Save Song',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                BlocBuilder<SongViewModel, SongState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state.song.isEmpty) {
                      return Center(
                        child: Text(
                          'No songs available',
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }
                    if (state.errorMessage != null) {
                      return Text('Error: ${state.errorMessage}');
                    }
                    
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.song.length,
                      itemBuilder: (context, index) {
                        final song = state.song[index];
                        return ListTile(
                          title: Text(song.songName),
                          subtitle: Text('${song.songId}'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              context.read<SongViewModel>().add(
                                DeleteSongEvent(songId: song.songId ?? ''),
                              );
                            },
                          ),
                        );
                      },
                    );

                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return 'Please enter $hint';
      //   }
      //   return null;
      // },
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
    );
  }
}