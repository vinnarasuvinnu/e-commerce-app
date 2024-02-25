

import 'dart:convert';

import 'package:fins_user/Bloc/CartBloc/Cart_Event.dart';
import 'package:fins_user/Bloc/CartBloc/Cart_State.dart';
import 'package:fins_user/Models/CartParticulerStore.dart';
import 'package:fins_user/Models/CartStoresList.dart';
import 'package:fins_user/Models/cartProduct.dart';
import 'package:fins_user/Models/cartProductRest.dart';
import 'package:fins_user/Models/custom_result.dart';
import 'package:fins_user/repository/cartRepository.dart';
import 'package:fins_user/repository/homeRepository.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartStoreBloc extends Bloc<CartStoreEvent, CartStoreState>{
 String cartProductUrl=Fins.ip+"home/cart/";
  CartRepository cartRepository=new CartRepository();
  HomeRepository homeRepository=new HomeRepository();
 late  String next="";
 late String storeId,phone;
  String cartStoreUrl=Fins.ip+"home/cart/0/get_distinct_store/";

  final String updateCartUrl=Fins.ip+"home/cart/0/update_cart_directly/";
  final String particularStoreUrl=Fins.ip+"home/cart/";
  final String selectedProductUrl=Fins.ip+"home/cart/0/get_selectedProduct_json/";
  var selectedProductJson;

  CartStoreBloc(CartStoreState initialState) : super(initialState);

  @override
  // TODO: implement initialState
  CartStoreState get initialState => CartStoreUninitialized();

  @override
  Stream<CartStoreState> mapEventToState(CartStoreEvent event)async* {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();

    storeId=sharedPreferences.getString("store_id");
    phone=sharedPreferences.getString("mobile");
    // TODO: implement mapEventToState
    final currentState=state;
    //current state error

    if(event is FetchCartStoreProduct){
      print("its Fetch CartStore ");
      try {
  final response = await cartRepository.fetchCartProducts(
            url: cartProductUrl,phone: phone);
            print("its response"+response.toString());
        CartProduct product = CartProduct.fromJson(response.data);
        next = product.next;



        // var responseStore=await cartRepository.fetchParticularStore(url:particularStoreUrl,phone: phone,storeId: storeId);
        // print("its secnd"+responseStore.toString());
        // CartProduct cartStor=CartProduct.fromJson((responseStore.data));


        print(product.results);

        yield CartStoreLoaded(product:product.results,
            
            hasReachedMax: (next == null) ? true : false,countLoading: false);


        return;
      }
      catch(e){
        print(e);
        yield CartStoreError();

      }

    }

    if(event is ScrollCartStoreProduct && !_hasReachedMax(currentState)){
      if(currentState is CartStoreLoaded){
        final response=await cartRepository.fetchScrollCartProducts(url: next);
        CartProduct product=CartProduct.fromJson(response.data);
        next=product.next.toString();
        Fins.allowScrolling=true;

        yield CartStoreLoaded(product: currentState.product,
           
            hasReachedMax: (next == null) ? true : false,countLoading: false);

      }
    }


    if(event is AddProductStoreEvent){
      if(currentState is CartStoreLoaded){
        yield CartStoreLoaded(product: currentState.product,hasReachedMax: currentState.hasReachedMax,countLoading: true);
        await homeRepository.updateCart(url:updateCartUrl,productId: event.productId.toString(),operationCode: "1",storeId: storeId );
        var totalProducts=currentState.product;

        for(int i=0;i<totalProducts.length;i++){

          if(totalProducts[i].id==event.productId){
            totalProducts[i].quantity=totalProducts[i].quantity+1;
            break;
          }
        }

        // final storeResponse=await cartRepository.fetchParticularStore(url: particularStoreUrl,phone: phone);
        // CustomResults customResults=CustomResults.fromJson(jsonDecode(storeResponse.data));



        yield CartStoreLoaded(product: totalProducts,hasReachedMax: currentState.hasReachedMax,countLoading: false);


      }
    }


    if(event is MinusProductStoreEvent){
      if(currentState is CartStoreLoaded){
        yield CartStoreLoaded(product: currentState.product,hasReachedMax: currentState.hasReachedMax,countLoading: true);
        await homeRepository.updateCart(url:updateCartUrl,productId: event.productId.toString(),operationCode: "0",storeId: storeId );
        var totalProducts=currentState.product;

        for(int i=0;i<totalProducts.length;i++){
          if(totalProducts[i].id==event.productId && totalProducts[i].quantity != 0){
            totalProducts[i].quantity=totalProducts[i].quantity-1;
            break;
          }

        }
        totalProducts.removeWhere((element) => element.quantity==0);

        // final storeResponse=await cartRepository.fetchParticularStore(url: particularStoreUrl,phone: phone);
        // CartParticulerStore cartParticularStore=CartParticulerStore.fromJson(jsonDecode(storeResponse.data));



        yield CartStoreLoaded(product: totalProducts,hasReachedMax: currentState.hasReachedMax,countLoading: false);


      }
    }






  }



  bool _hasReachedMax(CartStoreState state)=> state is CartStoreLoaded && state.hasReachedMax;


}