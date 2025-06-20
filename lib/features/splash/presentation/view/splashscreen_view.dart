import 'package:flutter/material.dart';
import 'dart:async';
import 'package:batch_34a/features/auth/presentation/view/login_screen_view.dart';

class SplashscreenView extends StatefulWidget {
  @override
  _SplashscreenViewState createState() => _SplashscreenViewState();
}

class _SplashscreenViewState extends State<SplashscreenView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // Set the bounce animation
    _bounceAnimation = Tween<double>(begin: 0, end: 15)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_controller);

    // Repeat the animation
    _controller.repeat(reverse: true);

    // After 2 seconds, stop the animation and navigate to the Login Screen
    Timer(const Duration(seconds: 2), () {
      _controller.stop();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreenView()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();  // Clean up the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepOrange, Colors.redAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.translate(
                    offset: Offset(0, -_bounceAnimation.value),
                    child: const Icon(
                      Icons.music_note,
                      size: 100,
                      color: Colors.white, // White for contrast
                    ),
                  ),
                  const SizedBox(height: 20),
                  Transform.translate(
                    offset: Offset(0, _bounceAnimation.value),
                    child: const Text(
                      'TOOT',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // White for readability
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 180,
                    child: LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      backgroundColor: Colors.white30,
                      minHeight: 5, // Shorter for a sleeker look
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
