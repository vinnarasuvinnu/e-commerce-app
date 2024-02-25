import 'package:cached_network_image/cached_network_image.dart';
import 'package:fins_user/Bloc/offersBloc/offersBloc.dart';
import 'package:fins_user/Bloc/offersBloc/offersEvent.dart';
import 'package:fins_user/Models/offersList.dart';
import 'package:fins_user/Pages/Loader/bottomLoader.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/material.dart';


class OfferItems extends StatefulWidget {

  final Offers offers;
  final OfferBloc offerBloc;

  const OfferItems({Key? key,required this.offerBloc,required this.offers}) : super(key: key);

  @override
  _OfferItemsState createState() => _OfferItemsState();
}

class _OfferItemsState extends State<OfferItems> {
  var itemCount=0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: Stack(
              children: [
                Container(
                  height: 170,
                  width: MediaQuery.of(context).size.width,
                  child: CachedNetworkImage(
                    imageUrl:widget.offers.productImageIds,
                    imageBuilder: (context, imageProvider) => Container(
                      height: 170,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) =>
                        BottomLoader(),
                    errorWidget: (context, url, error) => Image.asset("images/logo_gray.png",fit: BoxFit.cover,),
                  ),
                ),
                (
                    widget.offers.without_discount!= widget.offers.price
                )?Positioned(
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Fins.finsColor,
                        borderRadius:
                        BorderRadius.only(topRight: Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8, top: 4, bottom: 4),
                      child: Text(
                        widget.offers.discount.toString()+" % Off",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ):Container()
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
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
                            Text(widget.offers.name,
                                style: TextStyle(
                                  height: Fins.textHeight,
                                  fontSize: Fins.textSize,
                                )),
                            Text(widget.offers.description,
                                style: TextStyle(
                                    height: Fins.textHeight,
                                    fontSize: Fins.textSmallSize,
                                    color: Fins.secondaryTextColor
                                )),

                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                child: (widget.offers.selected_count==0)
                                    ? SizedBox(
                                  height: 30,
                                  width: 90,
                                  child: (widget.offers.inStock==0)?ElevatedButton(
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
                                          borderRadius: BorderRadius.circular(
                                              Fins.buttonRadius)),
                                    ),
                                    onPressed: () {
                                      widget.offerBloc.add(AddOfferProduct(productId: widget.offers.id.toString()));
                                    },
                                    child: Text("ADD"),
                                  ),
                                )
                                    : Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: SizedBox(
                                      height: 30,
                                      width: 90,
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              widget.offerBloc.add(SubtractOfferProduct(productId: widget.offers.id.toString()));

                                            },
                                            child: AnimatedContainer(
                                              duration:
                                              Duration(milliseconds: 1000),
                                              decoration: BoxDecoration(
                                                  color: Fins.finsColor,
                                                  borderRadius:
                                                  BorderRadius.circular(5)),
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
                                                  widget.offers.selected_count.toString(),
                                                  style: TextStyle(
                                                      color: Fins.finsColor),
                                                )),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              widget.offerBloc.add(AddOfferProduct(productId: widget.offers.id.toString()));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Fins.finsColor,
                                                  borderRadius:
                                                  BorderRadius.circular(5)),
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
                        child: Text(widget.offers.weight.toString()+widget.offers.productQuantityTitle,
                            style: TextStyle(
                                height: Fins.textHeight,
                                fontSize: Fins.textSize,
                                color: Fins.secondaryTextColor)),
                      ),
                      (widget.offers.without_discount==widget.offers.price)?

                      SizedBox(
                        width: 90,
                        child: Text(
                          "₹"+widget.offers.without_discount.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: Fins.textSize,
                              height: Fins.textHeight,
                              color: Fins.secondaryTextColor),
                        ),
                      ):
                      Row(
                        children: [
                          Text(
                            "₹"+widget.offers.without_discount.toString(),
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: Fins.textSize,
                                height: Fins.textHeight,
                                color: Fins.secondaryTextColor),
                          ),
                          SizedBox(
                            width: Fins.sizedBoxHeight,
                          ),
                          Text(
                            "₹"+widget.offers.price.toString(),
                            style: TextStyle(
                                fontSize: Fins.textSize,
                                height: Fins.textHeight,
                                color: Fins.textColor),
                          ),
                        ],
                      )

                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
