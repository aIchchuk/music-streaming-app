
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming/core/common/snackbar/my_snackbar.dart';
import 'package:music_streaming/features/auth/domain/use_case/user_register_usecase.dart';
import 'package:music_streaming/features/auth/presentation/view_model/register/register_event.dart';
import 'package:music_streaming/features/auth/presentation/view_model/register/register_state.dart';

class RegisterViewModel extends Bloc<RegisterEvent, RegisterState>{

  final UserRegisterUsecase _userRegisterUsecase;


  RegisterViewModel( this._userRegisterUsecase ) : super(RegisterState.initial()) {
    on<UserRegisterEvent>(_userRegister);
  }

  Future<void> _userRegister( UserRegisterEvent event, Emitter<RegisterState> emit,) async {
    emit(state.copyWith(isLoading: true));

    final result = await _userRegisterUsecase(
      UserRegisterParams(
        fullName: event.fullName,
        email: event.email,
        password: event.password,
      )
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
          context: event.context,
          message: failure.message,
          color: Colors.red,
        );
      },
      (success) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
          context: event.context,
          message: "Registration Successful",
        );
      },
    );
  }

} 

