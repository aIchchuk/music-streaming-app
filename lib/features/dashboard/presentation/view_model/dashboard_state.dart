import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming/features/albums/presentation/view/albums_view.dart';
import 'package:music_streaming/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:music_streaming/features/playlists/presentation/view/playlists_view.dart';
import 'package:music_streaming/features/profile/presentation/view/profile_view.dart';
import 'package:music_streaming/features/songs/presentation/view/songs_view.dart';

class DashboardState {
  final int selectedIndex;
  final List<Widget> views;

  const DashboardState({required this.selectedIndex, required this.views});

  // Initial state
  static DashboardState initial() {
    return DashboardState(
      selectedIndex: 0,
      views: [
        DashboardView(),
        SongsView(),
        PlaylistsView(),
        AlbumsView(),
        ProfileView(),
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