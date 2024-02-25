import 'package:fins_user/Bloc/CartBloc/Cart_Bloc.dart';
import 'package:fins_user/Bloc/CartBloc/Cart_Event.dart';
import 'package:fins_user/Bloc/CartBloc/Cart_State.dart';
import 'package:fins_user/LoadingListPage.dart';
import 'package:fins_user/Models/cartProduct.dart';
import 'package:fins_user/Models/cartStore.dart';
import 'package:fins_user/Pages/Account/Login.dart';
import 'package:fins_user/Pages/Cart/Checkout.dart';
import 'package:fins_user/Pages/Cart/ItemList.dart';
import 'package:fins_user/Pages/Cart/ShopItemDetails.dart';
import 'package:fins_user/Pages/Loader/bottomLoader.dart';
import 'package:fins_user/utils/NoCart.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCart extends StatefulWidget {
  const MyCart({ Key? key }) : super(key: key);

  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  late CartStoreBloc _cartStoreBloc;
 late CartStoreState cartStoreState; 
 late CartProduct cartProduct;
// late  CartStore store;
  @override
  void initState() { 
    super.initState();
    _cartStoreBloc=new CartStoreBloc(CartStoreUninitialized());
  }
   @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Cart"),),
      body: BlocProvider<CartStoreBloc>(
        create: (BuildContext context){
          return _cartStoreBloc..add(FetchCartStoreProduct());
        },
        child: BlocBuilder<CartStoreBloc,CartStoreState>(
          builder: (context ,state){
             if (state is CartStoreUninitialized) {
              return LoadingListPage();
            }

            if (state is CartStoreError) {
              return NoCart();
            }
            if (state is CartStoreLoaded) {
              if (state.product.isEmpty) {
                return NoCart();
              }
          
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: ListView.builder(
                             shrinkWrap: true,
                               itemBuilder: (BuildContext context,int index){
                                   return index >= state.product.length ? BottomLoader() : ItemList(cartProduct: state.product[index],cartStoreBloc: _cartStoreBloc,);

                               },
                             itemCount: state.hasReachedMax ? state.product.length:state.product.length+1,
                             controller: _scrollController,
                           ),
            ),
            bottomNavigationBar: SizedBox(
        height: 50,
        child:      ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(
            Fins.finsColor
          )),
                            child: Text("Checkout".toUpperCase(), style: TextStyle(
                                color: Colors.white,
                                fontSize: Fins.textSize,
                                fontWeight: FontWeight.bold)),
                            onPressed: () async {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Checkout()));
                            },
                      ),

        // child: InkWell(
        //   onTap: (){
        //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>Checkout()));
        //   },
        //   child: Container(
        //     decoration:BoxDecoration(color: Fins.finsColor),
        //     child: 
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child:Center(child: Text("checkout".toUpperCase(),style:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,color: Colors.white)))
        //   ),),
        // ),
      ),
          );
          }
          return Container();
          }
        )
      ),
     
      
    );
  }
}
