import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentRepository{
  var _dio=Dio();

  Future saveOrder({required String url,required int paymentType,required String home_no,required String landmark,required String orderType})async{

    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();


    FormData formData=new FormData.fromMap({
      // 'phone':phone,
      'payment_type':paymentType,
      'home_no':home_no,
      'order_type':orderType,
      'land_mark':landmark
      // 'deliveryCharge':deliveryCharge,
      // 'paymentId':paymentId,
      // 'deliveryTax':deliveryTax,
      // 'packingCharge':packingCharge,
      // 'deliveryAddressInfo':deliveryAddressInfo,
      // 'address_id':addressId

    });
    final response=await _dio.post(url,data: formData,options: Options(
      headers: {
        "Authorization":"Token "+sharedPreferences.getString("token")
      }
    ));
    return response;

  }


  Future saveAddress({required String url,required String delivery_address,required String latitude,required String longitude,required String flat_number,required String land_mark,required String address_type,required String phone})async{
    FormData formData= new FormData.fromMap({ 
      'flat_number':flat_number,
      'land_mark':land_mark,
      'map_address':delivery_address,
      'latitude':latitude,
      'longitude':longitude,
      'address_type':address_type,
      'user':phone
    });



    final response = await _dio.post(url,data: formData);
    return response;

  }

  Future saveEditedAddress({required String url,required String flat_number,required String land_mark,required String address_id})async{
    FormData formData= new FormData.fromMap({
      'flat_number':flat_number,
      'landMark':land_mark,

    });



    final response = await _dio.patch(url+address_id+"/",data: formData);
    return response;

  }





  Future fetchDeliveryAddress({required String url,required String phone}) async {



    Map<String,String> qparams={
      'phone':phone,

    };
    final response=await _dio.get(url,queryParameters: qparams);
    return response;
  }

  Future deleteDeliveryAddress({required String url,required String address_id})async{
    final response=await _dio.delete(url+address_id+"/");
    return response;
  }


  Future getDeliveryAddressCount({ required String url,required String phone})async{
    Map<String,String> qparams={
      'phone':phone,

    };
    final response=await _dio.get(url,queryParameters: qparams);
    return response;
  }



}