import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming/features/splash/presentation/view_model/splash_view_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: 0, end: 20).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    context.read<SplashViewModel>().init(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black, // solid black background
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.translate(
                    offset: Offset(0, -_bounceAnimation.value),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent.shade400, // circle background color
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.greenAccent.withOpacity(0.6),
                            blurRadius: 10,
                            spreadRadius: 1,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.music_note,
                        size: 60,
                        color: Colors.black, // icon color contrasting with green bg
                      ),
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
                        color: Colors.greenAccent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const SizedBox(
                    width: 180,
                    child: LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                      backgroundColor: Colors.white12,
                      minHeight: 5,
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
