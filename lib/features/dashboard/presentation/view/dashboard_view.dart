import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming/features/dashboard/presentation/view_model/dashboard_state.dart';
import 'package:music_streaming/features/dashboard/presentation/view_model/dashboard_view_model.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  static const Color spotifyGreen = Color(0xFF1DB954);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DashboardViewModel, DashboardState>(
        builder: (context, state) {
          return state.views.elementAt(state.selectedIndex);
        },
      ),
      bottomNavigationBar: BlocBuilder<DashboardViewModel, DashboardState>(
        builder: (context, state) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color(0xFF121212), // dark background consistent with login/register
            selectedItemColor: spotifyGreen,
            unselectedItemColor: Colors.white54,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 12,
            ),
            elevation: 10,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined),
                activeIcon: Icon(Icons.dashboard),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.music_note_outlined),
                activeIcon: Icon(Icons.music_note),
                label: 'Songs',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.album_outlined),
                activeIcon: Icon(Icons.album),
                label: 'Album',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                activeIcon: Icon(Icons.account_circle),
                label: 'Profile',
              ),
            ],
            currentIndex: state.selectedIndex,
            onTap: (index) {
              context.read<DashboardViewModel>().onTabTapped(index);
            },
          );
        },
      ),
    );
  }
}
