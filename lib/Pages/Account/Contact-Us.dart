import 'package:fins_user/Bloc/Account/myAccountBloc.dart';
import 'package:fins_user/Bloc/Account/myAccountEvent.dart';
import 'package:fins_user/Bloc/Account/myAccountState.dart';
import 'package:fins_user/utils/NetWordError.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:fins_user/utils/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  late String selectedValue;
  final List<DropdownMenuItem> items = [];
  late MyAccountBloc _myAccountBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _myAccountBloc = MyAccountBloc(MyAccountStateUninitialized());
    retrieveData();
  }

  retrieveData() {
    _myAccountBloc.add(FetchContactUs());
  }

  openMail(String mail) async {
    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: mail,
        queryParameters: {'subject': 'Support request'});

    launch(_emailLaunchUri.toString());
  }

  openPhone(String phone) async {
    if (await canLaunch("tel:+91"+phone)) {
      await launch("tel:+91"+phone);
    } else {
      throw 'Could not open the phone.';
    }
  }

  openWhatsapp(String whatsapp) async {
    final link = WhatsAppUnilink(
      phoneNumber: '+91 '+whatsapp,
      text: "Hi! team",
    );

    await launch('$link');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Us"),
      ),
      body: BlocProvider<MyAccountBloc>(
        create: (BuildContext context) {
          return _myAccountBloc;
        },
        child: BlocBuilder<MyAccountBloc, MyAccountState>(
            builder: (context, state) {
          if (state is MyAccountStateUninitialized) {
            return LoadingListPage();
          }

          if(state is MyAccountStateError){
            return NetworkError();
          }

          if (state is ContactUsLoaded) {
            return Container(
              decoration: BoxDecoration(color: Colors.white
                  //    image: DecorationImage(image: AssetImage("images/1.png"),
                  //  fit: BoxFit.cover  )
                  ),
              child: Padding(
                padding: const EdgeInsets.all(Fins.commonPadding),
                child: Column(
                  children: [
                    Expanded(
                      flex: 25,
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        // color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Get in touch our".toUpperCase(),
                                style: TextStyle(
                                    fontSize: Fins.titleSize,
                                    color: Fins.textColor)),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "fins & slice".toUpperCase(),
                                style: TextStyle(
                                    fontSize: 30, color: Fins.finsColor),
                              ),
                            ),
                            SizedBox(
                              height: Fins.sizedBoxHeight,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Divider(),
                    // SizedBox(height: Fins.sizedBoxHeight,),
                    Expanded(
                      flex: 25,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.only(top:8.0),
                              //   child: CircleAvatar(backgroundColor: Colors.white,child: Image.asset("images/email1.png",height: 20,width: 20,fit: BoxFit.contain,)),
                              // ),
                              Icon(
                                Icons.mail_outline,
                              ),
                              SizedBox(
                                width: 2,
                              ),

                              Text(
                                state.mail,
                                style: TextStyle(
                                    height: Fins.textHeight,
                                    fontSize: Fins.textSize,
                                    color: Fins.textColor,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          OutlinedButton(
                            style: ButtonStyle(
                                side: MaterialStateProperty.all<BorderSide>(
                                    BorderSide(color: Fins.finsColor))),
                            child: Text(
                              "Mail now".toUpperCase(),
                              style: TextStyle(
                                  height: Fins.textHeight,
                                  fontSize: Fins.textSize,
                                  color: Fins.finsColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              openMail(state.mail);
                            },
                          ),
                          SizedBox(
                            height: Fins.sizedBoxHeight,
                          ),
                        ],
                      ),
                    ),

                    // Divider(),

                    Expanded(
                      flex: 25,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.only(top:8.0),
                              //   child: CircleAvatar(backgroundColor: Colors.white,child: Image.asset("images/phone.png",height: 30,width: 30,fit: BoxFit.contain,)),
                              // ),
                              Icon(Icons.phone),
                              SizedBox(
                                width: 2,
                              ),

                              Text(
                                '+91 '+state.phone,
                                style: TextStyle(
                                    height: Fins.textHeight,
                                    fontSize: Fins.textSize,
                                    color: Fins.textColor,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          OutlinedButton(
                            style: ButtonStyle(
                                side: MaterialStateProperty.all<BorderSide>(
                                    BorderSide(color: Fins.finsColor))),
                            child: Text("call now".toUpperCase(),
                                style: TextStyle(
                                    height: Fins.textHeight,
                                    fontSize: Fins.textSize,
                                    color: Fins.finsColor,
                                    fontWeight: FontWeight.bold)),
                            onPressed: () {
                              openPhone( state.phone);
                            },
                          ),
                          SizedBox(
                            height: Fins.sizedBoxHeight,
                          ),
                        ],
                      ),
                    ),

                    // Divider(),

                    Expanded(
                      flex: 25,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.only(top:8.0),
                              //   child: CircleAvatar(backgroundColor: Colors.white,child: Image.asset("images/watsapp.png",height: 30,width: 30,fit: BoxFit.contain,)),
                              // ),
                              Icon(Icons.message),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                '+91 '+state.phone,
                                style: TextStyle(
                                    height: Fins.textHeight,
                                    fontSize: Fins.textSize,
                                    color: Fins.textColor,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          OutlinedButton(
                            style: ButtonStyle(
                                side: MaterialStateProperty.all<BorderSide>(
                                    BorderSide(color: Fins.finsColor))),
                            child: Text(
                              "whatsapp now".toUpperCase(),
                              style: TextStyle(
                                  height: Fins.textHeight,
                                  fontSize: Fins.textSize,
                                  color: Fins.finsColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              openWhatsapp(state.phone);
                            },
                          ),
                        ],
                      ),
                    ),

                    // Divider(),
                  ],
                ),
              ),
            );
          }
          return Container();
        }),
      ),
    );
  }
}
























// import 'package:fins_user/Bloc/Account/myAccountBloc.dart';
// import 'package:fins_user/Bloc/Account/myAccountEvent.dart';
// import 'package:fins_user/Bloc/Account/myAccountState.dart';
// import 'package:fins_user/utils/NetWordError.dart';
// import 'package:fins_user/utils/finsStandard.dart';
// import 'package:fins_user/utils/shimmer.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:whatsapp_unilink/whatsapp_unilink.dart';

// class ContactUs extends StatefulWidget {
//   const ContactUs({Key? key}) : super(key: key);

//   @override
//   _ContactUsState createState() => _ContactUsState();
// }

// class _ContactUsState extends State<ContactUs> {
//   late String selectedValue;
//   final List<DropdownMenuItem> items = [];
//   late MyAccountBloc _myAccountBloc;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _myAccountBloc = MyAccountBloc(MyAccountStateUninitialized());
//     retrieveData();
//   }

//   retrieveData() {
//     _myAccountBloc.add(FetchContactUs());
//   }

//   openMail() async {
//     final Uri _emailLaunchUri = Uri(
//         scheme: 'mailto',
//         path: "finsnslice2020@gmail.com",
//         queryParameters: {'subject': 'Support request'});

//     launch(_emailLaunchUri.toString());
//   }

//   openPhone() async {
//     if (await canLaunch("tel:+91 9884903048")) {
//       await launch("tel:+91 9884903048");
//     } else {
//       throw 'Could not open the phone.';
//     }
//   }

//   openWhatsapp() async {
//     final link = WhatsAppUnilink(
//       phoneNumber: '+91 9884903048',
//       text: "Hi! team",
//     );

//     await launch('$link');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Contact Us"),
//       ),
//       body: Container(
//               decoration: BoxDecoration(color: Colors.white
//                   //    image: DecorationImage(image: AssetImage("images/1.png"),
//                   //  fit: BoxFit.cover  )
//                   ),
//               child: Padding(
//                 padding: const EdgeInsets.all(Fins.commonPadding),
//                 child: Column(
//                   children: [
//                     Expanded(
//                       flex: 25,
//                       child: Container(
//                         height: 100,
//                         width: double.infinity,
//                         // color: Colors.white,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text("Get in touch our".toUpperCase(),
//                                 style: TextStyle(
//                                     fontSize: Fins.titleSize,
//                                     color: Fins.textColor)),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 "fins & slice".toUpperCase(),
//                                 style: TextStyle(
//                                     fontSize: 30, color: Fins.finsColor),
//                               ),
//                             ),
//                             SizedBox(
//                               height: Fins.sizedBoxHeight,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     // Divider(),
//                     // SizedBox(height: Fins.sizedBoxHeight,),
//                     Expanded(
//                       flex: 25,
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               // Padding(
//                               //   padding: const EdgeInsets.only(top:8.0),
//                               //   child: CircleAvatar(backgroundColor: Colors.white,child: Image.asset("images/email1.png",height: 20,width: 20,fit: BoxFit.contain,)),
//                               // ),
//                               Icon(
//                                 Icons.mail_outline,
//                               ),
//                               SizedBox(
//                                 width: 2,
//                               ),

//                               Text(
//                                 "Email ID",
//                                 style: TextStyle(
//                                     height: Fins.textHeight,
//                                     fontSize: Fins.textSize,
//                                     color: Fins.textColor,
//                                     fontWeight: FontWeight.bold),
//                               )
//                             ],
//                           ),
//                           OutlinedButton(
//                             style: ButtonStyle(
//                                 side: MaterialStateProperty.all<BorderSide>(
//                                     BorderSide(color: Fins.finsColor))),
//                             child: Text(
//                               "Mail now".toUpperCase(),
//                               style: TextStyle(
//                                   height: Fins.textHeight,
//                                   fontSize: Fins.textSize,
//                                   color: Fins.finsColor,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             onPressed: () {
//                               openMail();
//                             },
//                           ),
//                           SizedBox(
//                             height: Fins.sizedBoxHeight,
//                           ),
//                         ],
//                       ),
//                     ),

//                     // Divider(),

//                     Expanded(
//                       flex: 25,
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               // Padding(
//                               //   padding: const EdgeInsets.only(top:8.0),
//                               //   child: CircleAvatar(backgroundColor: Colors.white,child: Image.asset("images/phone.png",height: 30,width: 30,fit: BoxFit.contain,)),
//                               // ),
//                               Icon(Icons.phone),
//                               SizedBox(
//                                 width: 2,
//                               ),

//                               Text(
//                                 '+91 9884903048',
//                                 style: TextStyle(
//                                     height: Fins.textHeight,
//                                     fontSize: Fins.textSize,
//                                     color: Fins.textColor,
//                                     fontWeight: FontWeight.bold),
//                               )
//                             ],
//                           ),
//                           OutlinedButton(
//                             style: ButtonStyle(
//                                 side: MaterialStateProperty.all<BorderSide>(
//                                     BorderSide(color: Fins.finsColor))),
//                             child: Text("call now".toUpperCase(),
//                                 style: TextStyle(
//                                     height: Fins.textHeight,
//                                     fontSize: Fins.textSize,
//                                     color: Fins.finsColor,
//                                     fontWeight: FontWeight.bold)),
//                             onPressed: () {
//                               openPhone();
//                             },
//                           ),
//                           SizedBox(
//                             height: Fins.sizedBoxHeight,
//                           ),
//                         ],
//                       ),
//                     ),

//                     // Divider(),

//                     Expanded(
//                       flex: 25,
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               // Padding(
//                               //   padding: const EdgeInsets.only(top:8.0),
//                               //   child: CircleAvatar(backgroundColor: Colors.white,child: Image.asset("images/watsapp.png",height: 30,width: 30,fit: BoxFit.contain,)),
//                               // ),
//                               Icon(Icons.message),
//                               SizedBox(
//                                 width: 2,
//                               ),
//                               Text(
//                                 '+91 9884903048',
//                                 style: TextStyle(
//                                     height: Fins.textHeight,
//                                     fontSize: Fins.textSize,
//                                     color: Fins.textColor,
//                                     fontWeight: FontWeight.bold),
//                               )
//                             ],
//                           ),
//                           OutlinedButton(
//                             style: ButtonStyle(
//                                 side: MaterialStateProperty.all<BorderSide>(
//                                     BorderSide(color: Fins.finsColor))),
//                             child: Text(
//                               "whatsapp now".toUpperCase(),
//                               style: TextStyle(
//                                   height: Fins.textHeight,
//                                   fontSize: Fins.textSize,
//                                   color: Fins.finsColor,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             onPressed: () {
//                               openWhatsapp();
//                             },
//                           ),
//                         ],
//                       ),
//                     ),

//                     // Divider(),
//                   ],
//                 ),
//               ),
//             )
//     );
//   }
// }
