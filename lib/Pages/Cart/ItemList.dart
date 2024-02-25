import 'package:cached_network_image/cached_network_image.dart';
import 'package:fins_user/Bloc/CartBloc/Cart_Bloc.dart';
import 'package:fins_user/Bloc/CartBloc/Cart_Event.dart';
import 'package:fins_user/Models/cartProduct.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/material.dart';

class ItemList extends StatefulWidget {
  final ProductList cartProduct;
  final CartStoreBloc cartStoreBloc;
  const ItemList({Key? key,required this.cartProduct,required this.cartStoreBloc}) : super(key: key);

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  int itemCount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.all(Fins.commonPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                 Padding(
                    padding: const EdgeInsets.only(top:4.0),
                    child: ClipRRect(borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                          imageUrl:widget. cartProduct.image,height: 80,fit: BoxFit.cover,
                          placeholder: (context, url) => Image.asset("images/load.gif",height: 80,),
                          errorWidget: (context, url, error) => Image.asset("images/logo_gray.png",height: 80,),
                        )

                    ),
                  ),
                  //   Padding(
                  //   padding: const EdgeInsets.only(top:4.0),
                  //   child: ClipRRect(borderRadius: BorderRadius.circular(8.0),
                  //       child: CachedNetworkImage(
                  //         imageUrl: widget.cartProduct.productId.product.productImageIds[0].image,height: 80,fit: BoxFit.cover,
                  //         placeholder: (context, url) => Image.asset("images/load.gif",height: 80,),
                  //         errorWidget: (context, url, error) => Image.asset("images/logo_gray.png",height: 80,),
                  //       )

                  //   ),
                  // ),
                // Container(
                //   height: 80,
                //   width: 80,
                //   decoration: BoxDecoration(
                //       color: Colors.grey[300],
                //       borderRadius: BorderRadius.circular(Fins.buttonRadius)),
                // ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.cartProduct.name,
                            style: TextStyle(
                              height: Fins.textHeight,
                              fontSize: Fins.textSize,
                            )),
                        SizedBox(
                          height: 5,
                        ),
// widget.cartProduct.productId.product_quantity_title
                       Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            (widget.cartProduct.weight==0 && widget.cartProduct.productQuantityTitle =="") ? Container() 
                            : Text((widget.cartProduct.weight==0) ?"" : widget.cartProduct.weight.toString()+widget.cartProduct.productQuantityTitle+ "  "),
                            (widget.cartProduct.price != widget.cartProduct.withoutDiscount) ?  Column(
                              children: <Widget>[
                                Text(
                                 widget.cartProduct.discount.toString()+"% off".toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 12.0,color:Color(0xff23CB66) ),
                                ),

                              ],
                            ):Container(),
                          ],

                        ),
                        SizedBox(
                          height: 5,
                        ),
                     
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                        child: (widget.cartProduct.quantity   ==0)
                            ? Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: SizedBox(
                                  height: 30,
                                  width: 90,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: Fins.finsColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              Fins.buttonRadius)),
                                    ),
                                    onPressed: () {
                                      widget.cartStoreBloc.add(AddProductStoreEvent(productId:widget. cartProduct.id));
                                      // setState(() {
                                      //   itemCount = 1;
                                      // });
                                    },
                                    child: Text("ADD"),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: SizedBox(
                                    height: 30,
                                    width: 90,
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            widget. cartStoreBloc.add(MinusProductStoreEvent(productId:widget. cartProduct.id));
                                            // setState(() {
                                            //   itemCount -= 1;
                                            // });
                                          },
                                          child: AnimatedContainer(
                                            duration:
                                                Duration(milliseconds: 1000),
                                            decoration: BoxDecoration(
                                                color: Fins.finsColor,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            height: 30,
                                            width: 30,
                                            child: Icon(
                                              Icons.remove,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 30,
                                          width: 30,
                                          child: Center(
                                              child: Text(
                                            // itemCount.toString(),
                                            widget.cartProduct.quantity.toString(),
                                            style: TextStyle(
                                                color: Fins.finsColor),
                                          )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            widget.cartStoreBloc.add(AddProductStoreEvent(productId:widget. cartProduct.id));
                                          },
                                          //   setState(() {
                                          //     itemCount += 1;
                                          //   });
                                          // },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Fins.finsColor,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            height: 30,
                                            width: 30,
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              )),
                    SizedBox(
                      height: 15,
                    ),
                     Row(
                          children: <Widget>[
                            Text("₹ "+widget.cartProduct.price.toString()),
                            Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child:(widget.cartProduct.price != widget.cartProduct .withoutDiscount) ?
                                Text("₹ "+widget.cartProduct.withoutDiscount.toString(),style: TextStyle(fontSize: 12.0,decoration: TextDecoration.lineThrough),):
                                Container())
                          ],
                        )
                  ],
                ),

             
              ],
            ),
          ),
        ),
        Divider(
          thickness: 1,
        )
      ],
    );
  }
}
