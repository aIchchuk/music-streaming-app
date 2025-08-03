import 'package:flutter/material.dart';
import 'package:music_streaming/app/app.dart';
import 'package:music_streaming/app/service_locator/service_locator.dart';
import 'package:music_streaming/core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  // init Hive service
  await HiveService().init();
  // Delete database
  // await HiveService().clearAll();
  runApp(App());
}
