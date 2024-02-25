import 'dart:convert';

import 'package:fins_user/Models/custom_result.dart';
import 'package:fins_user/repository/otpRepository.dart';
import 'package:fins_user/repository/userRepository.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'passwordEvent.dart';
import 'passwordState.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  late String requestOtpUrl = Fins.ip + "home/sendOtp/";
  late String validateOtpUrl = Fins.ip + "home/validateOtp/";
  late String resendOtpUrl = Fins.ip + "home/sendOtp/";
  late String updatePasswordUrl = Fins.ip + "home/changePassword/";
  late String phone;

  OtpRepository otpRepository = OtpRepository();
  UserRepository userRepository = UserRepository();

  PasswordBloc(PasswordState initialState) : super(initialState);

  @override
  // TODO: implement initialState
  PasswordState get initialState => PasswordUninitialized();

  @override
  Stream<PasswordState> mapEventToState(PasswordEvent event) async* {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    phone = sharedPreferences.getString("mobile");
    // TODO: implement mapEventToState

    if (event is OtpScreenLoadEvent) {
      yield OtpScreenLoaded(phone: phone);

      final response =
          await otpRepository.requestOtp(url: requestOtpUrl, phone: phone);
      var finalResponse = jsonDecode(response.body);
      CustomResults customResult = CustomResults.fromJson(finalResponse);
      if (customResult.result == "success") {

        yield OtpReceivedState(msg: customResult.description);
      } else {
        yield OtpNonReceivedState();
      }

      yield OtpScreenLoaded(phone: phone);
    }

    if (event is RequestOtpPasswordChange) {
      final response =
          await otpRepository.requestOtp(url: requestOtpUrl, phone: phone);
      var finalResponse = jsonDecode(response.body);
      CustomResults customResult = CustomResults.fromJson(finalResponse);
      // print("before"+response.toString());

      if (customResult.result == "success") {
        // print(customResult.toString());
        yield OtpReceivedState(msg: customResult.description);
      } else {
        yield OtpNonReceivedState();
      }
      yield OtpScreenLoaded(phone: phone);
    }

    if (event is ResendOtpPasswordChange) {
      final response =
          await otpRepository.resendtOtp(url: resendOtpUrl, phone: phone);
      var finalResponse = jsonDecode(response.body);
      CustomResults customResult = CustomResults.fromJson(finalResponse);
      // print("before"+response.toString());
      if (customResult.result == "success") {
        // print("if Success"+response.toString());

        yield OtpReceivedState(msg:customResult.description);
      } else {
        yield OtpNonReceivedState();
      }
      yield OtpScreenLoaded(phone: phone);
    }

    if (event is ValidateOtpPasswordChange) {
      final response = await otpRepository.validateOtp(
          url: validateOtpUrl, otp: event.otp, phone: phone);
      var finalResponse = jsonDecode(response.body);
      // print(finalResponse.toString());
      CustomResults customResult = CustomResults.fromJson(finalResponse);
      if (customResult.result == "success") {
        // print(customResult.toString());

        yield PasswordOtpVerifiedState();
      } else {
        yield PasswordOtpVerificationError();
      }

      yield OtpScreenLoaded(phone: phone);
    }

    if (event is ChangePass) {
      final response = await userRepository.updatePassword(
          url: updatePasswordUrl, phone: phone, password: event.password);
      var finalResponse = jsonDecode(response.data);
      CustomResults customResult = CustomResults.fromJson(finalResponse);
      if (customResult.result == "success") {
        yield PasswordChangedState();
      } else {
        yield PasswordChangeErrorState();
      }
    }
  }
}
