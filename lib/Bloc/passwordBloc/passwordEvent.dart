import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class PasswordEvent extends Equatable{
  const PasswordEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class OtpScreenLoadEvent extends PasswordEvent{}

class RequestOtpPasswordChange extends PasswordEvent{}

class ResendOtpPasswordChange extends PasswordEvent{}

class ValidateOtpPasswordChange extends PasswordEvent{
  final String otp;
  const ValidateOtpPasswordChange({required this.otp});

  @override
  // TODO: implement props
  List<Object> get props => [otp];
}


class ChangePass extends PasswordEvent{
  final String password;
  // final String phone;
  const ChangePass({required this.password});
  @override
  // TODO: implement props
  List<Object> get props => [password];
}
