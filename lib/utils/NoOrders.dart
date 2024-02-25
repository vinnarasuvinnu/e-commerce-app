import 'package:fins_user/Pages/Home/home_screen.dart';
import 'package:fins_user/initial_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'finsStandard.dart';

class NoOrders extends StatelessWidget {
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
                child:Image.asset("images/noOrders.png",height: 300,width: 300,fit: BoxFit.contain,),
              ),
              Text("Place your first order",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),

              Align(alignment: Alignment.center,child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Start adding your favourite products now.',style: TextStyle(color: Colors.black54,fontSize: 14.0),textAlign: TextAlign.center,),
              )),
              SizedBox(height: 10,),

              ButtonTheme(
                height: 40.0,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Fins.finsColor)),

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Browse stores".toUpperCase(),style: TextStyle(color: Colors.white,fontSize: 14.0,fontWeight: FontWeight.bold),),
                  ),
                  onPressed: (){

                    // MyNavigator.goToStoreScreen(context);
                     Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => InitialScreen()));

                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
