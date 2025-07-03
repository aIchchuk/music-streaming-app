import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming/app/service_locator/service_locator.dart';
import 'package:music_streaming/features/auth/presentation/view/login_view.dart';
import 'package:music_streaming/features/auth/presentation/view_model/login/login_view_model.dart';
import 'package:music_streaming/features/auth/presentation/view_model/register/register_event.dart';
import 'package:music_streaming/features/auth/presentation/view_model/register/register_state.dart';

class RegisterViewModel extends Bloc<RegisterEvent, RegisterState> {
  RegisterViewModel() : super(RegisterState.initial()) {
    on<RegisterUserEvent>(_onRegisterUser);
  }

  Future<void> _onRegisterUser(
    RegisterUserEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    // Simulate registration logic (API call, DB save, etc.)
    await Future.delayed(const Duration(seconds: 2));

    emit(state.copyWith(isLoading: false, isSuccess: true));

    if (event.context.mounted) {
      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: serviceLocator<LoginViewModel>(),
            child: LoginView(),
          ),
        ),
      );
    }
  }
}
