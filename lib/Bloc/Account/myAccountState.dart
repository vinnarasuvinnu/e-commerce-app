import 'package:equatable/equatable.dart';
import 'package:fins_user/Models/Profile.dart';
// import 'package:fins_user/Models/user.dart';

abstract class MyAccountState extends Equatable{
  const MyAccountState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class MyAccountStateUninitialized extends MyAccountState{}

class MyAccountStateError extends MyAccountState{}

class MyAccountLoaded extends MyAccountState{
  final Profile profile;
  // final int gender;
  const MyAccountLoaded({required this.profile});
  @override
  // TODO: implement props
  List<Object> get props => [profile];
}

class MyAccountLoading extends MyAccountState{}

class AccountUpdated extends MyAccountState{}

class AccountUpdateError extends MyAccountState{}

class LogoutState extends MyAccountState{}


class SettingsLoaded extends MyAccountState{
  final bool loginStatus;

  const SettingsLoaded({required this.loginStatus});

  @override
  // TODO: implement props
  List<Object> get props => [loginStatus];
}

class ContactUsLoaded extends MyAccountState{
  final String phone;
  final String mail;
  const
   ContactUsLoaded({required this.phone,required this.mail});
  @override
  // TODO: implement props
  List<Object> get props => [phone,mail];

}

