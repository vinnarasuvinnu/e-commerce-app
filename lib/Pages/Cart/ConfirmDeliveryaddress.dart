import 'package:fins_user/Bloc/DeliveryBloc/Delivery_Bloc.dart';
import 'package:fins_user/Bloc/DeliveryBloc/Delivery_Event.dart';
import 'package:fins_user/Bloc/DeliveryBloc/Delivery_State.dart';
import 'package:fins_user/Models/cartStore.dart';
import 'package:fins_user/utils/NetWordError.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../LoadingListPage.dart';

class ConfirmDeliveryAddress extends StatefulWidget {
  // final CartStore store;
  final String deliveryAddress;
  final bool openChooseModal;
  const ConfirmDeliveryAddress({ Key? key,required this.deliveryAddress,required this.openChooseModal}) : super(key: key);

  @override
  _ConfirmDeliveryAddressState createState() => _ConfirmDeliveryAddressState();
}

class _ConfirmDeliveryAddressState extends State<ConfirmDeliveryAddress> {
 late DeliveryBloc _deliveryBloc;
 String selectedDeliveryLocation="";
  late String landMarkandflatAddress;
  int addressType=3;
 final _formKey=GlobalKey<FormState>();

 TextEditingController homeNumberController=new TextEditingController();
  TextEditingController landMarkController=new TextEditingController();
  TextEditingController homeNumberEditController=new TextEditingController();
  TextEditingController landMarkEditController=new TextEditingController();
  @override
  void initState() { 
    super.initState();
    _deliveryBloc=DeliveryBloc(DeliveryUninitialized());
   if(widget.openChooseModal){
      retrieveSavedAddress();
    }
    else{
      retrieveData();

    }
  }

  retrieveData()async{
    _deliveryBloc.add(FetchDeliveryAddress(deliveryAddress: widget.deliveryAddress));
      updateHomeAndLandMark();

  }
  retrieveDataAfter()async{
    Navigator.of(context).pop();

  }

  retrieveSavedAddress()async{
   _deliveryBloc.add(FetchSavedDeliveryAddress());
  }
   final _scaffoldKey = GlobalKey<ScaffoldState>();
  void updateHomeAndLandMark()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();

    setState(() {

      selectedDeliveryLocation=sharedPreferences.getString("delivery_address");
      homeNumberController.text=sharedPreferences.getString("home_no");
      landMarkController.text=sharedPreferences.getString("land_mark");

    });

  }
  void saveAddressStatus(BuildContext context)async{
    if(await Fins.getAddressCount() == "success"){
      updateUserAddress();

    }
    else{
      Fluttertoast.showToast(
          msg: 'You can have maximum 10 addresses, please do edit or delete some address to add new address.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff323232),
          textColor: Colors.white,
          fontSize: 16.0
      );






    }

  }
   void updateUserAddress()async{

    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();


    landMarkandflatAddress=homeNumberController.text+", "+landMarkController.text;
    var latitude=sharedPreferences.getString("delivery_latitude");
    var longitude=sharedPreferences.getString("delivery_longitude");
    var deliveryAddress=sharedPreferences.getString("delivery_address");
    _deliveryBloc.add(SaveAddress(flatNumber: homeNumberController.text,landMark: landMarkController.text,latitude: latitude,longitude: longitude,mapAddress: deliveryAddress,addressType: addressType.toString()));




    await Fins.setDeliverFlatLocation(homeNumberController.text, landMarkController.text);

    Navigator.pop(context);

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: BlocProvider<DeliveryBloc>(
        create: (BuildContext context ){
          return _deliveryBloc;
        },
        child: BlocBuilder<DeliveryBloc, DeliveryState>(
          builder: (context, state){
                if(state is DeliveryUninitialized){
              return LoadingListPage();
            }

            if (state is DeliveryError) {
              return NetworkError();
            }
              if(state is DeliveryAddressLoaded){
                return  Scaffold(
                  body: SingleChildScrollView(
                    child: Padding(
                          padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom),
                            child: Container(
                             //  height:300,
                                decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                       topLeft: Radius.circular(20),
                       topRight: Radius.circular(20.0)),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                    Padding(
                        padding: const EdgeInsets.all(Fins.commonPadding),
                        child: Column(children: [
                                Row(
                                children: [
                                  Expanded(child: Text("Delivery address",style:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,color: Fins.textColor,fontWeight: FontWeight.bold))),
                               //   ElevatedButton(
                               //     style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Fins.finsColor)),
                               //     onPressed: (){}, child: Text("Change address",style:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize)))
                                ],
                              ),
                              
                               SizedBox(height: Fins.sizedBoxHeight,),
                              
                              Text(selectedDeliveryLocation        ,style:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,color: Fins.textColor)),
                                SizedBox(height: Fins.sizedBoxHeight,),
                                Form(
                                  key:_formKey,
                                  child: Column(children: [
                                     TextFormField(decoration: InputDecoration(
                                    labelText:"House no / Block / Flat",
                                    labelStyle:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize)
                                  ),
                                  onChanged: (text)async{
                                    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                                    sharedPreferences.setString("home_no", homeNumberController.text);
                                
                                
                                  },
                                     validator: (value) {
                                  if (homeNumberController.text=="" && homeNumberController.text==null) {
                                    return 'provide House no / Block / Flat';
                                  }
                                  return null;
                                                              },
                                                              controller: homeNumberController,
                                  ),
                                    SizedBox(height: Fins.sizedBoxHeight,),
                                  TextFormField(decoration: InputDecoration(  
                                    labelText:"Landmark",
                                    labelStyle:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize)
                                  ),
                                   onChanged: (text)async{
                                    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                                    sharedPreferences.setString("land_mark", landMarkController.text);
                                
                                
                                  },
                                  validator: (value) {
                                  if (landMarkController.text==""&& landMarkController.text== null) {
                                    return 'provide valid landmark';
                                  }
                                  return null;
                                                              },
                                                              controller: landMarkController,),
                                
                                  ],),
                                ),
                             
                                 
                                
                        
                        ],),
                      ),
                    
                                ],
                              )
                            ),
                          ),
                  ),
                  bottomNavigationBar:   SizedBox(
                    height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(Fins.finsColor) ),
                          onPressed: (){
                    if(homeNumberController.text=="" && landMarkController.text==""){
                        Fluttertoast.showToast(
                              msg:
                                  "Please add house number and landmark...",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey,
                              textColor: Colors.white,
                              fontSize: 16.0);
                    }else{

Navigator.pop(context);
                    }
                         
                          

                       
                          }, child:Text(("SAVE"))),
                      ),
                );
              }
              return Container();

          
          

      
          },
          
        ),
      ),
    );
  }
}
