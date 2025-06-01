import 'package:flutter/material.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  final List<Map<String, String>> savedItems = [
    {
      'title': 'Dream Pop Essentials',
      'artist': 'Various Artists',
      'image': 'https://via.placeholder.com/100x100/4CAF50/FFFFFF?text=DP',
    },
    {
      'title': 'Chill Beats',
      'artist': 'Lofi Makers',
      'image': 'https://via.placeholder.com/100x100/9C27B0/FFFFFF?text=CB',
    },
    {
      'title': 'Soulful Mornings',
      'artist': 'Soul Collective',
      'image': 'https://via.placeholder.com/100x100/FF9800/000000?text=SM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: savedItems.length,
      itemBuilder: (context, index) {
        final item = savedItems[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(item['image']!, width: 60, height: 60, fit: BoxFit.cover),
            ),
            title: Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(item['artist']!),
            trailing: const Icon(Icons.play_arrow),
            onTap: () {
              // handle tap, like play or open details
            },
          ),
        );
      },
    );
  }
}
