import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming/app/service_locator/service_locator.dart';
import 'package:music_streaming/core/common/snackbar/my_snackbar.dart';
import 'package:music_streaming/features/auth/domain/use_case/user_login_usecase.dart';
import 'package:music_streaming/features/auth/presentation/view/register_view.dart';
import 'package:music_streaming/features/auth/presentation/view_model/login/login_event.dart';
import 'package:music_streaming/features/auth/presentation/view_model/login/login_state.dart';
import 'package:music_streaming/features/auth/presentation/view_model/register/register_view_model.dart';
import 'package:music_streaming/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:music_streaming/features/dashboard/presentation/view_model/dashboard_view_model.dart';

class LoginViewModel extends Bloc<LoginEvent, LoginState> {
  final UserLoginUsecase _userLoginUsecase;

  LoginViewModel(this._userLoginUsecase) : super(LoginState.initial()) {
    on<NavigateToRegisterViewEvent>(_onNavigateToRegisterView);
    on<NavigateToHomeViewEvent>(_onNavigateToHomeView);
    on<LoginWithEmailAndPasswordEvent>(_onLoginWithEmailAndPassword);
  }

  void _onNavigateToRegisterView(
    NavigateToRegisterViewEvent event,
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
    NavigateToHomeViewEvent event,
    Emitter<LoginState> emit,
  ) {
    if (event.context.mounted) {
      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: serviceLocator<DashboardViewModel>(),
            child: const DashboardView(),
          ),
        ),
      );
    }
  }

  void _onLoginWithEmailAndPassword(
    LoginWithEmailAndPasswordEvent event,
    Emitter<LoginState> emit,
  ) async {
    // Add actual login logic here (API call, validation, etc.)
    emit(state.copyWith(isLoading: true));
    final result = await _userLoginUsecase(
      UserLoginParams(email: event.email, password: event.password)
    );
    
    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));

        showMySnackBar(
          context: event.context,
          message: 'Invalid credentials. Please try again.',
          color: Colors.red,
        );
      }, 
      (token) {
        // Handle success case
        emit(state.copyWith(isLoading: false, isSuccess: true));
        add(NavigateToHomeViewEvent(context: event.context));
      }
    );

    Future.delayed(const Duration(seconds: 2), () {
      emit(state.copyWith(isLoading: false, isSuccess: true));
    });
  }
}
