import 'package:music_streaming/app/service_locator/service_locator.dart';
import 'package:music_streaming/core/network/hive_service.dart';

import 'app/app.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  await HiveService().init();
  
  runApp(App());
}