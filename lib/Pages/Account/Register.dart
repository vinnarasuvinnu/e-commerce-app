import 'package:fins_user/Bloc/register_bloc/registerBloc.dart';
import 'package:fins_user/Bloc/register_bloc/registerEvent.dart';
import 'package:fins_user/Bloc/register_bloc/registerState.dart';
import 'package:fins_user/Pages/Account/Login.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _radio = "Male";
  bool _obscur = true;
  bool _obscur1 = true;

  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool passwordControl = true;
  int selectedGender = 1;
  var number = 0;
  late RegisterBloc _registerBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _registerBloc = RegisterBloc(RegisterUninitialized());
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
                    "Register Sucessfully...!",
                    style: TextStyle(
                        height: Fins.textHeight,
                        fontSize: Fins.textSize,
                        color: Fins.textColor),
                    textAlign: TextAlign.center,
                  ))));
        });
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context);
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: BlocListener(
        cubit: _registerBloc,
        listener: (context, state) {
          if (state is RegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Registration Successful',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),
                backgroundColor: Color(0xff323232),
              ),
            );
            Navigator.of(context).pop();
          }
          if (state is RegisterError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMsg,
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),
                backgroundColor: Color(0xff323232),
              ),
            );
          }
        },
        child: BlocProvider(
          create: (BuildContext context) {
            return _registerBloc;
          },
          child: BlocBuilder<RegisterBloc, RegisterState>(
              builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Fins.commonPadding),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(child: Image.asset("images/fins.png")),
                      SizedBox(
                        height: Fins.sizedBoxHeight,
                      ),
                      TextFormField(
                        cursorColor: Fins.finsColor,

                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'provide user name';
                          }
                          return null;
                        },
                        controller: usernameController,
                        decoration: InputDecoration(
                            hintText: "User Name",
                            hintStyle: TextStyle(
                              height: Fins.textHeight,
                              fontSize: Fins.textSize,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Fins.finsColor)),
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: Fins.sizedBoxHeight,
                      ),
                      TextFormField(
                        cursorColor: Fins.finsColor,

                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'provide valid mobile number';
                          }
                          return null;
                        },
                        controller: mobileNumberController,
                        decoration: InputDecoration(
                            hintText: "Mobile Number",
                            hintStyle: TextStyle(
                              height: Fins.textHeight,
                              fontSize: Fins.textSize,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Fins.finsColor)),
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: Fins.sizedBoxHeight,
                      ),
                      TextFormField(
                        cursorColor: Fins.finsColor,

                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'provide valid mobile number';
                          }
                          return null;
                        },
                        controller: emailController,
                        decoration: InputDecoration(
                            hintText: "Email ID",
                            hintStyle: TextStyle(
                              height: Fins.textHeight,
                              fontSize: Fins.textSize,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Fins.finsColor)),
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: Fins.sizedBoxHeight,
                      ),
                      TextFormField(
                        cursorColor: Fins.finsColor,

                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'provide valid Mail ID';
                          }
                          return null;
                        },
                        obscureText: _obscur,
                        controller: passwordController,
                        decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(
                              height: Fins.textHeight,
                              fontSize: Fins.textSize,
                            ),
                            suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    if (_obscur1 == true) {
                                      _obscur1 = false;
                                    } else {
                                      _obscur1 = true;
                                    }
                                  });
                                },
                                child: (_obscur1 == true)
                                    ? Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                )
                                    : Icon(
                                  Icons.visibility,
                                  color: Fins.finsColor,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Fins.finsColor)),
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder()),

                      ),
                      SizedBox(
                        height: Fins.sizedBoxHeight,
                      ),
                      TextFormField(
                        cursorColor: Fins.finsColor,

                        obscureText: _obscur,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'provide valid Password';
                          }
                          return null;
                        },
                        controller: confirmPasswordController,
                        decoration: InputDecoration(
                            hintText: "Confirm password",
                            hintStyle: TextStyle(
                              height: Fins.textHeight,
                              fontSize: Fins.textSize,
                            ),
                            suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    if (_obscur == true) {
                                      _obscur = false;
                                    } else {
                                      _obscur = true;
                                    }
                                  });
                                },
                                child: (_obscur == true)
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: Colors.grey,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: Fins.finsColor,
                                      )),
                            contentPadding: EdgeInsets.all(8),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Fins.finsColor)),
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: Fins.sizedBoxHeight,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Radio(
                                  activeColor: Fins.finsColor,
                                  value: 1,
                                  groupValue: selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = 1;
                                    });
                                  }),
                              Text("Male",
                                  style: TextStyle(
                                      height: Fins.textHeight,
                                      fontSize: Fins.textSize,
                                      color: Fins.textColor))
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  activeColor: Fins.finsColor,
                                  value: 2,
                                  groupValue: selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = 2;
                                    });
                                  }),
                              Text("Female",
                                  style: TextStyle(
                                      height: Fins.textHeight,
                                      fontSize: Fins.textSize,
                                      color: Fins.textColor))
                            ],
                          )
                        ],
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
                              // confirm();
                              if (_formKey.currentState!.validate()) {
                                if (passwordController.text ==
                                    confirmPasswordController.text) {
                                  _registerBloc.add(RegisterUserEvent(
                                      firstName: usernameController.text,
                                      mobileNumber: mobileNumberController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      gender: selectedGender));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Password and Confirm Password does not match!!!",
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
                            child: (state is RegisterLoading)
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 20.0,
                                      width: 20.0,
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(
                                            Colors.white),
                                        strokeWidth: 1,
                                      ),
                                    ),
                                  )
                                : Text("Register",
                                    style: TextStyle(
                                        height: Fins.textHeight,
                                        fontSize: Fins.textSize))),
                      ),
                      SizedBox(
                        height: Fins.sizedBoxHeight,
                      ),
                      SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                side: MaterialStateProperty.all<BorderSide>(
                                    BorderSide(color: Fins.finsColor)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white)),
                            onPressed: () {
                              //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                              Navigator.pop(context);
                            },
                            child: Text("Login",
                                style: TextStyle(
                                    height: Fins.textHeight,
                                    fontSize: Fins.textSize,
                                    color: Fins.finsColor))),
                      ),
                      SizedBox(
                        height: Fins.sizedBoxHeight,
                      ),
                      Text("Login here, if you an already have an account?",
                          style: TextStyle(
                              height: Fins.textHeight,
                              fontSize: Fins.textSize,
                              color: Fins.textColor))
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
