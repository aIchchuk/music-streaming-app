import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming/app/service_locator/service_locator.dart';
import 'package:music_streaming/features/album/presentation/view/album_view.dart';
import 'package:music_streaming/features/album/presentation/view_model/album_event.dart';
import 'package:music_streaming/features/album/presentation/view_model/album_view_model.dart';
import 'package:music_streaming/features/home/presentation/view/home_view.dart';
import 'package:music_streaming/features/playlist/presentation/view/playlist_view.dart';
import 'package:music_streaming/features/profile/presentation/view/profile_view.dart';
import 'package:music_streaming/features/song/presentation/view/song_view.dart';
import 'package:music_streaming/features/song/presentation/view_model/song_view_model.dart';

class DashboardState {
  final int selectedIndex;
  final List<Widget> views;

  const DashboardState({required this.selectedIndex, required this.views});

  // Initial state
  static DashboardState initial() {
    return DashboardState(
      selectedIndex: 0,
      views: [
        HomeView(),
        BlocProvider.value(
          value: serviceLocator<SongViewModel>(),
          child: const SongView(),
        ),
        BlocProvider.value(
          value: serviceLocator<AlbumViewModel>()..add(GetAllAlbumEvent()),
          child: const AlbumView(),
        ),
        const ProfileView(),
      ],
    );
  }


  DashboardState copyWith({int? selectedIndex, List<Widget>? views}) {
    return DashboardState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }
}