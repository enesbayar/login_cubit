part of 'login_cubit.dart';

@immutable
abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {

  
}

class LoginLoading extends LoginState {}

class LoginValidateState extends LoginState{
  final bool isValidate;

  LoginValidateState(this.isValidate);

  @override
  List<Object?> get props => [isValidate];

}

class LoginCompleted extends LoginState{
  final LoginResponse loginResponse;

  LoginCompleted(this.loginResponse);

  @override
  List<Object?> get props => [loginResponse];

}

class LoginFailed extends LoginState {
  final String errorMessage;

  LoginFailed(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];

}
