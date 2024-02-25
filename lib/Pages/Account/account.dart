import 'dart:io';

import 'package:fins_user/Bloc/Account/myAccountBloc.dart';
import 'package:fins_user/Bloc/Account/myAccountEvent.dart';
import 'package:fins_user/Bloc/Account/myAccountState.dart';
import 'package:fins_user/Pages/Account/Contact-Us.dart';
import 'package:fins_user/Pages/Orders/MyOrders.dart';
import 'package:fins_user/Pages/Orders/OrderHistory.dart';
import 'package:fins_user/Pages/WebView/privacy_policy.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import 'Login.dart';
import 'MyAccount.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  late MyAccountBloc _myAccountBloc;

  void initState() {
    // TODO: implement initState
    super.initState();
    _myAccountBloc = MyAccountBloc(MyAccountStateUninitialized());
    retrieveData();
  }

  void retrieveData() {
    _myAccountBloc.add(FetchSettingsInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: Fins.titleTextPadding),
          child: Text("Account",style: TextStyle(color: Colors.black),),
        ),
      ),
      body: BlocListener(
        cubit: _myAccountBloc,
        listener: (BuildContext context, MyAccountState state) {
          if (state is LogoutState) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Login()));
          }
        },
        child: BlocProvider<MyAccountBloc>(
          create: (BuildContext context) {
            return _myAccountBloc;
          },
          child: BlocBuilder<MyAccountBloc, MyAccountState>(
              builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(Fins.commonPadding),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyAccount()));
                          },
                          child: ListTile(
                            leading: Icon(Icons.account_circle,
                                color: Fins.finsColor, size: Fins.iconSize),
                            title: Text(
                              "My Profile",
                              style: TextStyle(
                                  height: Fins.textHeight,
                                  fontSize: Fins.textSize,
                                  color: Fins.textColor),
                            ),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.push(context,
                        //         MaterialPageRoute(builder: (context) => Login()));
                        //   },
                        //   child: ListTile(
                        //     leading: Icon(Icons.login_outlined,
                        //         color: Fins.finsColor, size: Fins.iconSize),
                        //     title: Padding(
                        //       padding: const EdgeInsets.only(
                        //           bottom: Fins.accountTextPadding),
                        //       child: Text("Login",
                        //           style: TextStyle(
                        //               height: Fins.textHeight,
                        //               fontSize: Fins.textSize,
                        //               color: Fins.textColor)),
                        //     ),
                        //     trailing: Icon(Icons.keyboard_arrow_right),
                        //   ),
                        // ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyOrders()));
                          },
                          child: ListTile(
                            leading: Icon(Icons.shopping_bag_outlined,
                                color: Fins.finsColor, size: Fins.iconSize),
                            title: Text("My Orders",
                                style: TextStyle(
                                    height: Fins.textHeight,
                                    fontSize: Fins.textSize,
                                    color: Fins.textColor)),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            Share.share(
                                'Hey! check out this app to get meat at your doorstep.\nDownload the app to explore \n' +
                                    Fins.shareUrl);
                            // if (Platform.isAndroid) {
                            //   final ByteData bytes =
                            //       await rootBundle.load('images/logoShare.png');
                            //   await Share.file('Fins & Slice', 'logoShare.png',
                            //       bytes.buffer.asUint8List(), 'image/jpg',
                            //       text:
                            //           'Hey! check out this app to get meat at your doorstep.\nDownload the app to explore \n' +
                            //               Fins.shareUrl);
                            // }
                          },
                          child: ListTile(
                            leading: Icon(Icons.share_outlined,
                                color: Fins.finsColor, size: Fins.iconSize),
                            title: Text("Refer a Friend",
                                style: TextStyle(
                                    height: Fins.textHeight,
                                    fontSize: Fins.textSize,
                                    color: Fins.textColor)),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ContactUs()));
                          },
                          child: ListTile(
                            leading: Icon(Icons.contact_support,
                                color: Fins.finsColor, size: Fins.iconSize),
                            title: Text("Contact Us",
                                style: TextStyle(
                                    height: Fins.textHeight,
                                    fontSize: Fins.textSize,
                                    color: Fins.textColor)),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                        ),

                        // SizedBox(height:40),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: Fins.dividerHeight,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(Fins.commonPadding),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PrivacyPolicy()));
                          },
                          child: ListTile(
                            leading: Icon(Icons.policy_outlined,
                                color: Fins.finsColor, size: Fins.iconSize),
                            title: Text("Privacy Policy",
                                style: TextStyle(
                                    height: Fins.textHeight,
                                    fontSize: Fins.textSize,
                                    color: Fins.textColor)),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                        ),
                        // InkWell(
                        //   onTap: (){
                        //     Navigator.push(context, MaterialPageRoute(builder: (context)=>Terms()));
                        //   },
                        //   child: ListTile(
                        //     leading: Icon(Icons.rule_outlined,
                        //         color: Fins.finsColor, size: Fins.iconSize),
                        //     title: Padding(
                        //       padding: const EdgeInsets.only(
                        //           bottom: Fins.accountTextPadding),
                        //       child: Text("Terms & Conditions",
                        //           style: TextStyle(
                        //               height: Fins.textHeight,
                        //               fontSize: Fins.textSize,
                        //               color: Fins.textColor)),
                        //     ),
                        //     trailing: Icon(Icons.keyboard_arrow_right),
                        //   ),
                        // ),
                        // InkWell(
                        //   onTap: (){
                        //     Navigator.push(context, MaterialPageRoute(builder: (context)=>Faq()));
                        //   },
                        //   child: ListTile(
                        //     leading: Icon(Icons.feedback_outlined,
                        //         color: Fins.finsColor, size: Fins.iconSize),
                        //     title: Padding(
                        //       padding: const EdgeInsets.only(
                        //           bottom: Fins.accountTextPadding),
                        //       child: Text("FAQ",
                        //           style: TextStyle(
                        //               height: Fins.textHeight,
                        //               fontSize: Fins.textSize,
                        //               color: Fins.textColor)),
                        //     ),
                        //     trailing: Icon(Icons.keyboard_arrow_right),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: Fins.dividerHeight,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(Fins.commonPadding),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            _myAccountBloc.add(LogoutUser());
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.logout_outlined,
                              color: Fins.finsColor,
                              size: Fins.iconSize,
                            ),
                            title: Text("Logout",
                                style: TextStyle(
                                    height: Fins.textHeight,
                                    fontSize: Fins.textSize,
                                    color: Fins.textColor)),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
