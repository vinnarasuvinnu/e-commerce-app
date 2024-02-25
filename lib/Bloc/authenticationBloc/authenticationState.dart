import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationInitialized extends AuthenticationState {}

class AuthenticationHomeScreen extends AuthenticationState {}
