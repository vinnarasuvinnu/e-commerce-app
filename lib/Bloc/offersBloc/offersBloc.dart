import 'dart:convert';

import 'package:fins_user/Bloc/HomeBloc/home_state.dart';
import 'package:fins_user/Models/couponList.dart';
import 'package:fins_user/Models/custom_result.dart';
import 'package:fins_user/Models/offersList.dart';
import 'package:fins_user/repository/homeRepository.dart';
import 'package:fins_user/repository/offerRepository.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'offersEvent.dart';
import 'offersState.dart';

class OfferBloc extends Bloc<OfferEvent, OfferState> {
  late HomeRepository homeRepository = new HomeRepository();

  final String offerUrl = Fins.ip + "home/productPrice/?discount=true";
  final String cartUrl = Fins.ip + "home/cart/0/get_selected_product_json/";
  final String updateCartUrl = Fins.ip + "home/cart/0/update_cart/";

  OfferBloc(OfferState initialState) : super(initialState);

  @override
  // TODO: implement initialState
  OfferState get initialState => OfferUninitialized();

  @override
  Stream<OfferState> mapEventToState(OfferEvent event) async* {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var currentState = state;
    try {
      if (event is FetchOffers) {
        var cartResponse = await homeRepository.fetchCartData(url: cartUrl);
        var cartData = cartResponse.data;
        var fetchOffer = await homeRepository.fetchOfferData(url: offerUrl);
        OffersData offersData = OffersData.fromJson(fetchOffer.data);

        for (int i = 0; i < offersData.results.length; i++) {
          var sharedPreferenceSelectedValue =
              cartData[offersData.results[i].id.toString()];
          offersData.results[i].selected_count =
              (sharedPreferenceSelectedValue != null)
                  ? sharedPreferenceSelectedValue
                  : offersData.results[i].selected_count;
        }

        yield OfferLoaded(offersData: offersData, countLoading: true);
      }
    } catch (e) {
      yield OfferError();
    }

    if (event is AddOfferProduct && currentState is OfferLoaded) {
      yield OfferLoaded(
          offersData: currentState.offersData, countLoading: false);

      var updateCart = await homeRepository.updateCartIdCount(
          url: updateCartUrl, id: event.productId, operationCode: "1");
      CustomResults customResults =
          CustomResults.fromJson(jsonDecode(updateCart.data));
      var offer = currentState.offersData;
      if (customResults.result == "success") {
        for (var i = 0; i < offer.results.length; i++) {
          if (offer.results[i].id.toString() == event.productId) {
            offer.results[i].selected_count += 1;
            break;
          }
        }
      }
      yield OfferLoaded(
          offersData: currentState.offersData, countLoading: true);
    }
    if (event is SubtractOfferProduct && currentState is OfferLoaded) {
      yield OfferLoaded(
          offersData: currentState.offersData, countLoading: false);

      var updateCart = await homeRepository.updateCartIdCount(
          url: updateCartUrl, id: event.productId, operationCode: "1");
      CustomResults customResults =
          CustomResults.fromJson(jsonDecode(updateCart.data));
      var offer = currentState.offersData;
      if (customResults.result == "success") {
        for (var i = 0; i < offer.results.length; i++) {
          if (offer.results[i].id.toString() == event.productId && offer.results[i].selected_count!=0) {
            offer.results[i].selected_count -= 1;
            break;
          }
        }
      }
      yield OfferLoaded(
          offersData: currentState.offersData, countLoading: true);
    }
  }
}
