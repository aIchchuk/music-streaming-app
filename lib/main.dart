import 'package:flutter/material.dart';
import 'package:batch_34a/app/app.dart';  // Import your app.dart
import 'package:batch_34a/app/service_locator/service_locator.dart'; // Adjust to your path
import 'package:batch_34a/core/network/hive_service.dart'; // Adjust this import as well

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize the dependencies via service locator
  await initDependencies();
  
  // Initialize Hive or any other services
  await HiveService().init();

  // Optionally, clear the database if needed (can be disabled in production)
  // await HiveService().clearAll();

  // Run the app after all dependencies and services are initialized
  runApp(const App());
}
