import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  var _dio = new Dio();

  Future<bool> hasVisitedApp() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getString("isLogin") == "true") {
      return true;
    }
    return false;
  }

   makeVisited() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("isLogin", "true");
  }
  //
  Future loginUser(
      {required String url, required String phone, required String password}) async {
    FormData formData =
        FormData.fromMap({'username': phone, 'password': password});
    final response = await _dio.post(url, data: formData);
    return response;
  }

  Future sendNotification({required String url,required String id}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  
    FormData formData = FormData.fromMap({'id': id});
    final response = await _dio.post(url,
        data: formData,
        options: Options(headers: {
          "Authorization": "Token " + sharedPreferences.getString("token")
        }));
  
    return response;
  }

  // Future getDeliveryDetails({@required String url}) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //
  //   final response = await _dio.get(url,
  //       options: Options(headers: {
  //         "Authorization": "Token " + sharedPreferences.getString("token")
  //       }));
  //   return response;
  // }

  Future updateUserInfoById({required String url,r,required String username,required String email})async{
    // String fileName = file.path.split('/').last;

    FormData data = FormData.fromMap({
      // "avatar": await MultipartFile.fromFile(
      //   file.path,
      //   filename: fileName,
      // ),
      "first_name":username,
      "email":email,
      // "gender":gender
    });
 SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final response=await _dio.post(url, data: data,options: Options(headers: {
          "Authorization": "Token " + sharedPreferences.getString("token")
        }));
    return response;


  }

  Future updatePassword({required String url,required String phone,required String password})async{
    FormData data=FormData.fromMap({
      'phone':phone,
      'password':password
    });
    final response=await _dio.post(url,data: data);
    return response;
  }


  Future forgotPasswordCheck({required String url,required String phone})async{
    FormData data=FormData.fromMap({
      'phone':phone
    });
    final response=await _dio.post(url,data: data);
    return response;

  }
  Future updateUser({required String url,required String phone,required String firstName,required String email,required String password,required int gender})async{

    FormData formData=new FormData.fromMap({
      'phone':phone,
      'first_name':firstName,
      'email':email,
      'password':password,
      'gender':gender.toString()
    });
    final response=await _dio.post(url,data: formData);
    return response;
  }


  Future getUserInfo({required String url,required String phone})async{
    Map<String,String> qparams={
      'phone':phone
    };

     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final response=await _dio.get(url,options: Options(headers: {
          "Authorization": "Token " + sharedPreferences.getString("token")
        }));
    return response;
  }
   Future getRazorPayKey({required String url})async{
   
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final response=await _dio.get(url,options: Options(headers: {
          "Authorization": "Token " + sharedPreferences.getString("token")
        }));
    return response;

  }

  


  Future getUserInfoById({required String url})async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    final response=await _dio.get(url,options: Options(
        headers: {
          "Authorization":"Token "+sharedPreferences.getString("token")
        }
    ));
    return response;
  }


  Future updateUserInfoWithoutImage({required String url,required int gender,required String username,required String email})async{
    FormData data = FormData.fromMap({
      "first_name":username,
      "email":email,
      "gender":gender
    });

    final response=await _dio.patch(url,data: data);
    return response;
  }

  Future logoutUser({required String url}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final response = await _dio.post(url,
        options: Options(headers: {
          "Authorization": "Token " + sharedPreferences.getString("token")
        }));
    return response;
  }
}
