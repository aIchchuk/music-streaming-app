import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_streaming/features/auth/presentation/view_model/register/register_event.dart';
import 'package:music_streaming/features/auth/presentation/view_model/register/register_state.dart';
import 'package:music_streaming/features/auth/presentation/view_model/register/register_view_model.dart';
import 'package:permission_handler/permission_handler.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _key = GlobalKey<FormState>();
  final _gap = const SizedBox(height: 12);
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


  static const Color spotifyGreen = Color(0xFF1DB954);

  Future<void> _checkCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isDenied || status.isRestricted) {
      await Permission.camera.request();
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: BlocBuilder<RegisterViewModel, RegisterState>(
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // InkWell(
                      //   onTap: () => _showImagePickerModal(context),
                      //   child: CircleAvatar(
                      //     radius: 75,
                      //     backgroundImage: _img != null
                      //         ? FileImage(_img!)
                      //         : const AssetImage('assets/images/songs.png') as ImageProvider,
                      //   ),
                      // ),
                      const SizedBox(height: 20),
                      _buildStyledTextFormField(
                        controller: _fullNameController,
                        label: 'Full Name',
                        validator: (value) => value == null || value.isEmpty ? 'Enter full name' : null,
                      ),
                      _gap,
                      _buildStyledTextFormField(
                        controller: _emailController,
                        label: 'Email',
                        validator: (value) => value == null || value.isEmpty ? 'Enter email' : null,
                      ),
                      _gap,
                      _buildStyledTextFormField(
                        controller: _passwordController,
                        label: 'Password',
                        obscureText: true,
                        validator: (value) => value == null || value.isEmpty ? 'Enter password' : null,
                      ),
                      _gap,
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
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: state.isLoading
                              ? const CircularProgressIndicator(color: Colors.black)
                              : const Text(
                                  'Register',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
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
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
    );
  }
}
