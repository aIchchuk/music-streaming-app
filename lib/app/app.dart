
import 'package:batch_34a/app/theme/app_theme_data.dart';
import 'package:flutter/material.dart';
import '../features/splash/presentation/view/splashscreen_view.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appThemeData, // Use the extracted ThemeData
      home: SplashscreenView(),
    );
  }
}
