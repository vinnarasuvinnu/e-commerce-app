import 'package:fins_user/Bloc/login_bloc/loginBloc.dart';
import 'package:fins_user/Bloc/login_bloc/loginEvent.dart';
import 'package:fins_user/Bloc/login_bloc/loginState.dart';
import 'package:fins_user/Pages/Account/Register.dart';
import 'package:fins_user/Pages/Account/password_Change_OTP.dart';
import 'package:fins_user/Pages/Home/home_screen.dart';
import 'package:fins_user/initial_Screen.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscur = true;
  final mobileNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  var number = 0;

  late LoginBloc _loginBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginBloc = LoginBloc(LoginUninitialised());
  }

  closeApp() {
    SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: Fins.titleTextPadding,
        title: Text("Login"),
      ),
      body: BlocListener(
          cubit: _loginBloc,
          listener: (BuildContext context, LoginState state) {
            if (state is LoginSuccess) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => InitialScreen()));
            }

            if (state is ForgotPasswordState) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PasswordOTP()));
            }
            if (state is ForgotPasswordErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Please do complete registration to proceed with forgot password",
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: Color(0xff323232),
                ),
              );
            }

            if (state is LoginError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.error,
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: Color(0xff323232),
                ),
              );
            }
          },
          child: BlocProvider(create: (BuildContext context) {
            return _loginBloc;
          }, child:
              BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
            return WillPopScope(
              onWillPop: () {
                return closeApp();
              },
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(Fins.commonPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                            child: Image.asset(
                          "images/fins.png",
                          fit: BoxFit.contain,
                          height: 250,
                        )),
                        // SizedBox(height:Fins.sizedBoxHeight,),
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
                              errorText: (number == 0)
                                  ? null
                                  : "Please enter the number",
                              // errorText: null,
                              hintStyle: TextStyle(
                                  height: Fins.textHeight,
                                  fontSize: Fins.textSize),
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
                              return 'provide valid passwordr';
                            }
                            return null;
                          },
                          controller: passwordController,
                          obscureText: _obscur,
                          decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: TextStyle(
                                  height: Fins.textHeight,
                                  fontSize: Fins.textSize),
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
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Fins.finsColor)),
                              contentPadding: EdgeInsets.all(8),
                              border: OutlineInputBorder()),
                        ),
                        SizedBox(
                          height: Fins.sizedBoxHeight,
                        ),
                        InkWell(
                          onTap: () {
                            if (mobileNumberController.text == "") {
                              setState(() {
                                number = 1;
                              });
                            } else {
                              _loginBloc.add(ForgotPasswordEvent(
                                  phone: mobileNumberController.text));
                            }
                          },
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    height: Fins.textHeight,
                                    fontSize: Fins.textSize,
                                    color: Fins.textColor),
                                textAlign: TextAlign.end,
                              )),
                        ),
                        SizedBox(
                          height: 30,
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
                                if (_formKey.currentState!.validate()) {
                                  _loginBloc.add(LoginUserEvent(
                                      username: mobileNumberController.text,
                                      password: passwordController.text));
                                }
                              },
                              child: (state is LoginLoading)
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
                                  : Text("Login",
                                      style: TextStyle(
                                        height: Fins.textHeight,
                                        fontSize: Fins.textSize,
                                      ))),
                        ),
                        SizedBox(
                          height: Fins.sizedBoxHeight,
                        ),
                        Text("if you are a new user?",
                            style: TextStyle(
                                height: Fins.textHeight,
                                fontSize: Fins.textSize,
                                color: Fins.textColor)),
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Register()));
                              },
                              child: Text("Register",
                                  style: TextStyle(
                                      height: Fins.textHeight,
                                      fontSize: Fins.textSize,
                                      color: Fins.finsColor))),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }))),
    );
  }
}
