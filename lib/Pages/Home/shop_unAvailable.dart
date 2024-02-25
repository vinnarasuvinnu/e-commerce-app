import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../initial_Screen.dart';

class ShopUnAvailable extends StatefulWidget {
  const ShopUnAvailable({Key? key}) : super(key: key);

  @override
  _ShopUnAvailableState createState() => _ShopUnAvailableState();
}

class _ShopUnAvailableState extends State<ShopUnAvailable> {
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

              Align(
                alignment: Alignment.center,
                child:Lottie.asset("images/location.json",height: 150,width: 150,fit: BoxFit.contain,),
              ),
              Text("Shop not available at your location yet",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),



            ],
          ),
        ),
      ),
    );
  }
}
