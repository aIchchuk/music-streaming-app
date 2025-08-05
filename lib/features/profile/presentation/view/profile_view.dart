import 'package:flutter/material.dart';
import 'package:music_streaming/features/auth/presentation/view/login_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  static const Color spotifyGreen = Color(0xFF1DB954);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 12, 12),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile picture placeholder
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white10,
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.white38,
                ),
              ),
              const SizedBox(height: 24),
              // User name
              const Text(
                'Admin',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // User email placeholder
              const Text(
                'admin@gmail.com',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 32),

              // Stats row (Songs, Albums, Playlists)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem('Songs', '23'),
                  _buildStatItem('Albums', '6'),
                  _buildStatItem('Playlists', '15'),
                ],
              ),
              const SizedBox(height: 48),

              // Some additional info or description placeholder
              const Text(
                'Welcome to your profile! Here you can manage your playlists, view your activity, and update your details.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              // Logout button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.logout, color: Colors.black),
                  label: const Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: spotifyGreen,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginView()),
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

  Widget _buildStatItem(String label, String count) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            color: spotifyGreen,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
