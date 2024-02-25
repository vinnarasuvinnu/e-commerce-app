import 'package:cached_network_image/cached_network_image.dart';
import 'package:fins_user/Bloc/Account/myAccountBloc.dart';
import 'package:fins_user/Bloc/Account/myAccountEvent.dart';
import 'package:fins_user/Models/Profile.dart';
import 'package:fins_user/Pages/Account/password_Change_OTP.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/material.dart';

class EditAccount extends StatefulWidget {
  final MyAccountBloc myAcountBloc;
  final Profile profile;
  const EditAccount({ Key? key,required this.myAcountBloc,required this.profile }) : super(key: key);

  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
   var _radio="Male";
   final nameController=TextEditingController();
   final mailController=TextEditingController();
   @override
   void initState() { 
     super.initState();
     nameController.text=widget.profile.name;
     mailController.text=widget.profile.mail;
   }

   void confirm(){
    showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(title: Align(
        alignment:Alignment.center,
        child: Center(child: Text("Updated...!",style:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,color: Fins.textColor),textAlign: TextAlign.center,))));}
      );
      Future.delayed(Duration(seconds: 2),(){

Navigator.pop(context);
Navigator.pop(context);

      });
      }  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Text("Edit Account"),),
      body: SingleChildScrollView(child: 
      Padding(
        padding: const EdgeInsets.all(Fins.commonPadding),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             SizedBox(height: Fins.sizedBoxHeight,),
//               Center(
//                 child:      CachedNetworkImage(
//   imageUrl: 'https://media.istockphoto.com/photos/the-african-king-picture-id492611032',
//   imageBuilder: (context, imageProvider) => Container(
//     width: 150.0,
//     height: 150.0,
//     decoration: BoxDecoration(
//       shape: BoxShape.circle,
//       image: DecorationImage(
//         image: imageProvider, fit: BoxFit.cover),
//     ),
//   ),
//   placeholder: (context, url) => CircularProgressIndicator(),
//   errorWidget: (context, url, error) => Icon(Icons.error),
// ),
//               ),
              //  SizedBox(height: Fins.sizedBoxHeight,),
          //        Row(
          //    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //    children: [
          //    Row(
          //      children: [
          //        Radio(
          //          activeColor:Fins.finsColor,
          //          value: "Male", groupValue:_radio, onChanged: (val){
          //            setState((){
          //              _radio= val.toString();


          //            });
                    
          //          }),
          //        Text("Male",style:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,color: Fins.textColor))
          //      ],
          //    ),

          //     Row(
          //      children: [
          //        Radio(
          //           activeColor:Fins.finsColor,
          //          value: "Female", groupValue:_radio, onChanged: (val){
          //            setState((){
          //              _radio=val.toString();


          //            });
                    
          //          }),
          //        Text("Female",style:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,color: Fins.textColor))
          //      ],
          //    )
          //  ],),
           SizedBox(height: Fins.sizedBoxHeight,),
  SizedBox(
            height: 50,
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
              
              hintText: "Name",
              hintStyle:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,),
                contentPadding: EdgeInsets.all(8),
              border: OutlineInputBorder()),),
          ),
                   SizedBox(height: Fins.sizedBoxHeight,),
  SizedBox(
            height: 50,
            child: TextField(
              controller: mailController,
              decoration: InputDecoration(
              hintText: "Email ID",
              hintStyle: TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,),
                contentPadding: EdgeInsets.all(8),
              border: OutlineInputBorder()),),
          ),
           SizedBox(height: Fins.sizedBoxHeight,),
            //  SizedBox(
            //     height: 40,
            //     width: double.infinity,
            //     child: ElevatedButton(
            //       style:ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Fins.finsColor)),
            //       onPressed: (){
            //        Navigator.of(context).pushReplacementNamed("/passwordotp");
            //       }, child: Text("Change Password",style:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,))),
            //   ),
            //     SizedBox(height: Fins.sizedBoxHeight,),
             SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  style:ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Fins.finsColor)),
                  onPressed: (){
                    // confirm();
                  widget.myAcountBloc.add(UpdateAccount(username:nameController.text, email: mailController.text));
                  Future.delayed(Duration(seconds: 2),(){
                    Navigator.pop(context);
                  });
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
                  }, child: Text("Update",style:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,))),
              ),

          ],),
      ),),
    );
  }
}