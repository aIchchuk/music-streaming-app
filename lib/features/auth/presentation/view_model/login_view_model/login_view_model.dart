import 'package:batch_34a/app/service_locator/service_locator.dart';
import 'package:batch_34a/core/common/snackbar/my_snackbar.dart';
import 'package:batch_34a/features/auth/domain/use_case/user_login_usecase.dart';
import 'package:batch_34a/features/auth/presentation/view/register_screen_view.dart';
import 'package:batch_34a/features/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:batch_34a/features/auth/presentation/view_model/login_view_model/login_state.dart';
import 'package:batch_34a/features/dashboard/presentation/view/dashboard/dashboard_screen_view.dart';
import 'package:batch_34a/features/dashboard/presentation/view_model/dashboard_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginViewModel extends Bloc<LoginEvent, LoginState> {
  final UserLoginUsecase _studentLoginUsecase;

  LoginViewModel(this._studentLoginUsecase) : super(LoginState.initial()) {
    on<NavigateToRegisterViewEvent>(_onNavigateToRegisterView);
    on<NavigateToHomeViewEvent>(_onNavigateToDashboardScreenView); // Changed this
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
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: serviceLocator<LoginViewModel>()),
            ],
            child: RegisterScreenView(),
          ),
        ),
      );
    }
  }

  void _onNavigateToDashboardScreenView( // Changed this method name
    NavigateToHomeViewEvent event,
    Emitter<LoginState> emit,
  ) {
    if (event.context.mounted) {
      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: serviceLocator<DashboardScreenViewModel>(), // Changed HomeViewModel to DashboardScreenViewModel
            child: const DashboardScreenView(), // Changed HomeView to DashboardScreenView
          ),
        ),
      );
    }
  }

  void _onLoginWithEmailAndPassword(
    LoginWithEmailAndPasswordEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _studentLoginUsecase(
      LoginParams(username: event.username, password: event.password),
    );

    result.fold(
      (failure) {
        // Handle failure case
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
        add(NavigateToHomeViewEvent(context: event.context)); // This will trigger NavigateToDashboardScreenViewEvent
      },
    );
  }
}
