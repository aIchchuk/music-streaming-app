import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, String>> featured = const [
    {
      'title': 'Lofi Vibes',
      'artist': 'Chillhop',
      'image': 'https://via.placeholder.com/300x150/8E24AA/FFFFFF?text=Lofi',
    },
    {
      'title': 'Summer Beats',
      'artist': 'DJ Sun',
      'image': 'https://via.placeholder.com/300x150/FF9800/FFFFFF?text=Summer',
    },
    {
      'title': 'Pop Hits',
      'artist': 'Various',
      'image': 'https://via.placeholder.com/300x150/E91E63/FFFFFF?text=Pop',
    },
  ];

  final List<Map<String, String>> albums = const [
    {
      'title': 'Urban Grooves',
      'artist': 'City Sound',
      'image': 'https://via.placeholder.com/150/2196F3/FFFFFF?text=Urban',
    },
    {
      'title': 'Dream Pop',
      'artist': 'Nightfall',
      'image': 'https://via.placeholder.com/150/009688/FFFFFF?text=Dream',
    },
    {
      'title': 'Synthwave',
      'artist': 'Neon Drive',
      'image': 'https://via.placeholder.com/150/673AB7/FFFFFF?text=Synth',
    },
    {
      'title': 'Nature Calm',
      'artist': 'Earth Tones',
      'image': 'https://via.placeholder.com/150/4CAF50/FFFFFF?text=Nature',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toot Music'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.account_circle)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Featured
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Featured Albums',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: featured.length,
                itemBuilder: (context, index) {
                  final item = featured[index];
                  return Container(
                    width: 300,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(item['image']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '${item['title']} \nby ${item['artist']}',
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Grid Albums
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'New Releases',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            GridView.builder(
              itemCount: albums.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final album = albums[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.network(
                          album['image']!,
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(album['title']!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(album['artist']!,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12)),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            minimumSize: const Size.fromHeight(30),
                          ),
                          child: const Text('Add to Library'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepPurple,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.library_music), label: 'Library'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
