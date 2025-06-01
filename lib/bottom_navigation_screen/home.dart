import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // For Bottom Navigation Bar
  String _selectedCategory = 'All'; // For category tabs

  // --- Sample Data ---
  // You would typically fetch this from an API or a local database
  final String _userProfileImageUrl = 'https://via.placeholder.com/150/FFFFFF/000000?text=S'; // Placeholder for Samantha
  final String _discoverWeeklyImageUrl = 'https://via.placeholder.com/200x200/9C27B0/FFFFFF?text=Music'; // Placeholder for the girl with headphones

  final List<Map<String, String>> dailyPlaylists = [
    {
      'title': 'Starlit Reverie',
      'artist': 'Budiaarti',
      'songs': '8 Songs',
      'imageUrl': 'https://via.placeholder.com/100x100/FFC107/000000?text=P1',
    },
    {
      'title': 'Midnight Confessions',
      'artist': 'Luna Collective',
      'songs': '12 Songs',
      'imageUrl': 'https://via.placeholder.com/100x100/03A9F4/FFFFFF?text=P2',
    },
    {
      'title': 'Lost in the Echo',
      'artist': 'Echoes of Soul',
      'songs': '15 Songs',
      'imageUrl': 'https://via.placeholder.com/100x100/E91E63/FFFFFF?text=P3',
    },
    {
      'title': 'Morning Dew Melodies',
      'artist': 'Nature Sounds',
      'songs': '10 Songs',
      'imageUrl': 'https://via.placeholder.com/100x100/4CAF50/FFFFFF?text=P4',
    },
    {
      'title': 'Urban Rhythms',
      'artist': 'City Beats',
      'songs': '9 Songs',
      'imageUrl': 'https://via.placeholder.com/100x100/607D8B/FFFFFF?text=P5',
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // In a real app, you would navigate to different screens here
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background
      body: Stack( // Use Stack to place the 'Now Playing' bar over content
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Top Header ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundImage: NetworkImage(_userProfileImageUrl),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Hi, Samantha',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.search, color: Colors.white),
                              onPressed: () {
                                // Handle search
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.favorite_border, color: Colors.white),
                              onPressed: () {
                                // Handle favorites
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- Category Tabs ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildCategoryTab('All'),
                          const SizedBox(width: 8),
                          _buildCategoryTab('New Release'),
                          const SizedBox(width: 8),
                          _buildCategoryTab('Trending'),
                          const SizedBox(width: 8),
                          _buildCategoryTab('Top'),
                          const SizedBox(width: 8),
                          _buildCategoryTab('Genres'),
                          const SizedBox(width: 8),
                          _buildCategoryTab('Moods'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // --- Curated & Trending Section ---
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Curated & trending',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDiscoverWeeklyCard(),
                  const SizedBox(height: 30),

                  // --- Top Daily Playlists Section ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Top daily playlists',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Handle "See all"
                          },
                          child: const Text(
                            'See all',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDailyPlaylistsList(),
                  const SizedBox(height: 100), // Space for bottom bar
                ],
              ),
            ),
          ),
          // --- Now Playing Bar (positioned at the bottom) ---
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildNowPlayingBar(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black, // Match Scaffold background
        selectedItemColor: Colors.greenAccent, // Highlight selected icon
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed, // Ensures all labels are shown
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTab(String text) {
    final bool isSelected = _selectedCategory == text;
    return GestureDetector(
      onTap: () => _selectCategory(text),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.white.withOpacity(0.5) : Colors.white.withOpacity(0.3),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildDiscoverWeeklyCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade900, Colors.purple.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.shade900.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Discover weekly',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'The original slow instrumental best playlists.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.play_circle_fill, color: Colors.white, size: 36),
                          onPressed: () {
                            // Play action
                          },
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.bookmark_border, color: Colors.white70, size: 24),
                          onPressed: () {
                            // Bookmark action
                          },
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.more_horiz, color: Colors.white70, size: 24),
                          onPressed: () {
                            // More options
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              child: Image.network(
                _discoverWeeklyImageUrl,
                width: 150,
                height: double.infinity,
                fit: BoxFit.cover,
                // You might add a color filter if the image should be tinted
                // colorBlendMode: BlendMode.color,
                // color: Colors.purple.withOpacity(0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyPlaylistsList() {
    return ListView.builder(
      shrinkWrap: true, // Important to prevent unbounded height in Column
      physics: const NeverScrollableScrollPhysics(), // Disable internal scrolling
      itemCount: dailyPlaylists.length,
      itemBuilder: (context, index) {
        final playlist = dailyPlaylists[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  playlist['imageUrl']!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      playlist['title']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${playlist['artist']} • ${playlist['songs']}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.play_circle_fill, color: Colors.greenAccent, size: 30),
                onPressed: () {
                  // Play playlist
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNowPlayingBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade900, // Dark grey background
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://via.placeholder.com/60x60/424242/FFFFFF?text=Album', // Placeholder for current song album art
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lost in the Echo', // Current song title
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Echoes of Soul', // Current artist
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.skip_previous, color: Colors.white, size: 28),
                onPressed: () {
                  // Skip previous song
                },
              ),
              IconButton(
                icon: const Icon(Icons.pause_circle_filled, color: Colors.greenAccent, size: 40), // Example: pause icon
                onPressed: () {
                  // Play/Pause song
                },
              ),
              IconButton(
                icon: const Icon(Icons.skip_next, color: Colors.white, size: 28),
                onPressed: () {
                  // Skip next song
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}