import 'dart:convert';

import 'package:fins_user/Bloc/DeliveryBloc/Delivery_Event.dart';
import 'package:fins_user/Bloc/DeliveryBloc/Delivery_State.dart';
import 'package:fins_user/Models/DeliveryAddressRest.dart';
import 'package:fins_user/Models/cartStore.dart';
import 'package:fins_user/Models/custom_result.dart';
import 'package:fins_user/repository/PaymentRepository.dart';
import 'package:fins_user/Models/UserRest.dart';
import 'package:fins_user/repository/homeRepository.dart';
import 'package:fins_user/repository/userRepository.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryBloc extends Bloc<DeliveryEvent, DeliveryState> {
  final String locationUrl = Fins.ip + "home/location/";
  final String getLocationDescription =
      Fins.ip + "home/user/0/get_location_description/";
  HomeRepository homeRepository = HomeRepository();
  UserRepository userRepository = UserRepository();
  final String getUserInfoUrl = Fins.ip + "home/user/";
  PaymentRepository _paymentRepository = PaymentRepository();
  final String saveOrderUrl = Fins.ip + "home/createOrder/";
  final String saveAddressUrl = Fins.ip + "home/deliveryAddress/0/saveAddress/";
  final String saveAddressCountUrl =
      Fins.ip + "home/deliveryAddress/0/get_address_count/";
  final String razorPayKeyUrl = Fins.ip + "home/cart/0/get_particular_store/";
  final String fetchSaveAddressUrl = Fins.ip + "home/deliveryAddress/";

  int paymentType = 1;
  var deliveryCharge = 0.0, deliveryTax = 0.0, packingCharge = 0.0;

  DeliveryBloc(DeliveryState initialState) : super(initialState);

  @override
  // TODO: implement initialState
  DeliveryState get initialState => DeliveryUninitialized();

  @override
  Stream<DeliveryState> mapEventToState(DeliveryEvent event) async* {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var phone = sharedPreferences.getString("mobile");
    var currentState = state;
    // TODO: implement mapEventToState
    if (event is LoadDeliveryInfo) {
      // var userInfoResponse=await userRepository.getUserInfo(url: getUserInfoUrl,phone: phone);
      // UserRest userRest=UserRest.fromJson(userInfoResponse.data);

      final razorPayResponse =
          await userRepository.getRazorPayKey(url: razorPayKeyUrl);

      CartStore store = CartStore.fromJson((razorPayResponse.data));

      yield DeliveryLoaded(store: store);
      return;
    }

    if (event is RazorPayError) {
      yield DeliveryPaymentError();
    }

    if (event is SaveOrderDelivery) {
      yield DeliveryPaymentLoading();

      final saveOrderResponse = await _paymentRepository.saveOrder(
          orderType: event.orderType,
          url: saveOrderUrl,
          paymentType: event.paymentType,
          home_no: event.home_no,
          landmark: event.landmark);

      CustomResults customResult =
          CustomResults.fromJson(jsonDecode(saveOrderResponse.data));
      yield (customResult.result == "success")
          ? DeliveryPaymentSuccess()
          : DeliveryPaymentError();
      return;
    }

    if (event is PaymentSuccessEvent) {
      yield DeliveryPaymentLoading();
      yield DeliveryPaymentSuccess();
    }

    if (event is FetchDeliveryAddress) {
      yield DeliveryAddressLoaded(deliveryAddress: event.deliveryAddress);
    }

    if (event is SaveAddress && currentState is DeliveryAddressLoaded) {
      var addressResponse = await _paymentRepository.saveAddress(
          url: saveAddressUrl,
          delivery_address: event.mapAddress,
          longitude: event.longitude,
          latitude: event.latitude,
          flat_number: event.flatNumber,
          land_mark: event.landMark,
          address_type: event.addressType,
          phone: phone);

      CustomResults customResult =
          CustomResults.fromJson(jsonDecode(addressResponse.data));
      if (customResult.result == "success") {
        sharedPreferences.setString("address_id", customResult.description);

        Fins.setDeliveryAddressId(addressId: customResult.description);
      }

      yield DeliveryAddressLoaded(
          deliveryAddress: currentState.deliveryAddress);
    }

    if (event is SaveNewAddress) {
      await _paymentRepository.saveAddress(
          url: saveAddressUrl,
          delivery_address: event.mapAddress,
          longitude: event.longitude,
          latitude: event.latitude,
          flat_number: event.flatNumber,
          land_mark: event.landMark,
          address_type: event.addressType,
          phone: phone);
    }

    if (event is FetchSavedDeliveryAddress) {
      var allAddress = await _paymentRepository.fetchDeliveryAddress(
          url: fetchSaveAddressUrl, phone: phone);
      DeliveryAddressRest deliveryAddressRest =
          DeliveryAddressRest.fromJson(allAddress.data);

      yield DeliverySavedAddressLoaded();
    }

    // if(event is DeleteDeliveryAddress && currentState is DeliverySavedAddressLoaded){

    //   var deleteAddress=await _paymentRepository.deleteDeliveryAddress(url: fetchSaveAddressUrl,address_id: event.addressId.toString());
    //   var totalProducts=currentState.deliverAddress;

    //   if(deleteAddress.data != null){

    //     totalProducts.removeWhere((element) => element.id==event.addressId);
    //     yield DeletedAddressState();

    //   }
    //   yield DeliverySavedAddressLoaded(deliverAddress: totalProducts);

    // }

    // if(event is EditDeliveryAddress){
    //   yield EditDeliveryAddressLoaded(deliveryAddress: event.deliveryAddress);
    // }

    // if(event is SaveEditedAddress ){
    //   await _paymentRepository.saveEditedAddress(url: fetchSaveAddressUrl,flat_number: event.homeNumber,land_mark: event.landMark,address_id: event.addressId);

    //     var allAddress=await _paymentRepository.fetchDeliveryAddress(url:fetchSaveAddressUrl,phone: phone);
    //     DeliveryAddressRest deliveryAddressRest=DeliveryAddressRest.fromJson(allAddress.data);
    //     yield DeliverySavedAddressLoaded(deliverAddress: deliveryAddressRest.results);

    // }
  }
}
