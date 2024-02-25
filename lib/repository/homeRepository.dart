import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRepository {
  var _dio = new Dio();

  Future fetchCategory({required String url}) async {
    final response = await _dio.get(url);
    return response;
  }

  Future fetchBestsellersData({required String url}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // print(sharedPreferences.getString("token"));
    final response = await _dio.get(url,
        options: Options(headers: {
          "Authorization":
              "Token " + sharedPreferences.getString("token").toString()
        }));
    return response;
  }

  Future fetchCategoryData({required String url, required String id}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, String> qparams = {"category_id": id};

    final response = await _dio.get(url,
        queryParameters: qparams,
        options: Options(headers: {
          "Authorization":
              "Token " + sharedPreferences.getString("token").toString()
        }));
    return response;
  }

  Future fetchCurrentLocationData({required String url}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // print(sharedPreferences.getString("token"));
    final response = await _dio.get(url,
        options: Options(headers: {
          "Authorization":
              "Token " + sharedPreferences.getString("token").toString()
        }));
    return response;
  }

  Future fetchOfferData({required String url}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // print(sharedPreferences.getString("token"));
    final response = await _dio.get(url,
        options: Options(headers: {
          "Authorization":
              "Token " + sharedPreferences.getString("token").toString()
        }));
    return response;
  }

  Future fetchBannerData({required String url}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // print(sharedPreferences.getString("token"));
    final response = await _dio.get(url,
        options: Options(headers: {
          "Authorization":
              "Token " + sharedPreferences.getString("token").toString()
        }));
    return response;
  }

  Future fetchCartCountData({required String url}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // print(sharedPreferences.getString("token"));
    final response = await _dio.get(url,
        options: Options(headers: {
          "Authorization":
              "Token " + sharedPreferences.getString("token").toString()
        }));
    return response;
  }

  Future fetchSearchData({required String url}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // print(sharedPreferences.getString("token"));
    final response = await _dio.get(url,
        options: Options(headers: {
          "Authorization":
              "Token " + sharedPreferences.getString("token").toString()
        }));
    return response;
  }

  Future fetchCartData({required String url}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // print(sharedPreferences.getString("token"));
    final response = await _dio.get(url,
        options: Options(headers: {
          "Authorization":
              "Token " + sharedPreferences.getString("token").toString()
        }));
    return response;
  }

  Future updateCartData({required String url}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // print(sharedPreferences.getString("token"));
    final response = await _dio.get(url,
        options: Options(headers: {
          "Authorization":
              "Token " + sharedPreferences.getString("token").toString()
        }));
    return response;
  }

  Future updatePushToken({required String url, required String token}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // print(sharedPreferences.getString("token"));
    FormData formData = new FormData.fromMap({'token': token});
    final response = await _dio.post(url,
        data: formData,
        options: Options(headers: {
          "Authorization":
              "Token " + sharedPreferences.getString("token").toString()
        }));
    return response;
  }

  Future updateCartIdCount(
      {required String url,
      required String id,
      required String operationCode}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    FormData formData =
        new FormData.fromMap({'cart_id': id, 'operation_code': operationCode});
    final response = await _dio.post(url,
        data: formData,
        options: Options(headers: {
          "Authorization":
              "Token " + sharedPreferences.getString("token").toString()
        }));
    return response;
  }

  Future fetchHomeCategoryProductsData({required String url}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // print(sharedPreferences.getString("token"));
    final response = await _dio.get(url,
        options: Options(headers: {
          "Authorization":
              "Token " + sharedPreferences.getString("token").toString()
        }));
    return response;
  }

  Future fetchSelectedProduct(
      {required String url,
      required String phone,
      required String storeId}) async {
    Map<String, String> qparams = {
      'phone': phone,
      'store_id': storeId,
    };

    final response = await _dio.get(url, queryParameters: qparams);
    return response;
  }

  Future updateUserLocation(
      {required String url,
      required String token,
      required String latitude,
      required String longitude,
      required String address}) async {
    FormData formData = new FormData.fromMap({
      'token': token,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final response = await _dio.post(url,
        data: formData,
        options: Options(headers: {
          "Authorization":
              "Token " + sharedPreferences.getString("token").toString()
        }));
    return response;
  }

  Future fetchLocation(
      {required String url,
      required String latitude,
      required String longitude}) async {
    Map<String, String> qparams = {
      'latitude': latitude,
      'longitude': longitude
    };
    final response = await _dio.get(url, queryParameters: qparams);
    return response;
  }

  Future fetchLocationDescription(
      {required String url, required String phone}) async {
    Map<String, String> qparams = {'phone': phone};
    final response = await _dio.get(url, queryParameters: qparams);
    return response;
  }

  Future fetchBanners(
      {required String url,
      required String type,
      required String phone}) async {
    Map<String, String> qparams = {'banner_type': type, 'phone': phone};
    final response = await _dio.get(url, queryParameters: qparams);
    return response;
  }

  Future fetchEcommerce({required String url}) async {
    final response = await _dio.get(url);
    return response;
  }

  Future fetchFirstScreen({required String url, required String phone}) async {
    Map<String, String> qparams = {'phone': phone};
    final response = await _dio.get(url, queryParameters: qparams);
    return response;
  }

  Future fetchMartBanners(
      {required String url,
      required String type,
      required String phone}) async {
    Map<String, String> qparams = {'mart_banners': type, 'phone': phone};
    final response = await _dio.get(url, queryParameters: qparams);
    return response;
  }

  Future fetchCartCount({required String url, required String phone}) async {
    Map<String, String> qparams = {'phone': phone};
    final response = await _dio.get(url, queryParameters: qparams);
    return response;
  }

  Future fetchStoreInfo(String url) async {
    final response = await _dio.get(url);
    return response;
  }

  Future fetchHomeChoice(
      {required String url,
      required String productType,
      required String storeId}) async {
    Map<String, String> qparams = {
      "product_type": productType,
      "store_id": storeId
    };
    final respone = await _dio.get(url, queryParameters: qparams);
    return respone;
  }

  Future updateCart(
      {required String url,
      required String productId,
      required String operationCode,
      // required String price,
      // required String addItems,
      // required int itemCount,
      required String storeId}) async {
    FormData formData = new FormData.fromMap({
      'productId': productId,
      'operation_code': operationCode,
      'store_id': storeId,
      // 'addItems':addItems,
      // 'itemCount':itemCount,
      // 'price':price,
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final response = await _dio.post(url,
        data: formData,
        options: Options(headers: {
          "Authorization": "Token " + sharedPreferences.getString("token")
        }));
    return response;
  }

  Future fetchAllProducts(
      {required String url,
      required String storeId,
      required String productId,
      required String phone}) async {
    Map<String, String> qparams = {
      'store_id': storeId,
      'productId': productId,
      'phone': phone
    };
    final response = await _dio.get(url, queryParameters: qparams);
    return response;
  }

  Future fetchAddons({required String url}) async {
    final response = await _dio.get(url);
    return response;
  }
}
