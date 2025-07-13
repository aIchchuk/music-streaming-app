
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_streaming/core/common/snackbar/my_snackbar.dart';
import 'package:music_streaming/features/auth/domain/use_case/user_register_usecase.dart';
import 'package:music_streaming/features/auth/domain/use_case/user_upload_image_usecase.dart';
import 'package:music_streaming/features/auth/presentation/view_model/register/register_event.dart';
import 'package:music_streaming/features/auth/presentation/view_model/register/register_state.dart';

class RegisterViewModel extends Bloc<RegisterEvent, RegisterState>{

  final UserRegisterUsecase _userRegisterUsecase;
  final UserUploadImageUsecase _userUploadImageUsecase;

  RegisterViewModel( this._userRegisterUsecase, this._userUploadImageUsecase ) : super(RegisterState.initial()) {
    on<UserRegisterEvent>(_userRegister);
    on<UserUploadImageEvent>(_userUploadImage);
  }

  Future<void> _userRegister( UserRegisterEvent event, Emitter<RegisterState> emit,) async {
    emit(state.copyWith(isLoading: true));

    final result = await _userRegisterUsecase(
      UserRegisterParams(
        fullName: event.fullName,
        phoneNo: event.phoneNo,
        userImage: event.userImage,
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

  Future<void> _userUploadImage( UserUploadImageEvent event, Emitter<RegisterState> emit) async {

    emit(state.copyWith(isLoading: true));
    final result = await _userUploadImageUsecase(UserUploadImageParams(file: event.file));
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (imageUrl) => emit(state.copyWith(isLoading: false, imageName: imageUrl))
    );
  }
} 

