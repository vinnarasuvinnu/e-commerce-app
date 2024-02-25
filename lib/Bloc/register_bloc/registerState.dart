import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable{
  const RegisterState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class RegisterUninitialized extends RegisterState{}

class RegisterError extends RegisterState{
  final String errorMsg;
  const RegisterError({required this.errorMsg});
  @override
  // TODO: implement props
  List<Object> get props => [errorMsg];
}

class RegisterSuccess extends RegisterState{}

class RegisterLoading extends RegisterState{}