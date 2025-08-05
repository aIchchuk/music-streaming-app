import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming/features/auth/presentation/view_model/login/login_event.dart';
import 'package:music_streaming/features/auth/presentation/view_model/login/login_view_model.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  static const Color spotifyGreen = Color(0xFF1DB954);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // dark black background
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Circular green bg with icon inside
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: spotifyGreen,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: spotifyGreen.withOpacity(0.7),
                          blurRadius: 15,
                          spreadRadius: 1,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.music_note,
                      size: 60,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildTextFormField(
                    controller: _emailController,
                    hint: 'Email',
                  ),
                  const SizedBox(height: 20),
                  _buildTextFormField(
                    controller: _passwordController,
                    hint: 'Password',
                    obscure: true,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<LoginViewModel>().add(
                              LoginWithEmailAndPasswordEvent(
                                context: context,
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: spotifyGreen,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      elevation: 8,
                      shadowColor: spotifyGreen.withOpacity(0.6),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      context.read<LoginViewModel>().add(
                            NavigateToRegisterViewEvent(context: context),
                          );
                    },
                    child: Text(
                      "Don't have an account? Register",
                      style: TextStyle(
                        color: spotifyGreen,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: spotifyGreen.withOpacity(0.7),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String hint,
    bool obscure = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.white10,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: spotifyGreen, width: 2),
        ),
      ),
    );
  }
}
