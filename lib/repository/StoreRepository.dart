import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreRepository {
  var _dio = new Dio();

  Future fetchShopsHotels(
      {required String url,
      required String phone,
      String type = "",
      String store_food_type = ""}) async {
    Map<String, String> qparams = {
      'phone': phone,
      'type': type,
      'store_food_type': store_food_type
    };
    final response = await _dio.get(url, queryParameters: qparams);
    return response;
  }

  Future fetchShopsHotelsCount(
      {required String url,
      required String phone,
      String type = "",
      String store_food_type = ""}) async {
    Map<String, String> qparams = {
      'phone': phone,
      'type': type,
      'store_food_type': store_food_type
    };
    final response = await _dio.get(url, queryParameters: qparams);
    return response;
  }

  Future checkDistance({required String url, required String order_id}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    FormData formData = new FormData.fromMap({
      'latitude': sharedPreferences.getString("delivery_latitude"),
      'longitude': sharedPreferences.getString("delivery_longitude")
    });
    final response = await _dio.post(url,
        data: formData,
        options: Options(headers: {
          "Authorization": "Token " + sharedPreferences.getString("token")
        }));
    return response;
  }

  Future getRazorpayKey({required String url, required String order_id}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    FormData formData = new FormData.fromMap({"order_id": order_id});
    final response = await _dio.post(url,
        data: formData,
        options: Options(headers: {
          "Authorization": "Token " + sharedPreferences.getString("token")
        }));
    return response;
  }

  Future fetchShopsHotelsPattern(
      {required String url, required String phone, String pattern = ""}) async {
    Map<String, String> qparams = {'phone': phone, 'searchKey': pattern};
    final response = await _dio.get(url, queryParameters: qparams);
    return response;
  }

  Future fetchShopCategory(
      {required String url, required String product_id}) async {
    Map<String, String> qparams = {
      'product_id': product_id,
    };
    final response = await _dio.get(url, queryParameters: qparams);
    return response;
  }

  Future fetchStoreSearch({required String url, required String phone}) async {
    Map<String, String> qparams = {'phone': phone};
    final response = await _dio.get(url, queryParameters: qparams);
    return response;
  }

  Future fetchRegion({required String url, required String phone}) async {
    Map<String, String> qparams = {'phone': phone};
    final response = await _dio.get(url, queryParameters: qparams);
    return response;
  }

  Future fetchStoreSearchPattern(
      {required String url,
      required String phone,
      required String pattern}) async {
    Map<String, String> qparams = {'phone': phone, 'pattern': pattern};
    final response = await _dio.get(url, queryParameters: qparams);
    return response;
  }

  Future fetchShopsHotelScroll(String url) async {
    final response = await _dio.get(url);
    return response;
  }

  Future fetchShopProduct(
      {required String url, required String pattern}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var storeId = sharedPreferences.getString("store_id");
    Map<String, String> qparams = {'pattern': pattern};

    final response = await _dio.get(url + storeId, queryParameters: qparams);
    return response;
  }

  Future fetchShopProductId(
      {required String url,
      required String product_id,
      required String phone,
      required String rating,
      required String cost,
      required String distance_from,
      required String distance_to,
      required String time}) async {
    Map<String, String> qparams = {
      'phone': phone,
      'category_id': product_id,
      'distance_from': distance_from,
      'distance_to': distance_to,
      'rating': rating,
      'cost': cost,
      'time': time
    };

    final response = await _dio.get(url, queryParameters: qparams);
    return response;
  }
}
