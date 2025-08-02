import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_streaming/app/service_locator/service_locator.dart';
import 'package:music_streaming/core/network/hive_service.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await initDependencies();


  // Now re-init with adapters again
  await serviceLocator<HiveService>().init();

  runApp(App());
}
