import 'dart:async';

import 'package:fins_user/Bloc/passwordBloc/passwordBloc.dart';
import 'package:fins_user/Bloc/passwordBloc/passwordEvent.dart';
import 'package:fins_user/Bloc/passwordBloc/passwordState.dart';
import 'package:fins_user/Pages/Account/Change_Password.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:fins_user/utils/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_autofill/sms_autofill.dart';

class PasswordOTP extends StatefulWidget {
  const PasswordOTP({Key? key}) : super(key: key);

  @override
  _PasswordOTPState createState() => _PasswordOTPState();
}

class _PasswordOTPState extends State<PasswordOTP> {
  late PasswordBloc _passwordBloc;

  TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
    _passwordBloc = PasswordBloc(PasswordUninitialized());
  }

  late Timer _timer;
  int _start = 30;

  resetTime() {
    _start = 30;
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          // print(pincontroller.text);
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  var _code = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
      ),
      body: BlocProvider<PasswordBloc>(
        create: (BuildContext context) {
          return _passwordBloc..add(OtpScreenLoadEvent());
        },
        child: BlocListener(
          cubit: _passwordBloc,
          listener: (context, state) {
            if (state is OtpNonReceivedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Could not send otp to your mobile, click resend button to get otp',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: Color(0xff323232),
                ),
              );
            }

            if (state is OtpReceivedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.msg.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: Color(0xff323232),
                ),
              );
            }

            if (state is PasswordOtpVerificationError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Invalid otp',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: Color(0xff323232),
                ),
              );
            }

            if (state is PasswordOtpVerifiedState) {
              Navigator.of(context)
                  .pushReplacementNamed("/changePassword");

            }
          },
          child: BlocBuilder<PasswordBloc, PasswordState>(
            builder: (context, state) {
              if (state is PasswordUninitialized) {
                return LoadingListPage();
              }
              if (state is OtpScreenLoaded) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(Fins.commonPadding),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Fins.sizedBoxHeight,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text:
                                      "Enter the OTP which we sent to mail",
                                  style: TextStyle(
                                      height: Fins.textHeight,
                                      fontSize: Fins.textSize,
                                      color: Fins.textColor),
                                  children: [
                                    TextSpan(
                                        style: TextStyle(
                                            height: Fins.textHeight,
                                            fontSize: Fins.textSize,
                                            color: Fins.textColor,
                                            fontWeight: FontWeight.bold)),
                                  ])),
                        ),
                        SizedBox(
                          height: Fins.sizedBoxHeight,
                        ),
                        SizedBox(
                          height: Fins.sizedBoxHeight,
                        ),
                        (_start >= 10)
                            ? Text(
                                "00:" + "$_start",
                                style: TextStyle(
                                    height: Fins.textHeight,
                                    fontSize: Fins.textSize,
                                    color: Fins.finsColor),
                              )
                            : Text(
                                "00:0" + "$_start",
                                style: TextStyle(
                                    height: Fins.textHeight,
                                    fontSize: Fins.textSize,
                                    color: Fins.finsColor),
                              ),
                        SizedBox(
                          height: Fins.sizedBoxHeight,
                        ),
                        PinFieldAutoFill(
                          controller: otpController,
                          // decoration:
                          currentCode: _code,
                          // onCodeSubmitted:
                          onCodeChanged: (value) {
                            setState(() {
                              _code = value.toString();
                            });
                          },
                          codeLength: 4,
                        ),
                        SizedBox(
                          height: Fins.sizedBoxHeight,
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: (){
                                _passwordBloc.add(ResendOtpPasswordChange());
                              },
                              child: Text("Resend OTP",
                                  style: TextStyle(
                                      height: Fins.textHeight,
                                      fontSize: Fins.textSize,
                                      color: Fins.textColor)),
                            )),
                        SizedBox(
                          height: Fins.sizedBoxHeight,
                        ),
                        SizedBox(
                          height: Fins.sizedBoxHeight,
                        ),
                        SizedBox(
                          height: Fins.sizedBoxHeight,
                        ),
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Fins.finsColor)),
                              onPressed: () {
                                if (otpController.text.length == 4) {
                                  //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePassword()));
                                  _passwordBloc.add(ValidateOtpPasswordChange(
                                      otp: otpController.text));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Enter Valid OTP',
                                        style: TextStyle(
                                          height: Fins.textHeight,
                                          fontSize: Fins.textSize,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      backgroundColor: Color(0xff323232),
                                    ),
                                  );
                                }
                              },
                              child: Text("Verify OTP",
                                  style: TextStyle(
                                    height: Fins.textHeight,
                                    fontSize: Fins.textSize,
                                  ))),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
