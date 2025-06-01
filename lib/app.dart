
import 'package:batch_34a/theme/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'View/splashscreen_view.dart';


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
