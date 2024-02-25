import 'package:fins_user/initial_Screen.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderComplet extends StatefulWidget {
  const OrderComplet({ Key? key }) : super(key: key);

  @override
  _OrderCompletState createState() => _OrderCompletState();
}

class _OrderCompletState extends State<OrderComplet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
                    
                        // backgroundColor: Colors.white,
                        body: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: Fins.sizedBoxHeight,
                              ),
                              SizedBox(
                                height: Fins.sizedBoxHeight,
                              ),
                              SizedBox(
                                height: Fins.sizedBoxHeight,
                              ),
                              Text("Congrats...!",
                                  style: TextStyle(
                                      height: Fins.textHeight,
                                      fontSize: Fins.titleSize,
                                      // color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: Fins.sizedBoxHeight,
                              ),
                              Text("Your order has been placed.",
                                  style: TextStyle(
                                      height: Fins.textHeight,
                                      fontSize: Fins.titleSize,
                                      )),
                                        SizedBox(
                                height: Fins.sizedBoxHeight,
                              ),
                                SizedBox(
                                height: Fins.sizedBoxHeight,
                              ),
                                      SizedBox(
                                        height:200,
                                        width:200,
                                        child: Lottie.asset("images/complet.json",fit:BoxFit.contain)),
                              Expanded(
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 50.0),
                                      child: Text(
                                          "Your order will be delivered at your dorestep on the selected address.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              height: Fins.textHeight,
                                              fontSize: Fins.titleSize,
                                              )),
                                    )),
                              ),
                                  
                            ],
                          ),
                        ),
                        bottomNavigationBar: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(0))),
                                side: MaterialStateProperty.all<BorderSide>(
                                    BorderSide(color: Fins.finsColor)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Fins.finsColor)),
                            onPressed: () {
                              //  Navigator.push(context, MaterialPageRoute(builder: (context)=>InitialScreen()));
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          InitialScreen()));
                            },
                            child: Text("Buy More...",
                                style: TextStyle(
                                    height: Fins.textHeight,
                                    fontSize: Fins.titleSize,
                                    color: Colors.white)),
                          ),
                        ),
                      );
  }
}