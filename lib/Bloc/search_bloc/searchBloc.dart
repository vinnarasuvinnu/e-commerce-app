import 'dart:convert';

import 'package:fins_user/Bloc/register_bloc/registerState.dart';
import 'package:fins_user/Bloc/search_bloc/searchState.dart';
import 'package:fins_user/Models/custom_result.dart';
import 'package:fins_user/Models/searchItems.dart';
import 'package:fins_user/repository/homeRepository.dart';
import 'package:fins_user/repository/userRepository.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'searchEvent.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  late HomeRepository homeRepository = new HomeRepository();
  final String getSearchUrl = Fins.ip + "home/productPrice/?search=";
  final String cartUrl = Fins.ip + "home/cart/0/get_selected_product_json/";
  final String cartCountUrl = Fins.ip + "home/cart/0/get_cart_count/";
  final String updateCartUrl = Fins.ip + "home/cart/0/update_cart/";

  SearchBloc(SearchState initialState) : super(initialState);

  @override
  // TODO: implement initialState
  RegisterState get initialState => RegisterUninitialized();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    final currentState = state;

    // TODO: implement mapEventToState
    if (event is SearchUserEvent) {
      yield SearchUninitialized();
      try {
        var cartResponse = await homeRepository.fetchCartData(url: cartUrl);
        var cartData = cartResponse.data;
        var searchResponse = await homeRepository.fetchSearchData(
            url: getSearchUrl + event.searchController);
        SearchData searchData = SearchData.fromJson(searchResponse.data);

        for (int i = 0; i < searchData.results.length; i++) {
          var sharedPreferenceSelectedValue =
              cartData[searchData.results[i].id.toString()];
          searchData.results[i].selected_count =
              (sharedPreferenceSelectedValue != null)
                  ? sharedPreferenceSelectedValue
                  : searchData.results[i].selected_count;
        }

        yield SearchSuccess(searchData: searchData, countLoading: true);
      } catch (e) {}
    }
    if (event is AddSearchProduct && currentState is SearchSuccess) {
      yield SearchSuccess(
          searchData: currentState.searchData, countLoading: false);
      var updateCart = await homeRepository.updateCartIdCount(
          url: updateCartUrl, id: event.productId, operationCode: "1");
      CustomResults customResults =
          CustomResults.fromJson(jsonDecode(updateCart.data));
      var search = currentState.searchData;
      if (customResults.result == "success") {
        for (var i = 0; i < search.results.length; i++) {
          if (search.results[i].id.toString() == event.productId) {
            search.results[i].selected_count += 1;
            break;
          }
        }
      }
      yield SearchSuccess(
          searchData: currentState.searchData, countLoading: true);
    }
    if (event is SubtractSearchProduct && currentState is SearchSuccess) {
      yield SearchSuccess(
          searchData: currentState.searchData, countLoading: false);
      var updateCart = await homeRepository.updateCartIdCount(
          url: updateCartUrl, id: event.productId, operationCode: "0");
      CustomResults customResults =
          CustomResults.fromJson(jsonDecode(updateCart.data));
      var search = currentState.searchData;
      if (customResults.result == "success") {
        for (var i = 0; i < search.results.length; i++) {
          if (search.results[i].id.toString() == event.productId &&
              search.results[i].selected_count != 0) {
            search.results[i].selected_count -= 1;
            break;
          }
        }
      }
      yield SearchSuccess(
          searchData: currentState.searchData, countLoading: true);
    }
  }
}
