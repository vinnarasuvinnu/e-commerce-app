

import 'package:fins_user/Bloc/OrderBloc/OrderEvent.dart';
import 'package:fins_user/Bloc/OrderBloc/OrderState.dart';
import 'package:fins_user/Models/Order.dart';
import 'package:fins_user/Models/Orderrest.dart';
import 'package:fins_user/repository/OrderRepositor.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState>{
  OrderBloc(OrderState initialState) : super(initialState);
  String orderUrl=Fins.ip+"home/order/";
 late String username;
 late String next;
 late String getToken;

 
   OrderRepository _orderRepository=OrderRepository();

  @override
  Stream<OrderState> mapEventToState(OrderEvent event)async* {
    // TODO: implement mapEventToState
    // throw UnimplementedError();
    final currentState=state;
 SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
 username=sharedPreferences.getString("Login");
 getToken=sharedPreferences.getString("token");


    if(event is FetchOrders){
      // try{
var orderResponse=await _orderRepository.fetchOrders(url:orderUrl);

Order orderRest=Order.fromJson(orderResponse.data);

next=orderRest.next;
 yield OrderStateLoaded(to_order:orderRest.results,hasReachedMax: (next != null)? false:true);
      // }
      // catch(e)
      // {
      //   yield OrderStateError();
      // }

    }
   if(event is ScrollOrders && !_hasReachedMax(currentState) ){

      if(currentState is OrderStateLoaded){
        final orderResponse=await _orderRepository.fetchScrollOrders(url:next);

        Order orderRest=Order.fromJson(orderResponse.data);
        next=orderRest.next;
        yield OrderStateLoaded(to_order: currentState.to_order+orderRest.results,hasReachedMax: (next != null) ? false : true);

      }

    }

    // if(event is FetchOrders){x
    //   yield OrderStateLoaded(order: );
    // }
    // if(event is ScroolOrders ){
    //   yield OrderStateLoaded(order: []);
    // }
  }
 bool _hasReachedMax(OrderState state)=> state is OrderStateLoaded && state.hasReachedMax;
  
}

