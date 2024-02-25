import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable{
  const LoginState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoginError extends LoginState{
  final String error;
  const LoginError({required this.error});
  @override
  // TODO: implement props
  List<Object> get props => [error];
}


class LoginSuccess extends LoginState{}

class LoginLoading extends LoginState{}

class LoginUninitialised extends LoginState{}

class ForgotPasswordState extends LoginState{}

class ForgotPasswordErrorState extends LoginState{}