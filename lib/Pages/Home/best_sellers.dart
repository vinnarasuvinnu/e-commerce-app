import 'package:cached_network_image/cached_network_image.dart';
import 'package:fins_user/Bloc/HomeBloc/home_bloc.dart';
import 'package:fins_user/Bloc/HomeBloc/home_event.dart';
import 'package:fins_user/Models/bestSellers.dart';
import 'package:fins_user/Pages/Loader/bottomLoader.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BestSellers extends StatefulWidget {
  final BestSeller bestSeller;
  final HomeBloc homeBloc;

  const BestSellers(
      {Key? key, required this.bestSeller, required this.homeBloc})
      : super(key: key);

  @override
  _BestSellersState createState() => _BestSellersState();
}

class _BestSellersState extends State<BestSellers> {
  int itemCount = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Stack(
                children: [
                  Container(
                    height: 120,
                    width: 250,
                    child: CachedNetworkImage(
                      imageUrl: widget.bestSeller.productImageIds,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 120,
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder:
                          (context, url) => BottomLoader(),
                      errorWidget: (context, url, error) => Image.asset(
                        "images/logo_gray.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  (widget.bestSeller.without_discount != widget.bestSeller.price)
                      ? Positioned(
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Fins.finsColor,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8, top: 4, bottom: 4),
                              child: Text(
                                widget.bestSeller.discount.toString() +
                                    " % Offer",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            Container(
              width: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  border: Border.all(color: Color(0xffe0e0e0))),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.bestSeller.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      height: Fins.textHeight,
                                      fontSize: Fins.textSize,
                                    )),
                                Text(widget.bestSeller.description,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        height: Fins.textHeight,
                                        fontSize: Fins.textSmallSize,
                                        color: Fins.secondaryTextColor)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    child: (widget.bestSeller.selected_count == 0)
                                        ? SizedBox(
                                            height: 30,
                                            width: 90,
                                            child: (widget.bestSeller.inStock==0)?ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.grey,

                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(
                                                        Fins.buttonRadius)),
                                              ),
                                              onPressed: null,
                                              child: Text("ADD"),
                                            ):TextButton(
                                              style: TextButton.styleFrom(
                                                primary: Colors.white,
                                                backgroundColor: Fins.finsColor,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Fins.buttonRadius)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  widget.homeBloc.add(AddProduct(productId: widget.bestSeller.id.toString()));
                                                });
                                              },
                                              child: Text("ADD"),
                                            ),
                                          )
                                        : Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: SizedBox(
                                                height: 30,
                                                width: 90,
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        widget.homeBloc.add(
                                                            SubtractProduct(
                                                                productId: widget
                                                                    .bestSeller
                                                                    .id
                                                                    .toString()));
                                                      },
                                                      child: AnimatedContainer(
                                                        duration: Duration(
                                                            milliseconds: 1000),
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Fins.finsColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        height: 30,
                                                        width: 30,
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 30,
                                                      width: 30,
                                                      child: Center(
                                                          child: Text(
                                                        widget.bestSeller.selected_count.toString(),
                                                        style: TextStyle(
                                                            color:
                                                                Fins.finsColor),
                                                      )),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          widget.homeBloc.add(
                                                              AddProduct(
                                                                  productId: widget
                                                                      .bestSeller
                                                                      .id
                                                                      .toString()));
                                                        });
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Fins.finsColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        height: 30,
                                                        width: 30,
                                                        child: Icon(
                                                          Icons.add,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          )),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                                widget.bestSeller.weight.toString() +
                                    "" +
                                    widget.bestSeller.productQuantityTitle,
                                style: TextStyle(
                                    height: Fins.textHeight,
                                    fontSize: Fins.textSize,
                                    color: Fins.secondaryTextColor)),
                          ),
                          Row(
                            children: [
                              (widget.bestSeller.without_discount ==
                                      widget.bestSeller.price)
                                  ? SizedBox(
                                      width: 90,
                                      child: Text(
                                        "₹" +
                                            widget.bestSeller.without_discount
                                                .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: Fins.textSize,
                                            height: Fins.textHeight,
                                            color: Fins.textColor),
                                      ),
                                    )
                                  :
                              Row(
                                children: [
                                  Text(
                                    "₹" +
                                        widget.bestSeller.without_discount
                                            .toString(),
                                    style: TextStyle(
                                        decoration:
                                        TextDecoration.lineThrough,
                                        fontSize: Fins.textSize,
                                        height: Fins.textHeight,
                                        color: Fins.secondaryTextColor),
                                  ),
                                  SizedBox(
                                    width: Fins.sizedBoxHeight,
                                  ),
                                  Text(
                                    "₹" + widget.bestSeller.price.toString(),
                                    style: TextStyle(
                                        fontSize: Fins.textSize,
                                        height: Fins.textHeight,
                                        color: Fins.textColor),
                                  ),
                                ],
                              ),

                            ],
                          )
                        ],
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
