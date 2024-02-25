
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepository{
  var _dio=new Dio();

  Future fetchStores({required String url,required String phone})async{
    Map<String,String> qparams={
      'phone':phone
    };
    final response=await _dio.get(url,queryParameters: qparams);
    return response;

  }

  Future deleteCart({required String url,required String phone})async{
    Map<String,String> qparams={
      'phone':phone
    };
    final response=await _dio.get(url,queryParameters: qparams);
    return response;

  }

  Future fetchCartProducts({required String url, required String phone})async{
    Map<String,String> qparams={
      'phone':phone
    };
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    final response=await _dio.get(url,options: Options(headers: {
          "Authorization": "Token " + sharedPreferences.getString("token")
        }));
    return response;
  }


  

  Future fetchScrollCartProducts({required String url})async{
    final response=await _dio.get(url);
    return response;
  }

  Future fetchParticularStore({required String url,required String phone})async{
    Map<String,String> qparams={
      
      'phone':phone
    };
     SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    final response=await _dio.get(url,options: Options(headers: {
          "Authorization": "Token " + sharedPreferences.getString("token")
        }));
    return response;

  }

  Future fetchParticularProduct({required String url,required String storeId,required String phone,required String product})async{
    Map<String,String> qparams={
      'phone':phone,
      'product':product,
      'store_id':storeId
    };
    final response=await _dio.get(url,queryParameters: qparams);
    return response;

  }
}