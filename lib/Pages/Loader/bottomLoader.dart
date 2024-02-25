
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';



class BottomLoader extends StatelessWidget {
  BottomLoader({Key ?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      child: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Fins.finsColor),)),
    );
  }
}
