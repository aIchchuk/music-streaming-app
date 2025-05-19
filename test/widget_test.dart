import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:music_streaming/app.dart'; // 👈 Correct import

void main() {
  testWidgets('App renders without crashing', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());

    // You can adjust this test based on what you want to verify.
    // For now, just check if "Music Stream" is visible from the splash screen.
    expect(find.text('Music Stream'), findsOneWidget);
    expect(find.byIcon(Icons.music_note), findsOneWidget);
  });
}
