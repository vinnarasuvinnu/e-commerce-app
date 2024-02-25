import 'package:fins_user/Pages/Account/Login.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({ Key? key }) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _radio="Male";
 bool _obscur =true;
   void confirm(){
    showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(title: Align(
        alignment:Alignment.center,
        child: Center(child: Text("Register Sucessfully...!",style:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,color: Fins.textColor),textAlign: TextAlign.center,))));}
      );
      Future.delayed(Duration(seconds: 2),(){
Navigator.pop(context);
Navigator.pop(context);
      });
      }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Text("Register"),),
       body: SingleChildScrollView(child: 
       Padding(
         padding: const EdgeInsets.all(Fins.commonPadding),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
Center(child: Image.asset("images/fins.png")),
            SizedBox(height:Fins.sizedBoxHeight,),

 SizedBox(
            height: 50,
            child: TextField(decoration: InputDecoration(
              hintText: "User Name",
              hintStyle:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,),
              contentPadding: EdgeInsets.all(8),
              border: OutlineInputBorder()),),
          ),
            SizedBox(height:Fins.sizedBoxHeight,),
            SizedBox(
            height: 50,
            child: TextField(decoration: InputDecoration(
              hintText: "Email ID",
              hintStyle: TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,),
                contentPadding: EdgeInsets.all(8),
              border: OutlineInputBorder()),),
          ),
            SizedBox(height:Fins.sizedBoxHeight,),
            SizedBox(
            height: 50,
            child: TextField(
              obscureText: _obscur,
              decoration: InputDecoration(
              hintText: "Password",
              hintStyle: TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,),
                suffixIcon: InkWell(
                  onTap: (){
                    setState(() {
                      if(_obscur ==true){
                        
                         
                        _obscur=false;
                    }else{
                      _obscur=true;
                    }
                    });

                  },
                  child: Icon(Icons.remove_red_eye)),
                contentPadding: EdgeInsets.all(8),
              border: OutlineInputBorder()),),
          ),
            SizedBox(height:Fins.sizedBoxHeight,),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
             Row(
               children: [
                 Radio(
                   activeColor:Fins.finsColor,
                   value: "Male", groupValue:_radio, onChanged: (value){
                     setState(() {
                       _radio=value.toString();
                     });
                   }),
                 Text("Male",style:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,color: Fins.textColor))
               ],
             ),

              Row(
               children: [
                 Radio(
                    activeColor:Fins.finsColor,
                   value: "Female", groupValue:_radio, onChanged: (value){
    setState(() {
                       _radio=value.toString();
                     });
                   }),
                 Text("Female",style:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,color: Fins.textColor))
               ],
             )
           ],),
  SizedBox(height:Fins.sizedBoxHeight,),            SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  style:ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Fins.finsColor)),
                  onPressed: (){
                    confirm();
                  }, child: Text("Register",style:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize))),
              ),
                SizedBox(height:Fins.sizedBoxHeight,),
            SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  style:ButtonStyle(
                    side: MaterialStateProperty.all<BorderSide>(
                      BorderSide(color:Fins.finsColor)
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
                  onPressed: (){
                      //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                      Navigator.pop(context);
                  }, child: Text("Login",style:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,color: Fins.finsColor))),
              ),
                SizedBox(height:Fins.sizedBoxHeight,),
              Text("Login here, if you an already have an account?",style:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,color: Fins.textColor))


         ],),
       ),),
      
    );
  }
}