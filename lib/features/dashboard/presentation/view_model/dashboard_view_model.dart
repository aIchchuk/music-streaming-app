import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming/features/dashboard/presentation/view_model/dashboard_state.dart';

class DashboardViewModel extends Cubit<DashboardState>{
  DashboardViewModel() : super(DashboardState.initial());

  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }
}