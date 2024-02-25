import 'package:fins_user/Bloc/passwordBloc/passwordBloc.dart';
import 'package:fins_user/Bloc/passwordBloc/passwordEvent.dart';
import 'package:fins_user/Bloc/passwordBloc/passwordState.dart';
import 'package:fins_user/Pages/Account/MyAccount.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool newPassword = true;
  bool confirmPassword = true;

  late PasswordBloc _passwordBloc;
  bool passwordControl = true;
  bool confirmPasswordControl = true;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordBloc = PasswordBloc(PasswordUninitialized());
  }

  bool validatePassword(String value) {
    if (value.length >= 8) {
      return true;
    }
    return false;
  }

  void confirm() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Align(
                  alignment: Alignment.center,
                  child: Center(
                      child: Text(
                    "Password Changes Sucessfully...!",
                    style: TextStyle(
                        height: Fins.textHeight,
                        fontSize: Fins.textSize,
                        color: Fins.textColor),
                    textAlign: TextAlign.center,
                  ))));
        });
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pop(context);
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
      ),
      body: BlocProvider(
        create: (BuildContext context) {
          return _passwordBloc;
        },
        child: BlocListener(
          cubit: _passwordBloc,
          listener: (context, state) {
            if (state is PasswordChangedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Password Changed',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: Color(0xff323232),
                ),
              );

              Future.delayed(Duration(seconds: 3), () {
                // Navigator.of(context).pop();
                Navigator.of(context).pop();
              });
            }

            if (state is PasswordChangeErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Password could not be updated, try again',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: Color(0xff323232),
                ),
              );
            }
          },
          child: BlocBuilder<PasswordBloc, PasswordState>(
              builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Fins.commonPadding),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                        height: Fins.sizedBoxHeight,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextField(
                          obscureText: newPassword,
                          controller: passwordController,
                          decoration: InputDecoration(
                              hintText: "New Password",
                              hintStyle: TextStyle(
                                  height: Fins.textHeight,
                                  fontSize: Fins.textSize),
                              suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (newPassword == true) {
                                        newPassword = false;
                                      } else {
                                        newPassword = true;
                                      }
                                    });
                                  },
                                  child: Icon(Icons.remove_red_eye)),
                              contentPadding: EdgeInsets.all(8),
                              border: OutlineInputBorder()),
                        ),
                      ),
                      SizedBox(
                        height: Fins.sizedBoxHeight,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextField(
                          controller: confirmPasswordController,
                          obscureText: confirmPassword,
                          decoration: InputDecoration(
                              hintText: "Confirm New Password",
                              hintStyle: TextStyle(
                                height: Fins.textHeight,
                                fontSize: Fins.textSize,
                              ),
                              suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (confirmPassword == true) {
                                        confirmPassword = false;
                                      } else {
                                        confirmPassword = true;
                                      }
                                    });
                                  },
                                  child: Icon(Icons.remove_red_eye)),
                              contentPadding: EdgeInsets.all(8),
                              border: OutlineInputBorder()),
                        ),
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
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Fins.finsColor)),
                            onPressed: () {
                              // confirm();
                              if (_formKey.currentState!.validate()) {
                                if (passwordController.text ==
                                    confirmPasswordController.text) {
                                  _passwordBloc.add(ChangePass(
                                    // phone: _passwordBloc.phone.toString(),
                                      password: confirmPasswordController.text));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Password and Confirm Password Does not match !!!',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0),
                                        textAlign: TextAlign.center,
                                      ),
                                      backgroundColor: Color(0xff323232),
                                    ),
                                  );
                                }
                              }
                            },
                            child: Text("Continue",
                                style: TextStyle(
                                  height: Fins.textHeight,
                                  fontSize: Fins.textSize,
                                ))),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
