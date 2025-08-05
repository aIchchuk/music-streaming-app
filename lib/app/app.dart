import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming/app/service_locator/service_locator.dart';
import 'package:music_streaming/features/album/presentation/view_model/album_view_model.dart';
import 'package:music_streaming/features/album/presentation/view_model/album_event.dart';
import 'package:music_streaming/features/song/presentation/view_model/song_event.dart';
import 'package:music_streaming/features/song/presentation/view_model/song_view_model.dart';
import 'package:music_streaming/features/splash/presentation/view/splash_view.dart';
import 'package:music_streaming/features/splash/presentation/view_model/splash_view_model.dart';
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashViewModel>(
          create: (_) => serviceLocator<SplashViewModel>(),
        ),
        BlocProvider<AlbumViewModel>(
          create: (_) => serviceLocator<AlbumViewModel>()..add(GetAllAlbumEvent()),
        ),
        BlocProvider<SongViewModel>(
          create: (_) => serviceLocator<SongViewModel>()..add(GetAllSongEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'TOOT - Music Streaming',
        debugShowCheckedModeBanner: false,
        home: const SplashView(),
      ),
    );
  }
}
