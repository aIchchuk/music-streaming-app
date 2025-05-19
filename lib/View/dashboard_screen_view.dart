import 'package:flutter/material.dart';
import 'login_screen_view.dart';

class DashboardScreenView extends StatelessWidget {
  const DashboardScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_DashboardButton> buttons = [
      _DashboardButton(icon: Icons.library_music, label: 'My Playlists'),
      _DashboardButton(icon: Icons.search, label: 'Browse'),
      _DashboardButton(icon: Icons.favorite, label: 'Favorites'),
      _DashboardButton(icon: Icons.settings, label: 'Settings'),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.logout, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreenView()),
            );
          },
        ),
        title: const Text('Toot', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepOrange, Colors.redAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
        child: Column(
          children: [
            const Text(
              'Welcome to Toot 🎵',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: buttons.map((btn) => _buildDashboardButton(btn)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardButton(_DashboardButton button) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white.withOpacity(0.15),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // Implement navigation or action
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(button.icon, size: 40, color: Colors.white),
              const SizedBox(height: 12),
              Text(
                button.label,
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashboardButton {
  final IconData icon;
  final String label;

  _DashboardButton({required this.icon, required this.label});
}
