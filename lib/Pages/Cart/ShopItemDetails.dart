import 'package:fins_user/Bloc/CartBloc/Cart_State.dart';
import 'package:fins_user/Models/cartProduct.dart';
import 'package:fins_user/Models/cartStore.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/material.dart';

class ShopItem extends StatefulWidget {
  final CartStore store;
  const ShopItem({Key? key,required this.store}) : super(key: key);

  @override
  _ShopItemState createState() => _ShopItemState();
}

class _ShopItemState extends State<ShopItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            //  Expanded(
            //    flex:33,
            //    child: Image.asset("images/user.png",fit: BoxFit.contain,height: 50,width: 75,)
            //  ),
            Expanded(
              flex: 33,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(widget.store.name,
                      style: TextStyle(
                          height: Fins.textHeight,
                          fontSize: Fins.textSize,
                          color: Fins.textColor,
                          fontWeight: FontWeight.bold)),
                  Text(widget.store.city,
                      style: TextStyle(
                          height: Fins.textHeight,
                          fontSize: Fins.textSize,
                          color: Fins.textColor))
                ],
              ),
            ),
            Expanded(
              flex: 33,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                         (widget.store.orders==1) ? Text(widget.store.orders.toString()+" item",  style: TextStyle(
                          height: Fins.textHeight,
                          fontSize: Fins.textSize,
                          color: Fins.textColor),) : Text(widget.store.orders.toString()+" items",  style: TextStyle(
                          height: Fins.textHeight,
                          fontSize: Fins.textSize,
                          color: Fins.textColor)),
                
                  Text(widget.store.price.toString(),
                      style: TextStyle(
                          height: Fins.textHeight,
                          fontSize: Fins.textSize,
                          color: Fins.textColor,
                          fontWeight: FontWeight.bold))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
