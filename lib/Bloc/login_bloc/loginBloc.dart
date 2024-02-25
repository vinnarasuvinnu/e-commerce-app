import 'dart:convert';

import 'package:fins_user/Models/custom_result.dart';
import 'package:fins_user/repository/userRepository.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'loginEvent.dart';
import 'loginState.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  String loginUrl = Fins.ip + "home/login/";
  String forgotPasswordUrl = Fins.ip + "home/sendOtp/";
  UserRepository userRepository = UserRepository();

  LoginBloc(LoginState initialState) : super(initialState);

  @override
  // TODO: implement initialState
  LoginState get initialState => LoginUninitialised();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // TODO: implement mapEventToState
    if (event is LoginUserEvent) {
      yield LoginLoading();

      try {
        final loginResponse = await userRepository.loginUser(
            url: loginUrl, phone: event.username, password: event.password);

        CustomResults customResult =
            CustomResults.fromJson(jsonDecode(loginResponse.data));
        if (customResult.result == "success") {
          sharedPreferences.setString("token", customResult.description);
          sharedPreferences.setString("mobile", event.username);
          sharedPreferences.setString("isLogin", "true");
          yield LoginSuccess();
        } else {
          yield LoginError(error: customResult.description);
        }
      } catch (error) {
        print(error);
      }
    }

    if (event is ForgotPasswordEvent) {
      yield LoginLoading();

      final response = await userRepository.forgotPasswordCheck(
          url: forgotPasswordUrl, phone: event.phone);
      CustomResults customResult =
          CustomResults.fromJson(jsonDecode(response.data));
      if (customResult.result == "success") {
        sharedPreferences.setString("mobile", event.phone);
        yield ForgotPasswordState();
      } else {
        yield ForgotPasswordErrorState();
      }
    }
  }
}
