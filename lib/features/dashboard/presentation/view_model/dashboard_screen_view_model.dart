import 'package:batch_34a/features/auth/presentation/view/login_screen_view.dart';
import 'package:batch_34a/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:batch_34a/features/dashboard/presentation/view_model/dashboard_sreen_view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class DashboardScreenViewModel extends Cubit<DashboardScreenViewState> {  // Changed to DashboardScreenViewModel
  DashboardScreenViewModel({required this.loginViewModel}) : super(DashboardScreenViewState.initial()); // Updated state

  final LoginViewModel loginViewModel;

  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void logout(BuildContext context) {
    // Wait for 2 seconds
    Future.delayed(const Duration(seconds: 2), () async {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                BlocProvider.value(value: loginViewModel, child: LoginScreenView()),
          ),
        );
      }
    });
  }
}
