import 'package:flutter/material.dart';

import 'finsStandard.dart';

class UploadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("images/upload.png",height: 300,width: 300,fit: BoxFit.contain,),


            Text("Processing",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),

            Align(alignment: Alignment.center,child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Do not press back button or close app \n untill we complete your process.',style: TextStyle(color: Colors.black54,fontSize: 14.0),textAlign: TextAlign.center,),
            )),

            SizedBox(height: 20,),
            CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Fins.finsColor),),
          ],
        ),
      ),
    );
  }
}