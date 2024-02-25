import 'dart:convert';

import 'package:fins_user/Models/custom_result.dart';
import 'package:fins_user/repository/PaymentRepository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Fins {
  //////////////////Url's/////////////

  static const String ip = "https://api.finsandslice.com/";
  // static const String ip = "http://192.168.18.3:9000/";

  static const String grocery = "grocery";
  static const String googleMapApiKey =
      "AIzaSyDooCyB7ksNTf8n34o89J9An9znSMxTL8E";

  static const String shareUrl =
      "https://play.google.com/store/apps/details?id=com.fins.fins_user";

  static setUserLocation(
      {required double latitude,
      required double longitude,
      required String address}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString("delivery_address", address);
    sharedPreferences.setString("delivery_latitude", latitude.toString());
    sharedPreferences.setString("delivery_longitude", longitude.toString());
  }

  static const String cartStoreUrl =
      Fins.ip + "home/cart/0/get_distinct_store/";
  static bool allowScrolling = true;
  static const String saveAddressCountUrl =
      Fins.ip + "home/deliveryAddress/0/get_address_count/";

  static setDeliveryAddressId({required String addressId}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString("address_id", addressId);
  }

  static getLoginStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("isLogin") == "true") {
      return true;
    }
    return false;
  }

  static getAddressCount() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var phone = sharedPreferences.getString("mobile");
    PaymentRepository _paymentRepository = PaymentRepository();

    final addressCountResponse = await _paymentRepository
        .getDeliveryAddressCount(url: saveAddressCountUrl, phone: phone);
    CustomResults customResult =
        CustomResults.fromJson(jsonDecode(addressCountResponse.data));
    return customResult.result;
  }

  static setDeliverFlatLocation(String homeNo, String landMark) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("homeno", homeNo);
    sharedPreferences.setString("landmark", landMark);
  }

  static const int cashOnDelivery = 1;
  static const int onlinePayment = 3;
  static final String brandColorForPay = '#84167';

  /////////////////Size  /////////////

  static const double titleSize = 18.0;
  static const double bigTitleSize = 20.0;
  static const double textHeight = 1.4;
  static const double textSize = 14.0;
  static const double textSmallSize = 12.0;
  static const double buttonRadius = 5;
  static const double dividerHeight = 3;
  static const double sizedBoxHeight = 16;
  static const double iconSize = 25;

  static const double commonPadding = 8;
  static const double titleTextPadding = 10;
  static const double accountTextPadding = 10;

  /////////////////Colors/////////////

  static Color finsColor = Color(0xFFd92517);
  static Color titleColor = Color(0xff2c2c2c);
  static Color textColor = Color(0xff2c2c2c);
  static Color secondaryTextColor = Color(0xff868686);
  static Color dividerColor = Color(0xff9a9a9a);
}
