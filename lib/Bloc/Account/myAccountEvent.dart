import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class MyAccountEvent extends Equatable{
  const MyAccountEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchMyAccountInfo extends MyAccountEvent{}

class SelectGender extends MyAccountEvent{
  final int gender;
  const SelectGender({required this.gender});
  @override
  // TODO: implement props
  List<Object> get props => [gender];
}

class UpdateAccount extends MyAccountEvent{

  final String username;
  final String email;

  const UpdateAccount({required this.username,required this.email});

  @override
  // TODO: implement props
  List<Object> get props => [username,email];

}

class FetchSettingsInfo extends MyAccountEvent{}


class LogoutUser extends MyAccountEvent{}

class FetchContactUs extends MyAccountEvent{}