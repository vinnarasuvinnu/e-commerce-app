import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class PasswordState extends Equatable{
  const PasswordState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class PasswordUninitialized extends PasswordState{}

class OtpScreenLoaded extends PasswordState{
  final String phone;
  const OtpScreenLoaded({required this.phone});

  @override
  // TODO: implement props
  List<Object> get props => [phone];
}

class PasswordError extends PasswordState{}

class OtpReceivedState extends PasswordState{
  final msg;
  const OtpReceivedState({required this.msg});
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}

class OtpNonReceivedState extends PasswordState{}

class PasswordOtpVerifiedState extends PasswordState{}

class PasswordOtpVerificationError extends PasswordState{}


class PasswordChangedState extends PasswordState{}

class PasswordChangeErrorState extends PasswordState{}