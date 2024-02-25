import 'package:fins_user/Bloc/OrderBloc/OrderBloc.dart';
import 'package:fins_user/Bloc/OrderBloc/OrderEvent.dart';
import 'package:fins_user/Bloc/OrderBloc/OrderState.dart';
import 'package:fins_user/Pages/Loader/bottomLoader.dart';
import 'package:fins_user/utils/NoOrders.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../LoadingListPage.dart';
import 'OrderList.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  late OrderBloc _orderBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_onScroll);

    _orderBloc = OrderBloc(OrderStateUnInitilized());
    retrieveData();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _orderBloc.add(ScrollOrders());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  void retrieveData() {
    _orderBloc.add(FetchOrders());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("My Orders"),),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: Fins.titleTextPadding),
          child: Text(
            "My Orders",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: BlocProvider<OrderBloc>(
        create: (BuildContext context) {
          return _orderBloc;
        },
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderStateUnInitilized) {
              return LoadingListPage();
            }
            if (state is OrderStateError) {
              return Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "images/noOrders.png",
                            height: 300,
                            width: 300,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Start buying your best product on our store...",
                                style: TextStyle(fontSize: 16.0),
                                textAlign: TextAlign.center,
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              );
            }
            if (state is OrderStateLoaded) {
              if (state.to_order.isEmpty) {
                return NoOrders();
              }
              return RefreshIndicator(
                color: Fins.finsColor,
                onRefresh: () async {
                  retrieveData();
                },
                child: Scaffold(
                  backgroundColor: Colors.white,
                  body: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return index >= state.to_order.length
                          ? BottomLoader()
                          : OrderList(
                              order: state.to_order[index],
                              orderBloc: _orderBloc,
                            );
                    },
                    itemCount: state.hasReachedMax
                        ? state.to_order.length
                        : state.to_order.length + 1,
                    controller: _scrollController,
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;
}
