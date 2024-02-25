import 'dart:convert';
import 'dart:math';

import 'package:fins_user/Bloc/DeliveryBloc/Delivery_Bloc.dart';
import 'package:fins_user/Bloc/DeliveryBloc/Delivery_State.dart';
import 'package:fins_user/Models/DeliveryAddress.dart';
import 'package:fins_user/Models/DeliveryAddressRest.dart';
import 'package:fins_user/Models/custom_result.dart';
import 'package:fins_user/repository/PaymentRepository.dart';
import 'package:fins_user/repository/homeRepository.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart' as CurrentLocation;
import 'package:shared_preferences/shared_preferences.dart';

// Mart mart = new Mart();
Fins fins = Fins();
String kGoogleApiKey = Fins.googleMapApiKey;
//final homeScaffoldKey = GlobalKey<ScaffoldState>();
final searchScaffoldKey = GlobalKey<ScaffoldState>();
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
HomeRepository homeRepository = HomeRepository();
final String locationUrl = Fins.ip + "home/location/";
bool showSaved = true;
bool showLoading = false;

class CustomSearchScaffold extends PlacesAutocompleteWidget {
  CustomSearchScaffold()
      : super(
          apiKey: kGoogleApiKey,
          sessionToken: Uuid().generateV4(),
          language: "en",
          components: [Component(Component.country, "in")],
        );

  @override
  _CustomSearchScaffoldState createState() => _CustomSearchScaffoldState();
}

class _CustomSearchScaffoldState extends PlacesAutocompleteState {
  final String fetchSaveAddressUrl = Fins.ip + "home/deliveryAddress/";
  PaymentRepository _paymentRepository = PaymentRepository();
  late List<DeliveryAddress> deliveryAddresses;
  late DeliveryBloc _deliveryBloc;
  static const String updateUserLocation =
      Fins.ip + "home/user/0/update_location/";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _deliveryBloc = DeliveryBloc(DeliveryUninitialized());
    // fetchDeliveryAddress();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _deliveryBloc.close();
  }

  Future<Null> displayPrediction(Prediction p) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String phone = sharedPreferences.getString("mobile");
    final String updateUserLocation = Fins.ip + "home/user/0/update_location/";
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId.toString());
      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;

      final response = await homeRepository.updateUserLocation(
          url: updateUserLocation,
          latitude: lat.toString(),
          longitude: lng.toString(),
          token: '',
          address: detail.result.formattedAddress.toString());
      CustomResults customResult =
          CustomResults.fromJson(jsonDecode(response.data));
      if (customResult.result == "success") {
        Fins.setUserLocation(
            latitude: lat,
            longitude: lng,
            address: detail.result.formattedAddress.toString());
        Navigator.of(context).pop();
      }

//      Scaffold.of(context).showSnackBar(new SnackBar(
//          content: Text("${p.description} - $lat/$lng")
//      ));
    }
  }

  static updateUserLocationData(
      {required double latitude,
      required double longitude,
      required String address}) async {
    HomeRepository homeRepository = HomeRepository();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String phone = sharedPreferences.getString("mobile");

    final response = await homeRepository.updateUserLocation(
        url: updateUserLocation,
        // phone: phone,
        latitude: latitude.toString(),
        longitude: longitude.toString(),
        address: address,
        token: '');
    CustomResults customResult =
        CustomResults.fromJson(jsonDecode(response.data));
    if (customResult.result == "success") {
      await Fins.setUserLocation(
          latitude: latitude, longitude: longitude, address: '');
    }
  }

//
//   Future getLocationPoints() async {
//     CurrentLocation.Location location = new CurrentLocation.Location();
//     CurrentLocation.LocationData _locationData;
//
//     _locationData = await location.getLocation();
//
//     Navigator.of(context)
//         .push(MaterialPageRoute(
//         builder: (context) => PickUpLocation(
//           lat: _locationData.latitude,
//           lng: _locationData.longitude,
//         )))
//         .whenComplete(retireveAfterBack);
//   }

  Future getLocationPoints() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String phone = sharedPreferences.getString("mobile");
    final String updateUserLocation = Fins.ip + "home/user/0/update_location/";

    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final coordinates =
          new Coordinates(position.latitude, position.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;

      final response = await homeRepository.updateUserLocation(
          url: updateUserLocation,
          latitude: position.latitude.toString(),
          longitude: position.longitude.toString(),
          address: first.featureName + ", " + first.addressLine,
          token: '');
      CustomResults customResult =
          CustomResults.fromJson(jsonDecode(response.data));

      if (customResult.result == "success") {
        Fins.setUserLocation(
            latitude: position.latitude,
            longitude: position.longitude,
            address: first.featureName + ", " + first.addressLine);

        Navigator.of(context).pop();
      }

//      var locationResponse=await homeRepository.(url: locationUrl,latitude: position.latitude.toString(),longitude: position.longitude.toString());
//      CustomResult customResult=CustomResult.fromJson(jsonDecode(locationResponse.data));
//      var currentLocation=customResult.description;
//
//      showInSnackBar(currentLocation);

    } catch (e) {
      print(e);
    }
  }

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context)
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  void fetchDeliveryAddress() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var phone = sharedPreferences.getString("mobile");
    var allAddress = await _paymentRepository.fetchDeliveryAddress(
        url: fetchSaveAddressUrl, phone: phone);
    DeliveryAddressRest deliveryAddressRest =
        DeliveryAddressRest.fromJson(allAddress.data);

    setState(() {
      deliveryAddresses = deliveryAddressRest.results;
    });
  }

  void retireveAfterBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: 1.0,
      brightness: Brightness.light,
      title: AppBarPlacesAutoCompleteTextField(),
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
    );
    final body = PlacesAutocompleteResult(
      onTap: (p) {
        displayPrediction(p);
      },
      logo: Container(),
    );
    return Scaffold(
//        key: searchScaffoldKey,
      appBar: appBar,
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 40.0,
            child: ButtonTheme(
              // height: Mart.buttonThemeHeight,
              child: RaisedButton.icon(
                color: Fins.finsColor,
                label: Text(
                  "choose current location".toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold),
                ),
                icon: Icon(
                  Icons.my_location,
                  color: Colors.white,
                ),
                onPressed: () {
                  getLocationPoints();
                },
              ),
            ),
          ),
          Expanded(child: body)
        ],
      ),
    );
  }

  @override
  void onResponseError(PlacesAutocompleteResponse response) {
    super.onResponseError(response);

    Fluttertoast.showToast(
        msg: "Something went wrong, please do try again !",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  // @override
  // void onResponse(PlacesAutocompleteResponse response) {
  //   super.onResponse(response);
  //   if (response != null && response.predictions.isNotEmpty) {
  //     setState(() {
  //       showSaved = false;
  //     });
  //   } else {
  //     setState(() {
  //       showSaved = true;
  //     });
  //   }
  // }
}

class Uuid {
  final Random _random = Random();

  String generateV4() {
    // Generate xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx / 8-4-4-4-12.
    final int special = 8 + _random.nextInt(4);

    return '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
        '${_bitsDigits(16, 4)}-'
        '4${_bitsDigits(12, 3)}-'
        '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
        '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
  }

  String _bitsDigits(int bitCount, int digitCount) =>
      _printDigits(_generateBits(bitCount), digitCount);

  int _generateBits(int bitCount) => _random.nextInt(1 << bitCount);

  String _printDigits(int value, int count) =>
      value.toRadixString(16).padLeft(count, '0');
}
