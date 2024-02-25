import 'dart:convert';
import 'dart:io';

import 'package:fins_user/Bloc/HomeBloc/home_event.dart';
import 'package:fins_user/Bloc/HomeBloc/home_state.dart';
import 'package:fins_user/Models/UserRest.dart';
import 'package:fins_user/Models/bannersData.dart';
import 'package:fins_user/Models/bestSellers.dart';
import 'package:fins_user/Models/custom_result.dart';
import 'package:fins_user/Models/homeCategoryProducts.dart';
import 'package:fins_user/Models/searchItems.dart';
import 'package:fins_user/Models/user_location.dart';
import 'package:fins_user/repository/StoreRepository.dart';
import 'package:fins_user/repository/cartRepository.dart';
import 'package:fins_user/repository/homeRepository.dart';
import 'package:fins_user/repository/userRepository.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late Location location = new Location();

  double defaultLatitude = 12.7188097;
  double defaultLongitude = 77.8168406;
  bool locationFound = true;

  HomeBloc(HomeState initialState) : super(initialState);
  late LocationData _locationData;
  late PermissionStatus _permissionGranted;
  late HomeRepository homeRepository = new HomeRepository();
  final String updateUserLocation = Fins.ip + "home/user/0/update_location/";
  final String getUserInfoUrl = Fins.ip + "home/user/";
  final String updateToken = Fins.ip + "home/user/0/update_push_token/";
  final String getBestSellerInfoUrl =
      Fins.ip + "home/productPrice/?product_type=best_sellers";
  final String getHomeCategoryProductsUrl =
      Fins.ip + "home/productPrice/0/get_products_list/";
  final String getHomeBannerUrl = Fins.ip + "home/banners/";
  final String forLocationUrl = Fins.ip + "home/user/0/get_user_location_info/";
  final String getSearchUrl = Fins.ip + "home/productPrice/?search=van";
  final String cartUrl = Fins.ip + "home/cart/0/get_selected_product_json/";
  final String updateCartUrl = Fins.ip + "home/cart/0/update_cart/";

  late String phone, countCart, storeId;

  late UserRepository userRepository = UserRepository();
  late StoreRepository storeRepository = StoreRepository();
  late CartRepository cartRepository = CartRepository();
  final String logOutUrl = Fins.ip + "home/logout/";
  final String bannerUrl = Fins.ip + "home/bannerImages/";
  final String deleteCartUrl = Fins.ip + "home/cart/0/deleteCart/";
  final String getSubStoresUrl = Fins.ip + "home/regionList/";
  final String cartStoreUrl = Fins.ip + "home/cart/0/get_distinct_store/";
  final String cartCountUrl = Fins.ip + "home/cart/0/get_cart_count/";
  final String selectedProductUrl =
      Fins.ip + "home/cart/0/get_selectedProduct_json/";
  final String categoryUrl = Fins.ip + "home/productCategory/";
  final String particularStoreUrl =
      Fins.ip + "home/cart/0/get_particular_store/";
  final String getEcommerceUrl = Fins.ip + "home/ecommerceList/";
  final String storeLatestBrandUrl =
      Fins.ip + "home/store/0/get_most_recent_brands/";
  final String firstScreenUrl = Fins.ip + "home/store/0/getFirstSetOfScreen/";
  final String secondScreenUrl = Fins.ip + "home/store/0/getSecondSetOfScreen/";
  final String thirdScreenUrl = Fins.ip + "home/store/0/getThirdSetOfScreen/";
  late bool _serviceEnabled;

  Future saveUserDeliveryLocation(
      {required double latitude,
      required double longitude,
      required SharedPreferences sharedPreferences,
      required String address}) async {
    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.GRANTED) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      await homeRepository.updateUserLocation(
          url: updateUserLocation,
          token: sharedPreferences.getString("token").toString(),
          latitude: latitude.toString(),
          longitude: longitude.toString(),
          address: address);
    }
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    final currentState = state;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
        return;
      }
    }

    // TODO: implement mapEventToState
    // throw UnimplementedError();
    if (event is FetchStoreLocation) {
      try {
        _locationData = await location.getLocation();
      } catch (e) {
        print(e);
        locationFound = false;
      }

      String? token = await FirebaseMessaging.instance.getToken();

      final coordinates = new Coordinates(
          !locationFound ? defaultLatitude : _locationData.latitude,
          !locationFound ? defaultLongitude : _locationData.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      Fins.setUserLocation(
          latitude: !locationFound ? defaultLatitude : _locationData.latitude,
          longitude:
              !locationFound ? defaultLongitude : _locationData.longitude,
          address: first.featureName + ", " + first.addressLine);

      await saveUserDeliveryLocation(
          latitude: !locationFound ? defaultLatitude : _locationData.latitude,
          longitude:
              !locationFound ? defaultLongitude : _locationData.longitude,
          sharedPreferences: sharedPreferences,
          address: first.featureName + ", " + first.addressLine);
      var cartResponse = await homeRepository.fetchCartData(url: cartUrl);
      var cartData = cartResponse.data;
      // print(cartData['44']);

      await homeRepository.updatePushToken(
          url: updateToken, token: token.toString());

      var response =
          await homeRepository.fetchBestsellersData(url: getBestSellerInfoUrl);
      BestSellersData bestSellersData =
          BestSellersData.fromJson((response.data));
      var locationResponse =
          await homeRepository.fetchCurrentLocationData(url: forLocationUrl);
      UserLocationInfo userLocationInfo =
          UserLocationInfo.fromJson((locationResponse.data));

      for (int i = 0; i < bestSellersData.results.length; i++) {
        var sharedPreferenceSelectedValue =
            cartData[bestSellersData.results[i].id.toString()];
        bestSellersData.results[i].selected_count =
            (sharedPreferenceSelectedValue != null)
                ? sharedPreferenceSelectedValue
                : bestSellersData.results[i].selected_count;
      }
      var homeCategoryResponse = await homeRepository.fetchBestsellersData(
          url: getHomeCategoryProductsUrl);
      HomeCategoryProducts homeCategoryProducts =
          HomeCategoryProducts.fromJson((homeCategoryResponse.data));

      for (int i = 0; i < homeCategoryProducts.categoryResults.length; i++) {
        for (var index = 0;
            index < homeCategoryProducts.categoryResults[i].products.length;
            index++) {
          var sharedPreferenceSelectedValue = cartData[homeCategoryProducts
              .categoryResults[i].products[index].id
              .toString()];
          homeCategoryProducts
                  .categoryResults[i].products[index].selected_count =
              (sharedPreferenceSelectedValue != null)
                  ? sharedPreferenceSelectedValue
                  : homeCategoryProducts
                      .categoryResults[i].products[index].selected_count;
        }
      }

      var bannerDataResponse =
          await homeRepository.fetchBannerData(url: getHomeBannerUrl);
      BannerData bannerData = BannerData.fromJson(bannerDataResponse.data);
      var cartCountResponse =
          await homeRepository.fetchCartCountData(url: cartCountUrl);
      CustomResults customResults =
          CustomResults.fromJson(jsonDecode(cartCountResponse.data));

      yield HomeStateLoaded(
          cartCount: customResults.description,
          countLoading: true,
          // searchData: searchData,
          bannerData: bannerData,
          bestSellersData: bestSellersData,
          userAddress: first.featureName + ", " + first.addressLine,
          homeCategoryProducts: homeCategoryProducts,
          userLocationInfo: userLocationInfo);
    }

    if (event is FetchCategoryEvent && currentState is HomeStateLoaded) {
      yield HomeStateLoaded(
          cartCount: currentState.cartCount,
          countLoading: false,
          // searchData: searchData,
          bannerData: currentState.bannerData,
          bestSellersData: currentState.bestSellersData,
          userAddress: currentState.userAddress,
          homeCategoryProducts: currentState.homeCategoryProducts,
          userLocationInfo: currentState.userLocationInfo);

      var homeCategoryResponse = await homeRepository.fetchCategoryData(
          id: event.id.toString(), url: getHomeCategoryProductsUrl);
      HomeCategoryProducts homeCategoryProducts =
          HomeCategoryProducts.fromJson((homeCategoryResponse.data));
      yield HomeStateLoaded(
          cartCount: currentState.cartCount,
          countLoading: true,
          // searchData: searchData,
          bannerData: currentState.bannerData,
          bestSellersData: currentState.bestSellersData,
          userAddress: currentState.userAddress,
          homeCategoryProducts: homeCategoryProducts,
          userLocationInfo: currentState.userLocationInfo);
    }

    if (event is FetchReHome) {
      var cartResponse = await homeRepository.fetchCartData(url: cartUrl);
      var cartData = cartResponse.data;
      // print(cartData['44']);

      var response =
          await homeRepository.fetchBestsellersData(url: getBestSellerInfoUrl);
      BestSellersData bestSellersData =
          BestSellersData.fromJson((response.data));
      var locationResponse =
          await homeRepository.fetchCurrentLocationData(url: forLocationUrl);
      UserLocationInfo userLocationInfo =
          UserLocationInfo.fromJson((locationResponse.data));

      for (int i = 0; i < bestSellersData.results.length; i++) {
        var sharedPreferenceSelectedValue =
            cartData[bestSellersData.results[i].id.toString()];
        bestSellersData.results[i].selected_count =
            (sharedPreferenceSelectedValue != null)
                ? sharedPreferenceSelectedValue
                : bestSellersData.results[i].selected_count;
      }
      var homeCategoryResponse = await homeRepository.fetchBestsellersData(
          url: getHomeCategoryProductsUrl);
      HomeCategoryProducts homeCategoryProducts =
          HomeCategoryProducts.fromJson((homeCategoryResponse.data));

      for (int i = 0; i < homeCategoryProducts.categoryResults.length; i++) {
        for (var index = 0;
            index < homeCategoryProducts.categoryResults[i].products.length;
            index++) {
          var sharedPreferenceSelectedValue = cartData[homeCategoryProducts
              .categoryResults[i].products[index].id
              .toString()];
          homeCategoryProducts
                  .categoryResults[i].products[index].selected_count =
              (sharedPreferenceSelectedValue != null)
                  ? sharedPreferenceSelectedValue
                  : homeCategoryProducts
                      .categoryResults[i].products[index].selected_count;
        }
      }

      var bannerDataResponse =
          await homeRepository.fetchBannerData(url: getHomeBannerUrl);
      // print(bannerDataResponse);
      BannerData bannerData = BannerData.fromJson(bannerDataResponse.data);
      // var searchResponse = await homeRepository.fetchSearchData(url: getSearchUrl);
      // SearchData searchData=SearchData.fromJson(searchResponse.data);
      var cartCountResponse =
          await homeRepository.fetchCartCountData(url: cartCountUrl);
      CustomResults customResults =
          CustomResults.fromJson(jsonDecode(cartCountResponse.data));

      yield HomeStateLoaded(
          cartCount: customResults.description,
          countLoading: true,
          // searchData: searchData,
          bannerData: bannerData,
          bestSellersData: bestSellersData,
          userAddress: "",
          homeCategoryProducts: homeCategoryProducts,
          userLocationInfo: userLocationInfo);
    }

    if (event is AddProduct && currentState is HomeStateLoaded) {
      yield HomeStateLoaded(
        userLocationInfo: currentState.userLocationInfo,
        cartCount: currentState.cartCount,
        countLoading: false,
        // searchData: searchData,
        bannerData: currentState.bannerData,
        bestSellersData: currentState.bestSellersData,
        userAddress: currentState.userAddress,
        homeCategoryProducts: currentState.homeCategoryProducts,
      );
      var updateCart = await homeRepository.updateCartIdCount(
          url: updateCartUrl, id: event.productId, operationCode: "1");
      CustomResults customResults =
          CustomResults.fromJson(jsonDecode(updateCart.data));
      var bestSellers = currentState.bestSellersData;
      if (customResults.result == "success") {
        for (var i = 0; i < bestSellers.results.length; i++) {
          if (bestSellers.results[i].id.toString() == event.productId) {
            bestSellers.results[i].selected_count += 1;
            break;
          }
        }
      }
      yield HomeStateLoaded(
          userLocationInfo: currentState.userLocationInfo,
          cartCount: customResults.description,
          countLoading: true,
          // searchData: searchData,
          bannerData: currentState.bannerData,
          bestSellersData: bestSellers,
          userAddress: currentState.userAddress,
          homeCategoryProducts: currentState.homeCategoryProducts);
    }
    if (event is AddMenuProduct && currentState is HomeStateLoaded) {
      yield HomeStateLoaded(
          userLocationInfo: currentState.userLocationInfo,
          cartCount: currentState.cartCount,
          countLoading: false,
          // searchData: searchData,
          bannerData: currentState.bannerData,
          bestSellersData: currentState.bestSellersData,
          userAddress: currentState.userAddress,
          homeCategoryProducts: currentState.homeCategoryProducts);
      var updateCart = await homeRepository.updateCartIdCount(
          url: updateCartUrl, id: event.productId, operationCode: "1");
      CustomResults customResults =
          CustomResults.fromJson(jsonDecode(updateCart.data));
      var menuItems = currentState.homeCategoryProducts;
      for (var j = 0; j < menuItems.categoryResults.length; j++) {
        if (menuItems.categoryResults[j].categoryId.toString() ==
            event.categoryId) {
          if (customResults.result == "success") {
            for (var i = 0;
                i < menuItems.categoryResults[j].products.length;
                i++) {
              if (menuItems.categoryResults[j].products[i].id.toString() ==
                  event.productId) {
                menuItems.categoryResults[j].products[i].selected_count += 1;
                break;
              }
            }
          }
        }
      }

      yield HomeStateLoaded(
          userLocationInfo: currentState.userLocationInfo,
          countLoading: true,
          cartCount: customResults.description,
          // searchData: searchData,
          bannerData: currentState.bannerData,
          bestSellersData: currentState.bestSellersData,
          userAddress: currentState.userAddress,
          homeCategoryProducts: menuItems);
    }

    if (event is SubtractProduct && currentState is HomeStateLoaded) {
      yield HomeStateLoaded(
          userLocationInfo: currentState.userLocationInfo,
          cartCount: currentState.cartCount,
          countLoading: false,
          // searchData: searchData,
          bannerData: currentState.bannerData,
          bestSellersData: currentState.bestSellersData,
          userAddress: currentState.userAddress,
          homeCategoryProducts: currentState.homeCategoryProducts);
      var updateCart = await homeRepository.updateCartIdCount(
          url: updateCartUrl, id: event.productId, operationCode: "0");
      CustomResults customResults =
          CustomResults.fromJson(jsonDecode(updateCart.data));
      var bestSellers = currentState.bestSellersData;
      if (customResults.result == "success") {
        for (var i = 0; i < bestSellers.results.length; i++) {
          if (bestSellers.results[i].id.toString() == event.productId &&
              bestSellers.results[i].selected_count != 0) {
            bestSellers.results[i].selected_count -= 1;
            break;
          }
        }
      }
      print(customResults.description);
      yield HomeStateLoaded(
          userLocationInfo: currentState.userLocationInfo,
          cartCount: customResults.description,
          countLoading: true,
          // searchData: searchData,
          bannerData: currentState.bannerData,
          bestSellersData: bestSellers,
          userAddress: currentState.userAddress,
          homeCategoryProducts: currentState.homeCategoryProducts);
    }
    if (event is SubtractMenuProduct && currentState is HomeStateLoaded) {
      yield HomeStateLoaded(
          userLocationInfo: currentState.userLocationInfo,
          cartCount: currentState.cartCount,
          countLoading: false,
          // searchData: searchData,
          bannerData: currentState.bannerData,
          bestSellersData: currentState.bestSellersData,
          userAddress: currentState.userAddress,
          homeCategoryProducts: currentState.homeCategoryProducts);
      var updateCart = await homeRepository.updateCartIdCount(
          url: updateCartUrl, id: event.productId, operationCode: "0");
      CustomResults customResults =
          CustomResults.fromJson(jsonDecode(updateCart.data));
      var menuItems = currentState.homeCategoryProducts;
      for (var j = 0; j < menuItems.categoryResults.length; j++) {
        if (menuItems.categoryResults[j].categoryId.toString() ==
            event.categoryId) {
          if (customResults.result == "success") {
            for (var i = 0;
                i < menuItems.categoryResults[j].products.length;
                i++) {
              if (menuItems.categoryResults[j].products[i].id.toString() ==
                      event.productId &&
                  menuItems.categoryResults[j].products[i].selected_count !=
                      0) {
                menuItems.categoryResults[j].products[i].selected_count -= 1;
                break;
              }
            }
          }
        }
      }
      yield HomeStateLoaded(
          userLocationInfo: currentState.userLocationInfo,
          cartCount: customResults.description,
          countLoading: true,
          // searchData: searchData,
          bannerData: currentState.bannerData,
          bestSellersData: currentState.bestSellersData,
          userAddress: currentState.userAddress,
          homeCategoryProducts: menuItems);
    }
  }
}
