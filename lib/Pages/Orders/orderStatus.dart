import 'package:fins_user/Bloc/OrderBloc/OrderBloc.dart';
import 'package:fins_user/Bloc/OrderBloc/OrderState.dart';
import 'package:fins_user/Models/Order.dart';
import 'package:fins_user/Models/Orderitems.dart';
import 'package:fins_user/Pages/Orders/OrderDetaild.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderStatus extends StatefulWidget {
  final ToOrderList order;
  final OrderBloc orderBloc;

  const OrderStatus({Key? key, required this.order, required this.orderBloc})
      : super(key: key);

  @override
  _OrderStatusState createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  Future<bool> openBilling() async {
    return (await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
              title: new Text('Billing details',
                  style: TextStyle(
                      height: Fins.textHeight,
                      fontSize: Fins.textSize,
                      color: Fins.textColor,
                      fontWeight: FontWeight.bold)),
              content: Container(
                // height: 230,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Item total ",
                            style: TextStyle(fontSize: 12.0),
                          ),
                          Expanded(
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                      widget.order.totalItems.toString(),
                                      style: TextStyle(
                                          height: Fins.textHeight,
                                          fontSize: Fins.textSmallSize,
                                          color: Fins.textColor))))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Taxes & Charges",
                            style: TextStyle(
                                height: Fins.textHeight,
                                fontSize: Fins.textSmallSize,
                                color: Fins.textColor),
                          ),
                          Expanded(
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                      (widget.order.deliveryCharges +
                                              widget.order.packingCharge)
                                          .toString(),
                                      style: TextStyle(
                                          height: Fins.textHeight,
                                          fontSize: Fins.textSmallSize,
                                          color: Fins.textColor))))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Text("Discount",
                              style: TextStyle(
                                  height: Fins.textHeight,
                                  fontSize: Fins.textSmallSize,
                                  color: Fins.textColor)),
                          Expanded(
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(widget.order.discount.toString(),
                                      style: TextStyle(
                                          height: Fins.textHeight,
                                          fontSize: Fins.textSmallSize,
                                          color: Fins.textColor))))
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Text("Amount paid",
                              style: TextStyle(
                                  height: Fins.textHeight,
                                  fontSize: Fins.textSmallSize,
                                  color: Fins.textColor)),
                          Expanded(
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                      widget.order.amountPaid.toString(),
                                      style: TextStyle(
                                          height: Fins.textHeight,
                                          fontSize: Fins.textSmallSize,
                                          color: Fins.textColor))))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
          height: 40.0,
          width: 120.0,
          child: FittedBox(
            child: FloatingActionButton.extended(
              elevation: 2.0,

              onPressed: () {
                openBilling();
                // Add your onPressed code here!
              },
              label: Text('Show Bill'.toUpperCase(),
                  style: TextStyle(
                      height: Fins.textHeight,
                      fontSize: Fins.textSize,
                      color: Colors.white)),
              // icon: Icon(Icons.arrow_downward,color: Colors.white),
              backgroundColor: Fins.finsColor,
            ),
          )),
      appBar: AppBar(
        title: Text("Back to my orders"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Fins.commonPadding),
        child: Column(
          children: [
            (widget.order.statusId == 1)
                ? Lottie.asset("images/foodcoocking.json",
                    fit: BoxFit.contain, height: 200, width: 200)
                : (widget.order.statusId == 2)
                    ? Lottie.asset("images/delivery.json",
                        fit: BoxFit.contain, height: 200, width: 200)
                    : (widget.order.statusId == 4)
                        ? Lottie.asset("images/completdelivery.json",
                            fit: BoxFit.contain, height: 200, width: 200)
                        : Lottie.asset("images/cancelled.json",
                            fit: BoxFit.contain, height: 200, width: 200),
            // SizedBox(height: Fins.sizedBoxHeight,),
            // Text("Preparing...",style:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,color: Colors.orange,fontWeight: FontWeight.bold)),
            (widget.order.statusId == 1)
                ? Text("Preparing...",
                    style: TextStyle(
                        height: Fins.textHeight,
                        fontSize: Fins.textSize,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold))
                : (widget.order.statusId == 2)
                    ? Text("Out For Delivery...",
                        style: TextStyle(
                            height: Fins.textHeight,
                            fontSize: Fins.textSize,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold))
                    : (widget.order.statusId == 4)
                        ? Text("Delivered",
                            style: TextStyle(
                                height: Fins.textHeight,
                                fontSize: Fins.textSize,
                                color: Colors.green,
                                fontWeight: FontWeight.bold))
                        : Text("Cancelled",
                            style: TextStyle(
                                height: Fins.textHeight,
                                fontSize: Fins.textSize,
                                color: Fins.finsColor,
                                fontWeight: FontWeight.bold)),
            SizedBox(
              height: Fins.sizedBoxHeight,
            ),

            Material(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Fins.buttonRadius)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //  Expanded(
                    //    flex:33,
                    //    child: Image.asset("images/user.png",fit: BoxFit.contain,height: 50,width: 75,)
                    //  ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.order.storeName,
                            style: TextStyle(
                                height: Fins.textHeight,
                                fontSize: Fins.textSize,
                                color: Fins.textColor,
                                fontWeight: FontWeight.bold)),
                        //  Text(widget.order.storePlace,style:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,color: Fins.textColor))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        (widget.order.totalItems <= 1)
                            ? Text(widget.order.totalItems.toString() + "Item",
                                style: TextStyle(
                                    height: Fins.textHeight,
                                    fontSize: Fins.textSize,
                                    color: Fins.textColor))
                            : Text(widget.order.totalItems.toString() + "Items",
                                style: TextStyle(
                                    height: Fins.textHeight,
                                    fontSize: Fins.textSize,
                                    color: Fins.textColor)),
                        Text("₹" + widget.order.price.toString(),
                            style: TextStyle(
                                height: Fins.textHeight,
                                fontSize: Fins.textSize,
                                color: Fins.textColor,
                                fontWeight: FontWeight.bold))
                      ],
                    )
                  ],
                ),
              ),
            ),

            SizedBox(
              height: Fins.sizedBoxHeight,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.order.orderedItems.length,
                  physics: AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, i) {
                    // print(widget.order);
                    // return Container();
                    return OrderDetails(
                        order: widget.order.orderedItems[i],
                        orderBloc: widget.orderBloc);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
