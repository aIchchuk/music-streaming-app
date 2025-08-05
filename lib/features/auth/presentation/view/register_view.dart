import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming/features/auth/presentation/view_model/register/register_event.dart';
import 'package:music_streaming/features/auth/presentation/view_model/register/register_state.dart';
import 'package:music_streaming/features/auth/presentation/view_model/register/register_view_model.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _key = GlobalKey<FormState>();
  final _gap = const SizedBox(height: 16);
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  static const Color spotifyGreen = Color(0xFF1DB954);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // match LoginView dark bg
      body: BlocBuilder<RegisterViewModel, RegisterState>(
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Welcome Texts
                    Text(
                      'New to TOOT?',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: spotifyGreen,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Let\'s get you started with an account',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),

                    // Icon with green circular bg (matching LoginView style)
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
                        Icons.person_add,
                        size: 60,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Form fields
                    _buildStyledTextFormField(
                      controller: _fullNameController,
                      label: 'Full Name',
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Enter full name' : null,
                    ),
                    _gap,
                    _buildStyledTextFormField(
                      controller: _emailController,
                      label: 'Email',
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Enter email' : null,
                    ),
                    _gap,
                    _buildStyledTextFormField(
                      controller: _passwordController,
                      label: 'Password',
                      obscureText: true,
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Enter password' : null,
                    ),
                    _gap,

                    // Register Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            context.read<RegisterViewModel>().add(
                                  UserRegisterEvent(
                                    context: context,
                                    fullName: _fullNameController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: spotifyGreen,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 8,
                          shadowColor: spotifyGreen.withOpacity(0.6),
                        ),
                        child: state.isLoading
                            ? const CircularProgressIndicator(color: Colors.black)
                            : const Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.1,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStyledTextFormField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      validator: validator,
      decoration: InputDecoration(
        hintText: label,
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
