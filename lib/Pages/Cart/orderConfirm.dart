import 'package:fins_user/Pages/Home/home_screen.dart';
import 'package:fins_user/initial_Screen.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OrderConfirm extends StatefulWidget {
  const OrderConfirm({ Key? key }) : super(key: key);

  @override
  _OrderConfirmState createState() => _OrderConfirmState();
}

class _OrderConfirmState extends State<OrderConfirm> {
  Future<bool> _exitApp() async {
    return (await Navigator.push(context, MaterialPageRoute(builder: (context)=>InitialScreen()))
   
        ) ??
        false;
  }


  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: _exitApp,
      child: Scaffold(
        backgroundColor: Fins.finsColor,
        appBar: AppBar(
          // backgroundColor: Fins.finsColor,
          
          automaticallyImplyLeading: false,
                  titleSpacing: Fins.titleTextPadding,
      
          title: Text("Back to home"),
          // leading: Container(),
          ),
        body: Container(
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage("images/1.png"),
          fit: BoxFit.cover
          )),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Fins.sizedBoxHeight,),
                  SizedBox(height: Fins.sizedBoxHeight,),
                    SizedBox(height: Fins.sizedBoxHeight,),
                Text("Congrats...!",style:TextStyle(height: Fins.textHeight,fontSize:Fins.titleSize,color: Colors.white,fontWeight: FontWeight.bold)),
                  SizedBox(height: Fins.sizedBoxHeight,),
                  Text("Your order has been placed.",style:TextStyle(height: Fins.textHeight,fontSize:Fins.titleSize,color: Colors.white)) ,
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom:50.0),
                        child: Text("Your order will be delivered at your dorestep on the selected address.",textAlign: TextAlign.center,style:TextStyle(height: Fins.textHeight,fontSize:Fins.titleSize,color: Colors.white)),
                      )),
                  )         ],
            ),
          ),
        ),
      
      bottomNavigationBar: SizedBox(
      height: 50,
      width: double.infinity,
      child:   ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))
        ),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(color: Fins.finsColor)
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
            onPressed: (){
              //  Navigator.push(context, MaterialPageRoute(builder: (context)=>InitialScreen()));
               Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext context) => InitialScreen()));
            },
            child: Text("Buy More...",style:TextStyle(height: Fins.textHeight,fontSize:Fins.titleSize,color: Fins.finsColor)),),
      ),
      ),
    );    
  }
}