import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable{
  const LoginEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoginUserEvent extends LoginEvent{
  final String username;
  final String password;
  const LoginUserEvent({required this.username,required this.password});
  @override
  // TODO: implement props
  List<Object> get props => [username,password];
}

class ForgotPasswordEvent extends LoginEvent{
  final String phone;
  const ForgotPasswordEvent({required this.phone});

  @override
  // TODO: implement props
  List<Object> get props => [phone];

}