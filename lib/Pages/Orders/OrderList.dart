import 'package:fins_user/Bloc/OrderBloc/OrderBloc.dart';
import 'package:fins_user/Models/Order.dart';
import 'package:fins_user/Pages/Orders/orderStatus.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/material.dart';

class OrderList extends StatefulWidget {
  final ToOrderList order;
  final OrderBloc orderBloc;

  const OrderList({Key? key, required this.order, required this.orderBloc})
      : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
// var orderStatus=1;
  getIconColor(statusId) {
    if (widget.order.statusId == 1) {
      return Icon(Icons.done_all, color: Colors.orange);
    } else if (widget.order.statusId == 2) {
      return Icon(Icons.done_all, color: Colors.blue);
    } else if (widget.order.statusId == 4) {
      return Icon(Icons.done_all, color: Colors.green);
    } else if (widget.order.statusId == 5) {
      return Icon(Icons.cloud_upload, color: Colors.blue);
    } else if (widget.order.statusId == 6) {
      return Icon(Icons.done, color: Colors.purple);
    } else {
      return Icon(Icons.cancel_outlined, color: Fins.finsColor);
    }
  }

  getTextColor(statusId) {
    if (widget.order.statusId == 1) {
      return Text("Ordered",
          style: TextStyle(
              height: Fins.textHeight,
              fontSize: Fins.textSize,
              color: Colors.orange));
    } else if (widget.order.statusId == 2) {
      return Text("Out for delivery",
          style: TextStyle(
              height: Fins.textHeight,
              fontSize: Fins.textSize,
              color: Colors.blue));
    } else if (widget.order.statusId == 4) {
      return Text("Delivered",
          style: TextStyle(
              height: Fins.textHeight,
              fontSize: Fins.textSize,
              color: Colors.green));
    } else if (widget.order.statusId == 5) {
      return Text("Payment Processing",
          style: TextStyle(
              height: Fins.textHeight,
              fontSize: Fins.textSize,
              color: Colors.blue));
    } else if (widget.order.statusId == 6) {
      return Text("Order Accepted",
          style: TextStyle(
              height: Fins.textHeight,
              fontSize: Fins.textSize,
              color: Colors.purple));
    } else {
      return Text("Cancelled",
          style: TextStyle(
              height: Fins.textHeight,
              fontSize: Fins.textSize,
              color: Fins.finsColor));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(Fins.buttonRadius),
          //   border: Border.all(color: Fins.secondaryTextColor)),
          child: Padding(
            padding: const EdgeInsets.all(Fins.commonPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Icon(Icons.done_all,color: Fins.finsColor,),
                    getIconColor(widget.order.statusId),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: getTextColor(widget.order.statusId),
                      ),
                    ),
                    Text(widget.order.orderDate,
                        style: TextStyle(
                            height: Fins.textHeight,
                            fontSize: Fins.textSmallSize,
                            color: Fins.textColor))
                  ],
                ),
                SizedBox(
                  height: Fins.sizedBoxHeight,
                ),
//
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            widget.order.storeName,
                            style: TextStyle(
                                height: Fins.textHeight,
                                fontSize: Fins.textSize,
                                color: Fins.textColor,
                                fontWeight: FontWeight.bold),
                          )),
                          Text("Order ID:" + widget.order.id.toString(),
                              style: TextStyle(
                                  height: Fins.textHeight,
                                  fontSize: Fins.textSize,
                                  color: Fins.textColor)),
                        ],
                      ),
                      (widget.order.totalItems <= 1)
                          ? Text(widget.order.totalItems.toString() + "item",
                              style: TextStyle(
                                  height: Fins.textHeight,
                                  fontSize: Fins.textSize,
                                  color: Fins.secondaryTextColor))
                          : Text(widget.order.totalItems.toString() + "items",
                              style: TextStyle(
                                  height: Fins.textHeight,
                                  fontSize: Fins.textSize,
                                  color: Fins.secondaryTextColor)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                              child: Text("₹" + widget.order.price.toString(),
                                  style: TextStyle(
                                      height: Fins.textHeight,
                                      fontSize: Fins.textSize,
                                      color: Fins.textColor,
                                      fontWeight: FontWeight.bold))),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Fins.finsColor)),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OrderStatus(
                                              order: widget.order,
                                              orderBloc: widget.orderBloc)));
                                },
                                child: Text("View order",
                                    style: TextStyle(
                                      height: Fins.textHeight,
                                      fontSize: Fins.textSize,
                                    ))),
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                // SizedBox(height: Fins.sizedBoxHeight,),

                //  Row(
                //    crossAxisAlignment: CrossAxisAlignment.start,
                //    mainAxisAlignment: MainAxisAlignment.start,
                //    children: [
                //     //  Container(
                //     //    height:50,
                //     //    width: 75,
                //     //    decoration: BoxDecoration(
                //     //      borderRadius: BorderRadius.circular(Fins.buttonRadius),
                //     //      color: Fins.secondaryTextColor,
                //     //      image: DecorationImage(image: AssetImage("images/user.png"))),),
                //          Expanded(
                //            child: Padding(
                //                 padding: const EdgeInsets.only(left:5),
                //              child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //    mainAxisAlignment: MainAxisAlignment.start,
                //                children: [
                //                  Text("Fins & Slices",style:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,color: Fins.textColor,fontWeight: FontWeight.bold),),
                //                   Text("3 tiems",style:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,color: Fins.textColor)),
                //              Text("₹ 1000.5",style:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,color: Fins.textColor,fontWeight: FontWeight.bold))
                //                ],
                //              ),
                //            ),

                //          ),
                //            Align(
                //      alignment: Alignment.centerRight,
                //      child: ElevatedButton(
                //        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(
                //          Fins.finsColor
                //        )),
                //        onPressed: (){

                //              Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderStatus()));
                //        }, child: Text("View order",style:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,))),
                //    ),
                //          Column(
                //            crossAxisAlignment: CrossAxisAlignment.end,
                //            children: [
                //              Text("3 tiems",style:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,color: Fins.textColor)),
                //              Text("₹ 1000.5",style:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,color: Fins.textColor,fontWeight: FontWeight.bold))
                //            ],
                //          )
                //    ],
                //  ),
                //  SizedBox(height: Fins.sizedBoxHeight,),
              ],
            ),
          ),
        ),
        Divider(
          thickness: Fins.dividerHeight,
        ),
      ],
    );
  }
}
