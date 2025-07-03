import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming/app/service_locator/service_locator.dart';
import 'package:music_streaming/features/auth/presentation/view/register_view.dart';
import 'package:music_streaming/features/auth/presentation/view_model/login/login_event.dart';
import 'package:music_streaming/features/auth/presentation/view_model/login/login_state.dart';
import 'package:music_streaming/features/auth/presentation/view_model/register/register_view_model.dart';
import 'package:music_streaming/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:music_streaming/features/dashboard/presentation/view_model/dashboard_view_model.dart';

class LoginViewModel extends Bloc<LoginEvent, LoginState> {
  LoginViewModel() : super(LoginState.initial()) {
    on<NavigateToRegisterView>(_onNavigateToRegisterView);
    on<NavigateToHomeView>(_onNavigateToHomeView);
    on<LoginWithEmailAndPassword>(_onLoginWithEmailAndPassword);
  }

  void _onNavigateToRegisterView(
    NavigateToRegisterView event,
    Emitter<LoginState> emit,
  ) {
    if (event.context.mounted) {
      Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: serviceLocator<RegisterViewModel>(),
            child: RegisterView(),
          ),
        ),
      );
    }
  }

  void _onNavigateToHomeView(
    NavigateToHomeView event,
    Emitter<LoginState> emit,
  ) {
    if (event.context.mounted) {
      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: serviceLocator<DashboardViewModel>(),
            child: DashboardView(),
          ),
        ),
      );
    }
  }

  void _onLoginWithEmailAndPassword(
    LoginWithEmailAndPassword event,
    Emitter<LoginState> emit,
  ) {
    // Add actual login logic here (API call, validation, etc.)
    emit(state.copyWith(isLoading: true));
    // Simulate login...
    Future.delayed(const Duration(seconds: 2), () {
      emit(state.copyWith(isLoading: false, isSuccess: true));
    });
  }
}
