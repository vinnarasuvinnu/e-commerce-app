import 'dart:convert';

import 'package:fins_user/Bloc/register_bloc/registerState.dart';
import 'package:fins_user/Models/custom_result.dart';
import 'package:fins_user/repository/userRepository.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'registerEvent.dart';

class RegisterBloc extends Bloc<RegisterEvent,RegisterState>{
  late String registerUrl=Fins.ip+"home/register";
  late String phone;
  UserRepository userRepository=UserRepository();

  RegisterBloc(RegisterState initialState) : super(initialState);
  @override
  // TODO: implement initialState
  RegisterState get initialState => RegisterUninitialized();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event)async* {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();

    // phone=sharedPreferences.getString("mobile");
    // TODO: implement mapEventToState
    if(event is RegisterUserEvent){
      yield RegisterLoading();
      try{

        final updateUserResponse=await userRepository.updateUser(url: registerUrl,phone: event.mobileNumber,firstName: event.firstName,email: event.email,password: event.password,gender: event.gender);
        CustomResults customResult=CustomResults.fromJson(jsonDecode(updateUserResponse.data));
        if(customResult.result=="success"){
          yield RegisterSuccess();
        }
        else{
          yield RegisterError(
            errorMsg: customResult.description
          );

        }

      }
      catch(e){
        print(e);
      }
    }
  }
}