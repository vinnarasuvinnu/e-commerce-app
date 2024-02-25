import 'dart:convert';

import 'package:fins_user/Bloc/DeliveryBloc/Delivery_Bloc.dart';
import 'package:fins_user/Bloc/DeliveryBloc/Delivery_Event.dart';
import 'package:fins_user/Bloc/DeliveryBloc/Delivery_State.dart';
import 'package:fins_user/LoadingListPage.dart';
import 'package:fins_user/Models/cartStore.dart';
import 'package:fins_user/Models/custom_result.dart';
import 'package:fins_user/Pages/Cart/ShopItemDetails.dart';
import 'package:fins_user/Pages/Cart/orderConfirm.dart';
import 'package:fins_user/repository/PaymentRepository.dart';
import 'package:fins_user/repository/StoreRepository.dart';
import 'package:fins_user/utils/NetWordError.dart';
import 'package:fins_user/utils/UploadinScreen.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../initial_Screen.dart';
import 'ConfirmDeliveryaddress.dart';

class Checkout extends StatefulWidget {
// final CartStore store;
  const Checkout({
    Key? key,
  }) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  var confirmAddress = false;

// late  CartStore store;
  StoreRepository _storeRepository = StoreRepository();
  String selectedDeliveryLocation = "";
  late Razorpay _razorpay;

  late DeliveryBloc _deliveryBloc;
  int orderType = 1;

  // late CartStore store;

  @override
  void initState() {
    super.initState();
    _deliveryBloc = DeliveryBloc(DeliveryUninitialized());
    retrieveData();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    setState(() {
      _deliveryBloc.add(PaymentSuccessEvent());
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() {
      _deliveryBloc.add(RazorPayError());
    });
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("external wallet");
  }

  getRazorpayKey({
    required String orderType,
    required int paymentType,
    required String home_no,
    required String landmark,
  }) async {
    final saveOrderResponse = await PaymentRepository().saveOrder(
        orderType: orderType,
        url: Fins.ip + "home/upiOrder/",
        paymentType: paymentType,
        home_no: home_no,
        landmark: landmark);
    CustomResults customResult =
        CustomResults.fromJson(jsonDecode(saveOrderResponse.data));
    return customResult.description;
  }

  checkServiceStatus(int id, BuildContext context) async {
    var distanceResponse = await _storeRepository.checkDistance(
        url: Fins.ip + "home/store/" + id.toString() + "/getServiceStatus/",
        order_id: '');
    CustomResults customResult =
        CustomResults.fromJson(jsonDecode(distanceResponse.data));
    if (customResult.result == "success") {
      setState(() {
        confirmAddress = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            customResult.description.toString(),
            style: TextStyle(color: Colors.white, fontSize: 16.0),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color(0xff323232),
        ),
      );
    }
  }

  retrieveData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    _deliveryBloc.add(LoadDeliveryInfo());
    selectedDeliveryLocation =
        (sharedPreferences.getString("home_no") != null &&
                sharedPreferences.getString("land_mark") != null)
            ? sharedPreferences.getString("home_no") +
                ", " +
                sharedPreferences.getString("land_mark") +
                ", " +
                sharedPreferences.getString("delivery_address")
            : sharedPreferences.getString("delivery_address");
  }

  var selectState = false;

  reRetrieveData() async {
    setState(() {
      selectState = true;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    _deliveryBloc.add(LoadDeliveryInfo());
    selectedDeliveryLocation =
        (sharedPreferences.getString("home_no") != null &&
                sharedPreferences.getString("land_mark") != null)
            ? sharedPreferences.getString("home_no") +
                ", " +
                sharedPreferences.getString("land_mark") +
                ", " +
                sharedPreferences.getString("delivery_address")
            : sharedPreferences.getString("delivery_address");
  }

  void _openConfirmAddress(
      {required BuildContext context,
      required String deliveryAddress,
      required bool chooseStatus}) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          //   return StatefulBuilder(
          // builder: (BuildContext context, StateSetter setState /*You can rename this!*/){

//           return  DraggableScrollableSheet(
// maxChildSize: 0.7,
// minChildSize: 0.3,
// initialChildSize: 0.6,
// expand:false,
//             builder: (contex,ScrollController  scrollController){
          return Container(
            height: MediaQuery.of(context).size.height * 0.80,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0),
              ),
            ),
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter mystate) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(Fins.buttonRadius),
                child: ConfirmDeliveryAddress(
                    // store: store,
                    deliveryAddress: deliveryAddress,
                    openChooseModal: chooseStatus),
              );
            }),
          );

          // });
//  });
        }).whenComplete((reRetrieveData));
  }

  void preOrder({
    required BuildContext context,
    required int amount,
    required String phone,
    required String mail,
    required String razorpay,
  }) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0),
              ),
            ),
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter mystate) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(Fins.buttonRadius),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Note",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 4, left: 8.0, right: 8),
                        child: Text(
                            "You order will be delivered tomorrow, between 7AM to 11AM."),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Fins.finsColor),
                                onPressed: () {
                                  openCheckOut(
                                      amount: amount,
                                      phone: phone,
                                      mail: mail,
                                      razorPayKey: razorpay);
                                  setState(() {
                                    orderType = 2;
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text("Order")),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
          );

          // });
//  });
        }).whenComplete((reRetrieveData));
  }

  // _changeState() {
  //   Future.delayed(Duration(seconds: 1), () {
  //     setState(() {
  //       selectState = true;
  //     });
  //   });
  // }

  Future<bool> confirmOrder() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(
              'Are you sure?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: new Text('You want to place the order'),
            actions: <Widget>[
              new TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text(
                  'No',
                  style: TextStyle(
                      color: Fins.finsColor,
                      // color: Color(0xff00CF0E),
                      fontWeight: FontWeight.bold),
                ),
              ),
              new TextButton(
                onPressed: () async {
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  var addressId = sharedPreferences.getString("address_id");
                  var home_no = sharedPreferences.getString("home_no");
                  var land_mark = sharedPreferences.getString("land_mark");
                  _deliveryBloc.add(SaveOrderDelivery(
                      orderType: orderType.toString(),
                      home_no: home_no,
                      landmark: land_mark,
                      paymentId: "",
                      paymentType: Fins.cashOnDelivery,
                      deliveryAddressInfo: "",
                      // storeType:widget. store.storeType,
                      addressId: addressId));

                  Navigator.of(context).pop(false);
                },
                child: new Text(
                  'Yes',
                  style: TextStyle(
                      color: Fins.finsColor,
                      // color: Color(0xff00CF0E),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  void openCheckOut(
      {required int amount,
      required String phone,
      required String mail,
      required String razorPayKey}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var home_no = sharedPreferences.getString("home_no");
    var land_mark = sharedPreferences.getString("land_mark");

    String orderId = await getRazorpayKey(
        orderType: orderType.toString(),
        paymentType: Fins.onlinePayment,
        home_no: home_no,
        landmark: land_mark);

    var totalAmount = amount * 100;
    var options = {
      'key': razorPayKey,
      'amount': totalAmount,
      'order_id': orderId,
      'name': 'Fins & Slice',
      'description': 'online payment',
      'prefill': {'contact': phone, 'email': mail},
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  checkService(int id, BuildContext context) async {
    var distanceResponse = await _storeRepository.checkDistance(
        url: Fins.ip + "home/order/" + id.toString() + "/getServiceStatus/",
        order_id: "");
    CustomResults customResult =
        CustomResults.fromJson(jsonDecode(distanceResponse.data));
    if (customResult.result == "success") {
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            customResult.description.toString(),
            style: TextStyle(color: Colors.white, fontSize: 16.0),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color(0xff323232),
        ),
      );
      return false;
    }
  }

  Future<bool> taxcharege(CartStore store) async {
    return (await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
              title: new Text('Tax and Charges',
                  style: TextStyle(
                      height: Fins.textHeight,
                      fontSize: Fins.textSize,
                      color: Fins.textColor,
                      fontWeight: FontWeight.bold)),
              content: Container(
                height: 200,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Delivery charge",
                              style: TextStyle(
                                  height: Fins.textHeight,
                                  fontSize: Fins.textSmallSize,
                                  color: Fins.textColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              store.deliveryCharge.toString(),
                              style: TextStyle(
                                  // decoration: TextDecoration.lineThrough,
                                  fontSize: Fins.textSmallSize,
                                  height: Fins.textHeight,
                                  color: Fins.textColor),
                            ),
                          ),
                        ],
                      ),
                    ),

//
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Packing charge",
                              style: TextStyle(
                                  height: Fins.textHeight,
                                  fontSize: Fins.textSmallSize,
                                  color: Fins.textColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              store.packingCharge.toString(),
                              style: TextStyle(
                                  // decoration: TextDecoration.lineThrough,
                                  fontSize: Fins.textSmallSize,
                                  height: Fins.textHeight,
                                  color: Fins.textColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    SizedBox(
                      height: Fins.sizedBoxHeight,
                    ),

                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text("Total",
                                style: TextStyle(
                                    height: Fins.textHeight,
                                    fontSize: Fins.textSmallSize,
                                    color: Fins.textColor)),
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                  "₹ " +
                                      ((int.parse(store.deliveryCharge
                                                  .toString())) +
                                              (int.parse(store.packingCharge
                                                  .toString())))
                                          .toString(),
                                  style: TextStyle(
                                      height: Fins.textHeight,
                                      fontSize: Fins.textSmallSize,
                                      color: Fins.textColor)))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Fins.sizedBoxHeight,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text("Ok",
                              style: TextStyle(
                                  height: Fins.textHeight,
                                  fontSize: Fins.textSize,
                                  color: Fins.finsColor))),
                    )
                  ],
                ),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Order Details"),
        ),
        body: BlocProvider<DeliveryBloc>(
          create: (BuildContext context) {
            return _deliveryBloc;
          },
          child: BlocBuilder<DeliveryBloc, DeliveryState>(
            builder: (context, state) {
              if (state is DeliveryUninitialized) {
                return LoadingListPage();
              }

              if (state is DeliveryError) {
                return NetworkError();
              }

              if (state is DeletedAddressState) {
                return LoadingListPage();
              }

              if (state is DeliveryPaymentLoading) {
                return WillPopScope(
                    onWillPop: () async {
                      Fluttertoast.showToast(
                          msg: "Please do wait until we complete the process.",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Fins.finsColor,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return true;
                    },
                    child: UploadingScreen());
              }
              if (state is DeliveryPaymentError) {
                return Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "images/paymentError.png",
                          height: 200,
                          width: 200,
                          fit: BoxFit.contain,
                        ),
                        Text(
                          "Payment failed",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Please check your network connectivity \n and try again.',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 14.0),
                                textAlign: TextAlign.center,
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        ButtonTheme(
                          height: 40,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Fins.finsColor)),
                            onPressed: () {
                              _deliveryBloc.add(LoadDeliveryInfo());
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Retry".toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
              if (state is DeliveryPaymentSuccess) {
                return WillPopScope(
                  onWillPop: () async {
                    // return navigator() ;
                    return (await (Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                InitialScreen()))));
                  },
                  child: Scaffold(
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
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: Fins.sizedBoxHeight,
                          ),
                          Text("Your order has been placed.",
                              style: TextStyle(
                                height: Fins.textHeight,
                                fontSize: Fins.titleSize,
                              )),
                          Lottie.asset("images/complet.json",
                              fit: BoxFit.contain, height: 200, width: 200),
                          SizedBox(
                            height: Fins.sizedBoxHeight,
                          ),
                          Expanded(
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 50.0),
                                  child: Text(
                                      "Your order will be delivered at your dorestep on the selected address.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        height: Fins.textHeight,
                                        fontSize: Fins.textSize,
                                      )),
                                )),
                          )
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
                                    borderRadius: BorderRadius.circular(0))),
                            backgroundColor: MaterialStateProperty.all<Color>(
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
                  ),
                );
              }
              if (state is DeliveryLoaded) {
                return Scaffold(
                  body: SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.all(Fins.commonPadding),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Material(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          Fins.buttonRadius)),
                                  elevation: 10,
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ShopItem(store: state.store)),
                                ),
                                SizedBox(
                                  height: Fins.sizedBoxHeight,
                                ),
                                Text("Billing Details",
                                    style: TextStyle(
                                        height: Fins.textHeight,
                                        fontSize: Fins.textSize,
                                        fontWeight: FontWeight.bold,
                                        color: Fins.textColor)),
                                SizedBox(
                                  height: Fins.sizedBoxHeight,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text("Item Total ",
                                            style: TextStyle(
                                                height: Fins.textHeight,
                                                fontSize: Fins.textSize,
                                                color: Fins.textColor))),
                                    Text("₹" + state.store.price.toString(),
                                        style: TextStyle(
                                            height: Fins.textHeight,
                                            fontSize: Fins.textSize,
                                            color: Fins.textColor))
                                  ],
                                ),
                                SizedBox(
                                  height: Fins.sizedBoxHeight,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          taxcharege(state.store);
                                        },
                                        child: Row(
                                          children: [
                                            Text("Taxes and charges",
                                                style: TextStyle(
                                                    height: Fins.textHeight,
                                                    fontSize: Fins.textSize,
                                                    color: Fins.textColor)),
                                            Icon(Icons.arrow_drop_down),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // (double.parse(state .deliveryCharge) +  double.parse( state.deliveryTax) +  double.parse(state .deliveryPacking)),
                                    Text(
                                        "₹ " +
                                            ((int.parse(state
                                                        .store.deliveryCharge
                                                        .toString())) +
                                                    (int.parse(state
                                                        .store.packingCharge
                                                        .toString())))
                                                .toString(),
                                        style: TextStyle(
                                            height: Fins.textHeight,
                                            fontSize: Fins.textSize,
                                            color: Fins.textColor))
                                  ],
                                ),
                                SizedBox(
                                  height: Fins.sizedBoxHeight,
                                ),
                                Row(
                                  children: [
                                    ((state.store.discount) == 0)
                                        ? Container()
                                        : Expanded(
                                            child: Text("Discount ",
                                                style: TextStyle(
                                                    height: Fins.textHeight,
                                                    fontSize: Fins.textSize,
                                                    color: Fins.finsColor))),
                                    ((state.store.discount) == 0)
                                        ? Container()
                                        : Text(
                                            "₹" +
                                                state.store.discount.toString(),
                                            style: TextStyle(
                                                height: Fins.textHeight,
                                                fontSize: Fins.textSize,
                                                color: Fins.finsColor))
                                  ],
                                ),

                                //  SizedBox(height: Fins.sizedBoxHeight,),
                                Divider(),
                                SizedBox(
                                  height: Fins.sizedBoxHeight,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text("Amount to pay",
                                            style: TextStyle(
                                                height: Fins.textHeight,
                                                fontSize: Fins.textSize,
                                                color: Fins.textColor))),
                                    Text(
                                        "₹" + state.store.amountPaid.toString(),
                                        style: TextStyle(
                                            height: Fins.textHeight,
                                            fontSize: Fins.textSize,
                                            color: Fins.textColor,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                                SizedBox(
                                  height: Fins.sizedBoxHeight,
                                ),
                                Divider(),
                                //  SizedBox(height: Fins.sizedBoxHeight,),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text("Your Total Savings ",
                                            style: TextStyle(
                                                height: Fins.textHeight,
                                                fontSize: Fins.textSize,
                                                color: Fins.finsColor))),
                                    Text("₹" + state.store.discount.toString(),
                                        style: TextStyle(
                                            height: Fins.textHeight,
                                            fontSize: Fins.textSize,
                                            color: Fins.finsColor))
                                  ],
                                ),
                                SizedBox(
                                  height: Fins.sizedBoxHeight,
                                ),
                                Divider(),
                                SizedBox(
                                  height: Fins.sizedBoxHeight,
                                ),
                                SizedBox(
                                  height: Fins.sizedBoxHeight,
                                ),
                                SizedBox(
                                  height: Fins.sizedBoxHeight,
                                ),
                                SizedBox(
                                  height: Fins.sizedBoxHeight,
                                ),

                                Row(
                                  children: [
                                    Expanded(
                                        child: Text("Delivery address",
                                            style: TextStyle(
                                                height: Fins.textHeight,
                                                fontSize: Fins.textSize,
                                                color: Fins.textColor,
                                                fontWeight: FontWeight.bold))),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Fins.finsColor)),
                                        onPressed: () async {
                                          // bottomSheet();
                                          SharedPreferences sharedPreferences =
                                              await SharedPreferences
                                                  .getInstance();
                                          if (sharedPreferences
                                                  .getString("address_id") !=
                                              null) {
                                            await checkServiceStatus(
                                                state.store.id, context);
                                          } else {
                                            _openConfirmAddress(
                                                context: context,
                                                deliveryAddress:
                                                    selectedDeliveryLocation,
                                                // state.user.deliveryAddress,
                                                chooseStatus: false);
                                          }
                                        },
                                        child: Text("Change address",
                                            style: TextStyle(
                                                height: Fins.textHeight,
                                                fontSize: Fins.textSize)))
                                  ],
                                ),
                                SizedBox(
                                  height: Fins.sizedBoxHeight,
                                ),

                                Text(selectedDeliveryLocation,
                                    style: TextStyle(
                                        height: Fins.textHeight,
                                        fontSize: Fins.textSize,
                                        color: Fins.textColor))
                              ]))),
                  bottomNavigationBar: SizedBox(
                    height: 105,
                    child: (selectState == true)
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8),
                                      child: SizedBox(
                                        height: 45,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                              side: MaterialStateProperty
                                                  .all<BorderSide>(BorderSide(
                                                      color: Fins.finsColor)),
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Fins.finsColor)),
                                          onPressed: () async {
                                            SharedPreferences
                                                sharedPreferences =
                                                await SharedPreferences
                                                    .getInstance();

                                            var home_no = sharedPreferences
                                                .getString("home_no");
                                            var land_mark = sharedPreferences
                                                .getString("land_mark");

                                            // // confirmAlertOP();
                                            if (await checkService(
                                                    state.store.id, context) ==
                                                true) {
                                              preOrder(
                                                  context: context,
                                                  amount:
                                                      (state.store.amountPaid)
                                                          .toInt(),
                                                  mail: state.store.email,
                                                  phone: state.store.phone,
                                                  razorpay: state.store.razorPay
                                                      .toString());
                                              // openCheckOut(
                                              //     amount: (state.store.amountPaid)
                                              //         .toInt(),
                                              //     phone: state.store.phone,
                                              //     mail: state.store.email,
                                              //     razorPayKey: state
                                              //         .store.razorPay
                                              //         .toString());
                                            }
                                          },
                                          child: Text("Preorder",
                                              style: TextStyle(
                                                  height: Fins.textHeight,
                                                  fontSize: Fins.textSize,
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            side: MaterialStateProperty
                                                .all<BorderSide>(BorderSide(
                                                    color: Fins.finsColor)),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white)),
                                        onPressed: () async {
                                          // confirmAlertCOD(store:widget.store);
                                          if (await checkService(
                                                  state.store.id, context) ==
                                              true) {
                                            if (state.store.price >=
                                                state.store.minimumCharge) {
                                              confirmOrder();
                                              orderType = 1;
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    "Your total item cost is less then ₹" +
                                                        state
                                                            .store.minimumCharge
                                                            .toString() +
                                                        ", Please do add more to continue with checkout...",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.0),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  backgroundColor:
                                                      Color(0xff323232),
                                                ),
                                              );
                                            }
                                          }
                                        },
                                        child: Text("Cash on Delivery",
                                            style: TextStyle(
                                                height: Fins.textHeight,
                                                fontSize: Fins.textSize,
                                                color: Fins.finsColor)),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            side: MaterialStateProperty
                                                .all<BorderSide>(BorderSide(
                                                    color: Fins.finsColor)),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Fins.finsColor)),
                                        onPressed: () async {
                                          if (await checkService(
                                                  state.store.id, context) ==
                                              true) {
                                            orderType = 1;

                                            openCheckOut(
                                                amount: (state.store.amountPaid)
                                                    .toInt(),
                                                phone: state.store.phone,
                                                mail: state.store.email,
                                                razorPayKey: state
                                                    .store.razorPay
                                                    .toString());
                                          }
                                        },
                                        child: Text("Online Payment",
                                            style: TextStyle(
                                                height: Fins.textHeight,
                                                fontSize: Fins.textSize,
                                                color: Colors.white)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : InkWell(
                            onTap: () async {
                              // bottomSheet();
                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              if (sharedPreferences.getString("address_id") !=
                                  null) {
                                await checkServiceStatus(
                                    state.store.id, context);
                              } else {
                                _openConfirmAddress(
                                    context: context,
                                    deliveryAddress: selectedDeliveryLocation,
                                    // state.user.deliveryAddress,
                                    chooseStatus: false);
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                Container(
                                  height: 50,
                                  decoration:
                                      BoxDecoration(color: Fins.finsColor),
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                          child: Text(
                                              "confirm delivery address"
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  height: Fins.textHeight,
                                                  fontSize: Fins.textSize,
                                                  color: Colors.white)))),
                                ),
                              ],
                            ),
                          ),
                  ),
                );
              }
              return Container();
            },
          ),
        ));
  }
}
