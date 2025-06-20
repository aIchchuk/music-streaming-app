import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:batch_34a/app/service_locator/service_locator.dart';
import 'package:batch_34a/app/theme/app_theme_data.dart';
import 'package:batch_34a/features/splash/presentation/view/splashscreen_view.dart'; // Adjust to your path

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appThemeData,  // Use the extracted ThemeData
      home: SplashscreenView(),  // Set the SplashScreen as the home widget
    );
  }
}
