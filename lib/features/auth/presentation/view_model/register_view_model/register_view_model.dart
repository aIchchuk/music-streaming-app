import 'package:batch_34a/core/common/snackbar/my_snackbar.dart';
import 'package:batch_34a/features/auth/domain/use_case/user_image_upload_usecase.dart';
import 'package:batch_34a/features/auth/domain/use_case/user_register_usecase.dart';
import 'package:batch_34a/features/auth/presentation/view_model/register_view_model/register_event.dart';
import 'package:batch_34a/features/auth/presentation/view_model/register_view_model/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class RegisterViewModel extends Bloc<RegisterEvent, RegisterState> {
  final UserRegisterUsecase _userRegisterUsecase;
  final UserImageUploadUsecase _uploadImageUsecase;

  RegisterViewModel(
    this._userRegisterUsecase,
    this._uploadImageUsecase,
  ) : super(RegisterState.initial()) {
    on<RegisterUserEvent>(_onRegisterUser);
    on<UploadImageEvent>(_onLoadImage);
  }



  Future<void> _onRegisterUser(
    RegisterUserEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _userRegisterUsecase(
      RegisterUserParams(
        fullName: event.fullName,
        phone: event.phone,
        username: event.username,
        password: event.password,
        image: state.imageName,
      ),
    );

    result.fold(
      (l) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
          context: event.context,
          message: l.message,
          color: Colors.red,
        );
      },
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
          context: event.context,
          message: "Registration Successful",
        );
      },
    );
  }

  void _onLoadImage(UploadImageEvent event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _uploadImageUsecase.call(
      UploadImageParams(file: event.file),
    );

    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true, imageName: r));
      },
    );
  }
}
