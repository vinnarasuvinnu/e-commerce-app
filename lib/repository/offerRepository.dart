import 'package:dio/dio.dart';

class OfferRepository{
  var _dio=new Dio();

  Future fetchOffers({required String url,required String phone,required String offer_id})async{
    Map<String,String> qparams={
      'phone':phone,
      'offer_id':offer_id
    };
    final response=await _dio.get(url,queryParameters: qparams);
    return response;

  }

  Future scrollOffers(String url)async{

    final response=await _dio.get(url);
    return response;

  }
}