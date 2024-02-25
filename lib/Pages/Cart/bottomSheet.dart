import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/material.dart';

class DeliveryBottom extends StatefulWidget {
  final String date;
  const DeliveryBottom({ Key? key, required this.date }) : super(key: key);

  @override
  _DeliveryBottomState createState() => _DeliveryBottomState();
}

class _DeliveryBottomState extends State<DeliveryBottom> {

  bool bottomState=true;
  void getDataAndPop() {
      DeliveryBottom detailsClass = new DeliveryBottom(date: "Done",);
      Navigator.pop(context, detailsClass); //pop happens here
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child:   Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(Fins.commonPadding),
                child: Column(children: [
                        Row(
                        children: [
                          Expanded(child: Text("Delivery address",style:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,color: Fins.textColor,fontWeight: FontWeight.bold))),
                         ElevatedButton(
                           style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Fins.finsColor)),
                           onPressed: (){}, child: Text("Change address",style:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize)))
                        ],
                      ),
    
                       SizedBox(height: Fins.sizedBoxHeight,),
                      
                      Text("19, 6th cross, hosur,tamil nadu,india, 19, 6th cross, hosur,tamil nadu,india",style:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,color: Fins.textColor)),
                        SizedBox(height: Fins.sizedBoxHeight,),
                        TextField(decoration: InputDecoration(
                          labelText:"House no / Block / Flat",
                          labelStyle:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize)
                        ),),
                          SizedBox(height: Fins.sizedBoxHeight,),
                        TextField(decoration: InputDecoration(
                          labelText:"Landmark",
                          labelStyle:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize)
                        ),),
                          SizedBox(height: Fins.sizedBoxHeight,),
                        
                
                ],),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(Fins.finsColor) ),
                  onPressed: (){
                    // Navigator.pop(context,"Hello world");
                     getDataAndPop();


                  }, child:Text(("SAVE"))),
              )
          ],
        ),
      
    );
        
          
    
          
       
  
  }
}