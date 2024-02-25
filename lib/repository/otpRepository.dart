/*
 * Copyright (c) 2020. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */


import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class OtpRepository{

  Future requestOtp({required String url,required String phone}) async{
    final response = await http.post(Uri.parse(url),body:{
      'phone':phone,
    });
    return response;
  }

  Future validateOtp({required String url,required String phone,required String otp})async{

    final response = await http.post(Uri.parse(url),body:{
      'phone':phone,
      'otp':otp,

    });
    return response;
  }

  Future changePhone({required String url,required String mobile})async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();


    final response = await http.post(Uri.parse(url),body:{
      'new_mobile':mobile,
      'old_mobile':sharedPreferences.getString("mobile")

    });

    return response;
  }

  Future resendtOtp({required String url,required String phone}) async{
    final response = await http.post(Uri.parse(url),body:{
      'phone':phone,
    });
    return response;
  }

}