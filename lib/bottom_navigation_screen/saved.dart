import 'package:flutter/material.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  final List<Map<String, String>> savedItems = [
    {'title': 'Dream Pop Essentials', 'artist': 'Various Artists'},
    {'title': 'Chill Beats', 'artist': 'Lofi Makers'},
    {'title': 'Soulful Mornings', 'artist': 'Soul Collective'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.redAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: savedItems.length,
            itemBuilder: (context, index) {
              final item = savedItems[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.music_note, size: 28, color: Colors.deepPurple),
                  ),
                  title: Text(
                    item['title']!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(item['artist']!),
                  trailing: const Icon(Icons.play_arrow),
                  onTap: () {
                    // play or open
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
