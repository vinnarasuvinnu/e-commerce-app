import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable{
  const RegisterEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class RegisterUserEvent extends RegisterEvent{
  final String firstName;
  final String mobileNumber;
  final String password;
  final String email;
  final int gender;

  const RegisterUserEvent({required this.firstName,required this.mobileNumber,required this.email,required this.password,required this.gender});

  @override
  // TODO: implement props
  List<Object> get props => [firstName,password,email,gender];
}