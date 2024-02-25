
import 'package:fins_user/Bloc/OrderBloc/OrderBloc.dart';
import 'package:fins_user/Models/Order.dart';
import 'package:fins_user/Models/Orderitems.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  final OrderedItems order;
  final OrderBloc orderBloc;
  const OrderDetails({ Key? key ,required this.order,required this.orderBloc}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  // late OrderItems orderItems;
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Column(
        children: [
          Row(
            children: [
              // Image.asset("images/user.png",fit: BoxFit.contain,height: 50,width: 75,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left:15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(bottom:8.0),
                        child: Text(widget.order.productName  ,style:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,color: Fins.textColor)),
                      ),
                      Text(widget.order.quantityTitle,style:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,color: Fins.secondaryTextColor))
                    ],
                  ),
                           
                ),
              ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom:8.0),
                        child: Text(widget.order.quantity.toString()+" item",style:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,color: Fins.textColor)),
                      ),
                      Text(widget.order.price.toString(),style:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,color: Fins.textColor))
                    ],
                  ),
            ],
          ),
          Divider(),
            SizedBox(height: Fins.sizedBoxHeight,),
        ],
      ),
      

    );
  }
}