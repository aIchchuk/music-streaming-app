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
  final _phoneController = TextEditingController();

  File? _img;

  Future<void> _checkCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isDenied || status.isRestricted) {
      await Permission.camera.request();
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final picked = await ImagePicker().pickImage(source: source);
    if (picked != null) {
      setState(() {
        _img = File(picked.path);
      });

      context.read<RegisterViewModel>().add(UserUploadImageEvent(file: _img!));
    }
  }

  void _showImagePickerModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.grey[300],
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                _checkCameraPermission().then((_) {
                  _pickImage(ImageSource.camera);
                });
                Navigator.pop(context);
              },
              icon: const Icon(Icons.camera),
              label: const Text('Camera'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                _checkCameraPermission().then((_) {
                  _pickImage(ImageSource.gallery);
                });
                Navigator.pop(context);
              },
              icon: const Icon(Icons.image),
              label: const Text('Gallery'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity, // Ensure it fills the screen
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepOrange, Colors.redAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: BlocBuilder<RegisterViewModel, RegisterState>(
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => _showImagePickerModal(context),
                            child: SizedBox(
                              height: 150,
                              width: 150,
                              child: CircleAvatar(
                                radius: 75,
                                backgroundImage: _img != null
                                    ? FileImage(_img!)
                                    : const AssetImage('assets/images/songs.png') as ImageProvider,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildStyledTextFormField(
                            controller: _fullNameController,
                            label: 'Full Name',
                            validator: (value) =>
                                value == null || value.isEmpty ? 'Enter full name' : null,
                          ),
                          _gap,
                          _buildStyledTextFormField(
                            controller: _phoneController,
                            label: 'Phone No.',
                            validator: (value) =>
                                value == null || value.isEmpty ? 'Enter phone number' : null,
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
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_key.currentState!.validate()) {
                                  context.read<RegisterViewModel>().add(
                                        UserRegisterEvent(
                                          context: context,
                                          fullName: _fullNameController.text,
                                          phoneNo: _phoneController.text,
                                          userImage: state.imageName,
                                          email: _emailController.text,
                                          password: _passwordController.text
                                        )
                                      );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.deepPurple,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: state.isLoading
                                  ? const CircularProgressIndicator(color: Colors.deepPurple)
                                  : const Text(
                                      'Register',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'HelveticaNeueLight',
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
              ),
            );
          },
        ),
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
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
    );
  }
}
