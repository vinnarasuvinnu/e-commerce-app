import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable{
  const AuthenticationEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent{}

class MobileRegistered extends AuthenticationEvent{}


