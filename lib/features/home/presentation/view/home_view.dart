import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 15),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Top Filter Row (All, Music, Podcasts)
            Row(
              children: [
                _buildFilterChip('A', isCircle: true),
                const SizedBox(width: 8),
                _buildFilterChip('All', selected: true),
                const SizedBox(width: 8),
                _buildFilterChip('Music'),
                const SizedBox(width: 8),
                _buildFilterChip('Podcasts'),
              ],
            ),
            const SizedBox(height: 20),

            // Recently Played
            _buildSectionTitle("Recently Played"),
            const SizedBox(height: 12),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildTile("iGRES", image: Icons.music_note),
                  _buildTile("C418", image: Icons.album),
                  _buildTile("Daily Mix 1", image: Icons.play_circle),
                  _buildTile("Daily Mix 3", image: Icons.play_circle),
                  _buildTile("Cigarettes...", image: Icons.smoke_free),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Artists You Like
            _buildSectionTitle("Artists you like"),
            const SizedBox(height: 12),
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCard("Peso Pluma Mix"),
                  _buildCard("Clave Especial Mix"),
                  _buildCard("Øneheart"),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Albums featuring songs you like
            _buildSectionTitle("Albums featuring songs you like"),
            const SizedBox(height: 12),
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCard("Crystal Skies", imgAsset: 'assets/crystal_skies.jpg'),
                  _buildCard("Minecraft - Volume Alpha", imgAsset: 'assets/minecraft.jpg'),
                  _buildCard("Stray", imgAsset: 'assets/stray.jpg'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, {bool selected = false, bool isCircle = false}) {
    return isCircle
        ? CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(label, style: const TextStyle(color: Colors.white)),
          )
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: selected ? Colors.green : Colors.grey.shade800,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(label, style: TextStyle(color: selected ? Colors.black : Colors.white)),
          );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildTile(String title, {IconData? image}) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(image ?? Icons.music_note, size: 32, color: Colors.white),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, {String? imgAsset}) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
        image: imgAsset != null
            ? DecorationImage(
                image: AssetImage(imgAsset),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
              )
            : null,
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
