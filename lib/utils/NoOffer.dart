
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/material.dart';

import '../initial_Screen.dart';

class NoOffer extends StatefulWidget {
  const NoOffer({ Key? key }) : super(key: key);

  @override
  _NoOfferState createState() => _NoOfferState();
}

class _NoOfferState extends State<NoOffer> {
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
                child:Image.asset("images/noOffer.png",height: 300,width: 300,fit: BoxFit.contain,),
              ),
                SizedBox(height: 10,),
              Text("No Offers Yet..",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),

              // Align(alignment: Alignment.center,child: Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text('Start adding your favourite products now.',style: TextStyle(color: Colors.black54,fontSize: 14.0),textAlign: TextAlign.center,),
              // )),
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