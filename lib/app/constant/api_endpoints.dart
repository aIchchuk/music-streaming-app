class ApiEndpoints {
  ApiEndpoints._();

  // Timeouts
  static const connectionTimeout = Duration(seconds: 30);
  static const receiveTimeout = Duration(seconds: 30);

  // ✅ Emulator & Localhost settings
  // For Android Emulator use: 10.0.2.2
  // For iOS Simulator / desktop use: localhost
  static const String serverAddress = "http://10.0.2.2:5000";
  static const String baseUrl = "$serverAddress";

  // ✅ Static file paths (public folder)
  static const String uploads = "$baseUrl/uploads/";
  static const String songFiles = "$baseUrl/songs/";
  static const String coverImages = "$baseUrl/cover-images/";

  // ======================== AUTH ========================
  static const String login = "$baseUrl/auth/login";
  static const String register = "$baseUrl/auth/register";

  // ======================== USER ========================
  static const String getAllUsers = "$baseUrl/user/getAllUsers";
  static const String getUserById = "$baseUrl/user/getUserById/";
  static const String updateUserById = "$baseUrl/user/updateUserById/";
  static const String deleteUserById = "$baseUrl/user/deleteUserById/";

  // ======================== SONG ========================
  static const String getAllSongs = "$baseUrl/song/getAllSong";
  static const String getSongById = "$baseUrl/song/getSongById/";
  static const String getSongByName = "$baseUrl/song/getSongByName/";
  static const String createSong = "$baseUrl/song/createSong";
  static const String updateSong = "$baseUrl/song/updateSong/";
  static const String deleteSong = "$baseUrl/song/deleteSong/";

  static const String featuredSongs = "$baseUrl/song/featuredSong";
  static const String madeForYouSongs = "$baseUrl/song/madeForYouSong";
  static const String trendingSongs = "$baseUrl/song/trendingSong";
  static const String convertReelToSong = "$baseUrl/song/convert-reel";

  // ======================== ALBUM ========================
  static const String getAllAlbums = "$baseUrl/album/getAllAlbum";
  static const String getAlbumById = "$baseUrl/album/getAlbumById/";
  static const String createAlbum = "$baseUrl/album/createAlbum";
  static const String updateAlbum = "$baseUrl/album/updateAlbum/";
  static const String deleteAlbum = "$baseUrl/album/deleteAlbum/";
  static const String addSongToAlbum = "$baseUrl/album/";
  static const String removeSongFromAlbum = "$baseUrl/album/";

  // ======================== PLAYLIST ========================
  static const String getAllPlaylists = "$baseUrl/playlist/";
  static const String getPlaylistById = "$baseUrl/playlist/";
  static const String createPlaylist = "$baseUrl/playlist/";
  static const String updatePlaylist = "$baseUrl/playlist/";
  static const String deletePlaylist = "$baseUrl/playlist/";
  static const String addSongToPlaylist = "$baseUrl/playlist/";
  static const String removeSongFromPlaylist = "$baseUrl/playlist/";

  // ======================== STATISTICS ========================
  static const String getStats = "$baseUrl/stat";

  // ======================== SEARCH ========================
  static const String getSuggestions = "$baseUrl/search/suggestions";
}
