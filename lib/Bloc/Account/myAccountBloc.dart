import 'dart:convert';

import 'package:fins_user/Models/Profile.dart';
import 'package:fins_user/Models/contact_us.dart';
import 'package:fins_user/Models/custom_result.dart';
// import 'package:fins_user/Models/user.dart';
import 'package:fins_user/repository/userRepository.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'myAccountEvent.dart';
import 'myAccountState.dart';

class MyAccountBloc extends Bloc<MyAccountEvent,MyAccountState>{

  UserRepository userRepository=UserRepository();
  final String userUrl=Fins.ip+"home/user/0/get_profile/";
   final String updateuserUrl=Fins.ip+"home/user/0/update_profile/";
  final String logOutUrl=Fins.ip+"home/logout/";
  final String contactUrl = Fins.ip+"home/user/0/get_contact_us/";

  late String userId;
  late int gender;
  // late User user;

  MyAccountBloc(MyAccountState initialState) : super(initialState);

  @override
  // TODO: implement initialState
  MyAccountState get initialState => MyAccountStateUninitialized();

  @override
  Stream<MyAccountState> mapEventToState(MyAccountEvent event)async* {
    final currentState=state;

    // TODO: implement mapEventToState
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    userId=sharedPreferences.getString("userId");
    String phone = sharedPreferences.getString("mobile");



    if(event is FetchMyAccountInfo){

      try{

        final userResponse=await userRepository.getUserInfoById(url: userUrl);
        Profile profile=Profile.fromJson(userResponse.data);

        yield MyAccountLoaded(profile:profile );

      }
      catch(e){
        yield MyAccountStateError();
      }
    }

    if(event is FetchContactUs){
      try{

        final userResponse=await userRepository.getUserInfo(url: contactUrl,phone: phone);
        ContactUs user=ContactUs.fromJson(userResponse.data);

        yield ContactUsLoaded(phone: user.phone,mail: user.mail);

      }
      catch(e){
        yield MyAccountStateError();
      }
    }




    // if(event is SelectGender){
    //   if(currentState is MyAccountLoaded){
    //     gender=event.gender;
    //     yield MyAccountLoaded(profile: );

    //   }
    // }

    if(event is UpdateAccount){


      if(currentState is MyAccountLoaded){
        yield MyAccountLoading();

        // user=currentState.user;
        
        
          final userUpdateResponse=await userRepository.updateUserInfoById(url: updateuserUrl,username: event.username,email: event.email,);

          if(userUpdateResponse.statusCode==200){
            yield AccountUpdated();
          }
          else{
            yield AccountUpdateError();
          }
        

        yield MyAccountLoaded(profile:currentState.profile );


      }

    }

    if(event is FetchSettingsInfo){
      var loginStatus=await Fins.getLoginStatus();
      try{
        yield SettingsLoaded(loginStatus: (loginStatus==true) ? true:false);

      }
      catch(e){
        yield MyAccountStateError();
      }

    }
    if(event is LogoutUser){
      final response=await userRepository.logoutUser(url: logOutUrl);
      CustomResults customResult=CustomResults.fromJson(jsonDecode(response.data));
      if(customResult.result=="success"){
        try{

          sharedPreferences.setString("isLogin", "false");
          sharedPreferences.remove("token");
          SnackBar(
            content: Text(
              "Logout Successful",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Color(0xff323232),
          );
          yield LogoutState();
        }catch(e){
          yield MyAccountStateError();

        }
      }

    }

    // if(event is LogoutUser && currentState is SettingsLoaded){
    //
    //   final response=await userRepository.logoutUser(url: logOutUrl);
    //   CustomResults customResult=CustomResults.fromJson(jsonDecode(response.data));
    //   if(customResult.result=="success"){
    //     try{
    //       sharedPreferences.remove("token");
    //       sharedPreferences.remove("isLogin");
    //     }
    //     catch(e){
    //       e);
    //     }
    //
    //     SnackBar(
    //       content: Text(
    //         "Logout Successful",
    //         style: TextStyle(color: Colors.white, fontSize: 16.0),
    //         textAlign: TextAlign.center,
    //       ),
    //       backgroundColor: Color(0xff323232),
    //     );
    //
    //
    // yield SettingsLoaded(loginStatus: (sharedPreferences.getString("token") != null) ? true:false);
    //     return;
    //   }
    //   else{
    //     yield SettingsLoaded(loginStatus: (sharedPreferences.getString("token") != null) ? true:false);
    //
    //   }
    //
    //
    // }

  }


}