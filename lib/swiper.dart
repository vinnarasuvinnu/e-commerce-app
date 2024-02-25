import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'Pages/Account/Login.dart';

class SwipePage extends StatefulWidget {
  const SwipePage({Key? key}) : super(key: key);

  @override
  _SwipePageState createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  late SwiperController controller;

  final List imgList = [
    "images/img1.JPG",
    "images/img2.JPG",
    "images/img3.jpg",
  ];

  late int swipeIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = SwiperController();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Swiper(
          loop: false,
          controller: controller,
          itemBuilder: (BuildContext context, int index) {
            // swipeIndex = index;
            // print(index);
            if (index == 2) {
              Future.delayed(
                  Duration(
                    milliseconds: 500,
                  ), () {
                setState(() {
                  swipeIndex = 2;
                });
              });
            } else {
              Future.delayed(
                  Duration(
                    milliseconds: 500,
                  ), () {
                setState(() {
                  swipeIndex = index;
                });
              });
            }
            return new Image.asset(
              imgList[index],
              fit: BoxFit.cover,
            );
          },
          itemCount: 3,
          pagination: new SwiperPagination(
              builder: new DotSwiperPaginationBuilder(
                  color: Colors.grey, activeColor: Fins.finsColor)),
          // control: new SwiperControl(),
        ),
        // (swipeIndex==2)?
        (swipeIndex!=2)?Positioned(
          bottom: 20,
          left: 20,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Fins.finsColor),
            onPressed: () {
              controller.move(swipeIndex=2);
            },
            child: Text("Skip"),
          ),
        ):Container(),
        Positioned(
            bottom: 20,
            right: 20,
            child: (swipeIndex != 2)
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Fins.finsColor),
                    onPressed: () {
                      int currentI = swipeIndex;
                      currentI += 1;
                      controller.move(currentI);

                      // if(swipeIndex>3){
                      //   setState(() {
                      //     swipeIndex=0;
                      //   });
                      // }

                      setState(() {
                        swipeIndex = currentI;
                      });
                    },
                    child: Text("Next"))
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Fins.finsColor),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text("Done"))),
      ],
    );
  }
}
