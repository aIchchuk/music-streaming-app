import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_streaming/features/song/presentation/view_model/song_state.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:music_streaming/features/song/presentation/view_model/song_event.dart';
import 'package:music_streaming/features/song/presentation/view_model/song_view_model.dart';

class SongView extends StatefulWidget {
  const SongView({Key? key}) : super(key: key);

  @override
  State<SongView> createState() => _SongViewState();
}

class _SongViewState extends State<SongView> {
  final _formKey = GlobalKey<FormState>();
  final _songNameController = TextEditingController();
  final _artistNameController = TextEditingController();
  final _albumNameController = TextEditingController();

  File? _songImageFile;
  File? _audioFile;

  Future<void> _checkPermission(Permission permission) async {
    if (await permission.isDenied || await permission.isRestricted) {
      await permission.request();
    }
  }

  Future<void> _pickImage() async {
    await _checkPermission(Permission.photos);
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _songImageFile = File(pickedFile.path);
      });
      context.read<SongViewModel>().add(UploadSongCoverImageEvent(songImage: _songImageFile!));
    }
  }

  Future<void> _pickAudio() async {
    await _checkPermission(Permission.storage);
    final pickedFile = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _audioFile = File(pickedFile.path);
      });
      context.read<SongViewModel>().add(UploadSongAudioFileEvent(audioFile: _audioFile!));
    }
  }

  @override
  void dispose() {
    _songNameController.dispose();
    _artistNameController.dispose();
    _albumNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Song')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: _songImageFile != null
                        ? FileImage(_songImageFile!)
                        : const AssetImage('assets/images/default_song_cover.png') as ImageProvider,
                    child: _songImageFile == null
                        ? const Icon(Icons.camera_alt, size: 40, color: Colors.white70)
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _songNameController,
                  decoration: const InputDecoration(labelText: 'Song Name'),
                  validator: (value) => value == null || value.isEmpty ? 'Enter song name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _artistNameController,
                  decoration: const InputDecoration(labelText: 'Artist Name'),
                  validator: (value) => value == null || value.isEmpty ? 'Enter artist name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _albumNameController,
                  decoration: const InputDecoration(labelText: 'Album Name (optional)'),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _pickAudio,
                  icon: const Icon(Icons.audiotrack),
                  label: Text(_audioFile == null ? 'Select Audio File' : 'Audio Selected'),
                ),
                const SizedBox(height: 32),
                BlocConsumer<SongViewModel, SongState>(
                  listener: (context, state) {
                    if (state.isSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Song created successfully')),
                      );
                      Navigator.pop(context);
                    } else if (state.errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage!)),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const CircularProgressIndicator();
                    }
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<SongViewModel>().add(
                                  CreateSongEvent(
                                    context: context,
                                    songName: _songNameController.text.trim(),
                                    artistName: _artistNameController.text.trim(),
                                    albumName: _albumNameController.text.trim().isEmpty
                                        ? null
                                        : _albumNameController.text.trim(),
                                    songImage: _songImageFile,
                                    audioFile: _audioFile,
                                  ),
                                );
                          }
                        },
                        child: const Text('Create Song'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
