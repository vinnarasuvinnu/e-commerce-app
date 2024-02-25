import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../initial_Screen.dart';

class ShopClosed extends StatefulWidget {
  const ShopClosed({Key? key}) : super(key: key);

  @override
  _ShopClosedState createState() => _ShopClosedState();
}

class _ShopClosedState extends State<ShopClosed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Currently Not Accepting Orders",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),

              Align(
                alignment: Alignment.center,
                child:Lottie.asset("images/shopClosed.json",height: 350,width: 350,fit: BoxFit.contain,),
              ),



            ],
          ),
        ),
      ),
    );
  }
}
