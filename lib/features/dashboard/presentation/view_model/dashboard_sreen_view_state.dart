import 'package:batch_34a/app/service_locator/service_locator.dart';
import 'package:batch_34a/features/dashboard/presentation/view/dashboard/dashboard_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreenViewState {  // Renamed HomeState to DashboardScreenViewState
  final int selectedIndex;
  final List<Widget> views;

  const DashboardScreenViewState({required this.selectedIndex, required this.views});

  // Initial state
  static DashboardScreenViewState initial() {  // Updated to DashboardScreenViewState
    return DashboardScreenViewState(
      selectedIndex: 0,
      views: [
        DashboardScreenView(),
      ],
    );
  }

  DashboardScreenViewState copyWith({int? selectedIndex, List<Widget>? views}) {  // Updated to DashboardScreenViewState
    return DashboardScreenViewState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }
}
