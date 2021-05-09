part of 'login_cubit.dart';

@immutable
abstract class LoginState extends Equatable {
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {

  
}

class LoginLoading extends LoginState {}

class LoginValidateState extends LoginState{
  final bool isValidate;

  LoginValidateState(this.isValidate);

  List<Object?> get props => [this.isValidate];

}

class LoginCompleted extends LoginState{
  final LoginResponse loginResponse;

  LoginCompleted(this.loginResponse);

  List<Object?> get props => [this.loginResponse];

}

class LoginFailed extends LoginState {
  final String errorMessage;

  LoginFailed(this.errorMessage);

  List<Object?> get props => [this.errorMessage];

}
