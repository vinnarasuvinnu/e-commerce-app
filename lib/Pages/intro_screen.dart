/*
 * Copyright (c) 2020. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

import 'package:fins_user/Pages/Account/Login.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/material.dart';

import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';


class IntroScreen extends StatefulWidget {

  IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() {
    return _IntroScreenState();
  }
}

class _IntroScreenState extends State<IntroScreen> {
  // static double _fontSizeForTitle=20.0;
  // static double _fontSizeForContent=16.0;
  List<Slide> slides = [];
  late Function goToTab;

  @override
  void initState() {
    super.initState();

    slides.add(
        Slide(
           title: "",


        description: "",
         
          pathImage: "images/slider1.png",
        // backgroundColor: Color(0xffffffff),
       
       
      ),
    );

    slides.add(
      Slide(
        title: "",
        //
        description:
        "",
        
          pathImage: "images/slider2.png",
      ),
    );
    slides.add(
      Slide(
          title: "",
          //
          description:
          "",
         
          pathImage: "images/slider3.png",
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
  void onDonePress() {
    // Do what you want
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
  }

  Widget renderSkipBtn() {
    return Text(
      "Skip",
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black
      ),
    );
  }

  Widget renderNextBtn() {
    return Text(
      "Next",
      style: TextStyle(
          fontSize: 16.0,
          color: Colors.black
      ),
    );
  }

  Widget renderDoneBtn(){

    return Text(
      "Done",
      style: TextStyle(
          fontSize: 16.0,
          color: Colors.black
      ),
    );

  }
  // void onTabChangeCompleted(index) {
  //   // Index of current tab is focused
  // }
  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = [];
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: EdgeInsets.only(bottom: 60.0, top: 60.0),
              child: ListView(
                children: <Widget>[
                  Container(
                    child: GestureDetector(
                        child: Image.asset(
                      currentSlide.pathImage.toString(),
                      width: 300.0,
                      height: 300.0,
                      fit: BoxFit.fill,
                    )),
                     margin: EdgeInsets.only(top: 30.0),
                  ),
                 
                  
                  Container(
                    child: Text(
                      currentSlide.title.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize:20,),
                      textAlign: TextAlign.center,
                      
                      
                    ),
                    margin: EdgeInsets.only(top: 70.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      child: Text(
                        currentSlide.description.toString(),
                        style: TextStyle(fontSize: 15),
                        
                        textAlign: TextAlign.center,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                      margin: EdgeInsets.only(top: 20.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(Colors.white);

    // TODO: implement build
    return IntroSlider(
      // backgroundColorAllSlides: Mart.brandColor,
      colorActiveDot: Fins.finsColor,
      colorDot: Colors.grey,
      // colorDoneBtn: Colors.green,
      slides: this.slides,
      renderSkipBtn: this.renderSkipBtn(),
      renderNextBtn: this.renderNextBtn(),
      renderDoneBtn: this.renderDoneBtn(),

      onDonePress: this.onDonePress,
       listCustomTabs: this.renderListCustomTabs(),
      backgroundColorAllSlides: Colors.white,
     refFuncGoToTab: (refFunc) {
        this.goToTab = refFunc;
      }
      // onTabChangeCompleted: this.onTabChangeCompleted,
      
    );
  }
}