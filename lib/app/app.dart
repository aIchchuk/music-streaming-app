import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming/app/service_locator/service_locator.dart';
import 'package:music_streaming/features/splash/presentation/view/splash_view.dart';
import 'package:music_streaming/features/splash/presentation/view_model/splash_view_model.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TOOT - Music Streaming',
      debugShowCheckedModeBanner: false,
      // theme: appThemeData, // Use the extracted ThemeData
      home: BlocProvider.value(
        value: serviceLocator<SplashViewModel>(),
        child: SplashView(),
      )
    );
  }
}