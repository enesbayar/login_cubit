import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../model/login_request.dart';
import '../../model/login_response.dart';
import '../../service/i_login_service.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final ILoginService loginService;

  bool isValidationFail = false;

  LoginCubit(this.emailController, this.passwordController, this.formKey,
      {required this.loginService})
      : super(LoginInitial());

  void loginRequest() async {
    emit(LoginLoading());
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      try {
        final loginRequest = LoginRequest(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
        final data = await loginService.loginRequest(loginRequest);

        if (data is LoginResponse) {
          emit(LoginCompleted(data));
        } else {
          emit(LoginFailed("Errorrr"));
        }
      } catch (e) {
        emit(LoginFailed(e.toString()));
      }
    } else{
      isValidationFail = true;
      emit(LoginValidateState(isValidationFail));
    }
  }
}
