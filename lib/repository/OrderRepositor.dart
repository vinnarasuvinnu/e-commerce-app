
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderRepository{
  var _dio=Dio();

  Future fetchOrders({required String url})async{
  
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    final response=await _dio.get(url,options: Options(
        headers: {
          "Authorization":"Token "+sharedPreferences.getString("token")
        }
    ));
    return response;

  }
  Future fetchScrollOrders({required String url})async{
        SharedPreferences sharedPreferences =await SharedPreferences.getInstance();

    final response= await _dio.get(url,options: Options(
        headers: {
          "Authorization":"Token "+sharedPreferences.getString("token")
        }
    ));
    return response;
  }

  Future fetchOrderedItems({required String url,required String storeId,required String orderId})async{
    Map<String,String> qparams={
      'store_id':storeId,
      'order_id':orderId
    };

    final response=await _dio.get(url,queryParameters: qparams);
    return response;

  }


  Future cancelOrder({required String url,required String orderId})async{


    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();


    FormData formData=new FormData.fromMap({
      'order_id':orderId

    });
    final response=await _dio.post(url,data: formData,options: Options(
        headers: {
          "Authorization":"Token "+sharedPreferences.getString("token")
        }
    )
    );
    return response;

  }


}