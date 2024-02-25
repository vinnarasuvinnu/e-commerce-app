import 'package:fins_user/initial_Screen.dart';
import 'package:flutter/material.dart';

import 'finsStandard.dart';

class NetworkError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 100,),

              Align(alignment: Alignment.center,child:Image.asset("images/networkError.png",height: 200.0,width: 200.0,fit: BoxFit.contain,),
              ),
              Text("Connection error",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),

              Align(alignment: Alignment.center,child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Please check your network connectivity \n and try again.',style: TextStyle(color: Colors.black54,fontSize: 14.0),textAlign: TextAlign.center,),
              )),
              SizedBox(height: 10,),

              ButtonTheme(
                height: 40,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Fins.finsColor)),

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Retry".toUpperCase(),style: TextStyle(color: Colors.white,fontSize: 14.0,fontWeight: FontWeight.bold),),
                  ),
                  onPressed: (){
                    Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => InitialScreen()));

                    // MyNavigator.goToStoreScreen(context);

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