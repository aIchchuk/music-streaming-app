import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:music_streaming/features/dashboard/presentation/view_model/dashboard_view_model.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TOOT - Music Streaming',
      debugShowCheckedModeBanner: false,
      // theme: appThemeData, // Use the extracted ThemeData
      home: DashboardView();
    );
  }
}