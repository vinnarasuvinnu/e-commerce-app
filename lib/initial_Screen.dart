import 'package:fins_user/Bloc/HomeBloc/home_event.dart';
import 'package:fins_user/Pages/Account/account.dart';
import 'package:fins_user/Pages/Offers/OfferPage.dart';
import 'package:fins_user/Pages/Orders/MyOrders.dart';
import 'package:fins_user/Pages/Orders/OrderHistory.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// import 'package:fins_user/fins.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Bloc/HomeBloc/home_bloc.dart';
import 'Bloc/HomeBloc/home_state.dart';
import 'Pages/Home/home_screen.dart';
import 'Pages/Home/shop_offline.dart';
import 'Pages/Home/shop_unAvailable.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  var currentTabIndex = 0;
  late HomeBloc homeBloc;

  @override
  void initState() {
    super.initState();
    homeBloc = HomeBloc(HomeUninitalized());

    tabController = new TabController(
      vsync: this,
      length: 4,
      initialIndex: 0,
    );

    getTokenFirebase();
  }

  getTokenFirebase() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      showPushMessage(
          context: context,
          title: notification!.title.toString(),
          body: notification.body.toString());
    });
  }

  Future<bool> showPushMessage(
      {required BuildContext context,
      required String? title,
      required String? body}) async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(
              title.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("images/fins.png", height: 100),
                  Text(body.toString()),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Ok',
                  style: TextStyle(color: Fins.finsColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
            ],
          ),
        )) ??
        false;
  }

  var tabValue = 0;

  Future<bool> _exitApp() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(
              'Are you sure?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: new Text('You want to exit an App'),
            actions: <Widget>[
              new TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text(
                  'No',
                  style: TextStyle(
                      color: Fins.finsColor, fontWeight: FontWeight.bold),
                ),
              ),
              new TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: new Text(
                  'Yes',
                  style: TextStyle(
                      color: Fins.finsColor, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  onReturn() {
    tabController.animateTo(0);
    // Toast.show("hello", context,
    //     duration: Toast.lengthLong, gravity: Toast.bottom);

    setState(() {
      // currentTabIndex = 0;
      tabValue = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return (tabValue != 0) ? onReturn() : _exitApp();
      },
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: TabBarView(
            controller: tabController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              HomePage(),
              OfferPage(),
              MyOrders(),
              Account()
            ],
          ),
          bottomNavigationBar: SizedBox(
            height: 60,
            child: Material(
              elevation: 10,
              child: TabBar(
                controller: tabController,
                labelStyle: TextStyle(fontSize: 10),
                indicatorColor: Fins.finsColor,
                labelColor: Fins.finsColor,
                unselectedLabelColor: Fins.secondaryTextColor,
                onTap: (index) {
                  // print(index);
                  setState(() {
                    tabValue = index;
                  });
                },
                tabs: [
                  Tab(
                      iconMargin: EdgeInsets.all(5),
                      text: "Home",
                      icon: tabValue == 0
                          ? Image.asset(
                              "images/home.png",
                              height: 25,
                              color: Fins.finsColor,
                              width: 25,
                            )
                          : Image.asset(
                              "images/home.png",
                              height: 25,
                              width: 25,
                            )),
                  Tab(
                      iconMargin: EdgeInsets.all(5),
                      text: "Offers",
                      icon: tabValue == 1
                          ? Image.asset(
                              "images/offer.png",
                              height: 25,
                              color: Fins.finsColor,
                              width: 25,
                            )
                          : Image.asset(
                              "images/offer.png",
                              height: 25,
                              width: 25,
                            )),
                  Tab(
                      iconMargin: EdgeInsets.all(5),
                      text: "Orders",
                      icon: tabValue == 2
                          ? Image.asset(
                              "images/orders.png",
                              height: 25,
                              color: Fins.finsColor,
                              width: 25,
                            )
                          : Image.asset(
                              "images/orders.png",
                              height: 25,
                              width: 25,
                            )),
                  Tab(
                      iconMargin: EdgeInsets.all(5),
                      text: "Account",
                      icon: tabValue == 3
                          ? Image.asset(
                              "images/user.png",
                              height: 25,
                              width: 25,
                              color: Fins.finsColor,
                            )
                          : Image.asset(
                              "images/user.png",
                              height: 25,
                              width: 25,
                            )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
