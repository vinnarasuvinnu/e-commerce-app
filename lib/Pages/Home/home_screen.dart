import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fins_user/Bloc/HomeBloc/home_bloc.dart';
import 'package:fins_user/Bloc/HomeBloc/home_event.dart';
import 'package:fins_user/Bloc/HomeBloc/home_state.dart';
import 'package:fins_user/LoadingListPage.dart';
import 'package:fins_user/Models/homeCategoryProducts.dart';
import 'package:fins_user/Pages/Cart/MyCart.dart';
import 'package:fins_user/Pages/Home/Search.dart';
import 'package:fins_user/Pages/Home/best_sellers.dart';
import 'package:fins_user/Pages/Home/menu_items.dart';
import 'package:fins_user/Pages/Home/shop_offline.dart';
import 'package:fins_user/Pages/Home/shop_unAvailable.dart';
import 'package:fins_user/Pages/Loader/bottomLoader.dart';
import 'package:fins_user/utils/NetWordError.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'chip.dart';
import 'locationSearch.dart';

class HomePage extends StatefulWidget {
  final count;

  const HomePage({Key? key, this.count}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;
  late HomeBloc homeBloc;
  late int category_id = 0;

  late HomeCategoryProducts homeCategoryProducts;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  late AutoScrollController controller;
  bool menu = true;
  final scrollDirection = Axis.vertical;
  bool a_bar1_enabled = false;
  bool a_bar2_enabled = false;
  double currentScroll = 0.0;
  double currentMenuScroll = 0.0;
  int currentId = 0;

  Future _scrollToIndex(index) async {
    await controller.scrollToIndex(index,
        preferPosition: AutoScrollPosition.begin);
  }

  Future _scrollMenuIndex(index) async {
    if (index != null) {
      try {
        if (itemScrollController.isAttached)
          itemScrollController.jumpTo(index: index);
      } catch (e) {
        print(e);
      }
    }
  }

  void changemenuStatus() {
    setState(() {
      if (menu) {
        menu = false;
      } else {
        menu = true;
      }
    });
  }

  findAndScrollToIndex(
      int id, HomeCategoryProducts homeCategoryProducts) async {
    print(id);

    for (var i = 0; i < homeCategoryProducts.categoryResults.length; i++) {
      if (homeCategoryProducts.categoryResults[i].categoryId == id) {
        await controller.scrollToIndex(i,
            preferPosition: AutoScrollPosition.begin);
        setState(() {
          _selectedIndex = i;
        });
        break;
      }
    }
  }

  @override
  void initState() {
    super.initState();

    homeBloc = HomeBloc(HomeUninitalized());
    // homeBloc.add(FetchStoreLocation(token: ""));
    retrieveData();
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: scrollDirection);
    controller.addListener(_onScroll);

    // snackBar();
  }

  retrieveData() {
    homeBloc.add(FetchStoreLocation(token: ""));
  }

  reFetchHome() {
    homeBloc.add(FetchReHome());
  }

  void _onScroll() {
    currentScroll = controller.position.pixels;
    if (a_bar1_enabled == false) {
      if (currentScroll > 50) {
        setState(() {
          currentScroll = controller.position.pixels;
          a_bar1_enabled = true;
          a_bar2_enabled = false;
        });
      }
    }
    if (a_bar2_enabled == false) {
      if (currentScroll < 50) {
        setState(() {
          currentScroll = controller.position.pixels;
          a_bar1_enabled = false;
          a_bar2_enabled = true;
        });
      }
    }
  }

  Future<bool> _showMenu(HomeCategoryProducts homeCategoryProducts) async {
    Future.delayed(Duration(seconds: 1), () {
      try {
        _scrollMenuIndex(_selectedIndex);
      } catch (e) {
        print(e);
      }
    });
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            contentPadding: EdgeInsets.all(8),
//        title: new Text(
//          'Are you sure?',
//          style: TextStyle(fontWeight: FontWeight.bold),
//        ),
            content: Container(
                height: 300,
                width: 300,
                child: RawScrollbar(
                  thickness: 3,
                  // timeToFade: Duration(milliseconds: 1000),
                  radius: Radius.circular(3),
                  interactive: true,
                  // showTrackOnHover: true,
                  // isAlwaysShown: true,
                  child: ListView.builder(
                      itemCount: homeCategoryProducts.categoryResults.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            _scrollToIndex(index);

                            setState(() {
                              _selectedIndex = index;
                            });

                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4, bottom: 4.0),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, bottom: 2, top: 8.0, right: 12),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 70,
                                      child: Text(
                                        homeCategoryProducts
                                            .categoryResults[index]
                                            .categoryName,
                                        style: TextStyle(
                                            fontWeight:
                                                (_selectedIndex == index)
                                                    ? FontWeight.bold
                                                    : FontWeight.normal),
                                      )),
                                  Expanded(
                                    flex: 30,
                                    child: Text(
                                      homeCategoryProducts
                                          .categoryResults[index]
                                          .products
                                          .length
                                          .toString(),
                                      style: TextStyle(
                                          fontWeight: (_selectedIndex == index)
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                      textAlign: TextAlign.right,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                )),
//        actions: <Widget>[
//          new TextButton(
//            onPressed: () => Navigator.of(context).pop(false),
//            child: new Text(
//              'Exit',
//              style: TextStyle(
//                  color: Mart.brandColor, fontWeight: FontWeight.bold),
//            ),
//          ),
//
//        ],
          ),
        ).whenComplete(() {
          changemenuStatus();
        })) ??
        false;
  }

  fetchCategory(int id) {
    if (id == 0) {
      setState(() {
        currentId = 0;
      });
      homeBloc.add(FetchCategoryEvent(id: ""));
    } else {
      homeBloc.add(FetchCategoryEvent(id: id.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: homeBloc,
      listener: (BuildContext context, HomeState state) {
        if (state is HomeStateLoaded) {
          if (category_id != 0) {
            findAndScrollToIndex(category_id, state.homeCategoryProducts);
            setState(() {
              category_id = 0;
            });
          }
        }
      },
      child: BlocProvider<HomeBloc>(create: (BuildContext context) {
        return homeBloc;
      }, child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if (state is HomeUninitalized) {
          return LoadingListPage();
        }
        if (state is HomeStateError) {
          return NetworkError();
        }

        if (state is HomeStateLoaded) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              iconTheme: IconThemeData(color: Colors.black),
              title: Padding(
                padding: const EdgeInsets.only(left: Fins.titleTextPadding),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CustomSearchScaffold()))
                        .whenComplete(reFetchHome);
                  },
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Fins.finsColor,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 1.0),
                                  child: Text("Delivery location",
                                      style: TextStyle(
                                          fontSize: 10.0,
                                          color: Fins.finsColor)),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  state.userLocationInfo.address,
                                  style: TextStyle(
                                    color: Fins.secondaryTextColor,
                                    fontSize: Fins.textSmallSize,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                (state.userLocationInfo.accept &&
                        state.userLocationInfo.location)
                    ? Padding(
                        padding: const EdgeInsets.only(right: 16.0, top: 8.0),
                        child: Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (context) => MyCart()))
                                  .whenComplete(reFetchHome);
                            },
                            child: Badge(
                                badgeColor: Colors.red,
                                position:
                                    BadgePosition.topStart(top: -5, start: 15),
                                badgeContent: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    state.cartCount,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Fins.textSmallSize),
                                  ),
                                ),
                                child: Icon(Icons.shopping_cart_outlined)),
                          ),
                        ))
                    : Container(),
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: Fins.commonPadding,
                            right: Fins.commonPadding),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            primary: Colors.grey,
                            // backgroundColor: Colors.green[0],
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(Fins.buttonRadius),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (context) => SearchItems()))
                                .whenComplete(reFetchHome);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Search",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: (state.userLocationInfo.location == false)
                ? ShopUnAvailable()
                : (state.userLocationInfo.accept == false)
                    ? ShopClosed()
                    : RefreshIndicator(
                        color: Fins.finsColor,
                        onRefresh: () async {
                          reFetchHome();
                        },
                        child: ListView(
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          children: [
                            Container(
                              height: 60,
                              color: Fins.finsColor.withOpacity(.2),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                    physics: AlwaysScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.homeCategoryProducts
                                        .categoryResults.length,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          index == 0
                                              ? InkWell(
                                                  onTap: () {
                                                    fetchCategory(0);
                                                    setState(() {
                                                      currentId = 0;
                                                    });
                                                  },
                                                  child: TopChip(
                                                    currentId: currentId,
                                                    title: "All",
                                                    id: 0,
                                                  ),
                                                )
                                              : Container(),
                                          index == 0
                                              ? SizedBox(
                                                  width: 8,
                                                )
                                              : Container(),
                                          InkWell(
                                              onTap: () {
                                                fetchCategory(state
                                                    .homeCategoryProducts
                                                    .categoryResults[index]
                                                    .categoryId);

                                                setState(() {
                                                  currentId = state
                                                      .homeCategoryProducts
                                                      .categoryResults[index]
                                                      .categoryId;
                                                });
                                                print(currentId);
                                              },
                                              child: TopChip(
                                                currentId: currentId,
                                                title: state
                                                    .homeCategoryProducts
                                                    .categoryResults[index]
                                                    .categoryName,
                                                id: state
                                                    .homeCategoryProducts
                                                    .categoryResults[index]
                                                    .categoryId,
                                              )),
                                          SizedBox(width: 8)
                                        ],
                                      );
                                    }),
                              ),
                            ),
                            currentId != 0
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Container(
                                      color: Colors.white,
                                      height: 180,
                                      child: Swiper(
                                        itemCount:
                                            state.bannerData.results.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return GestureDetector(
                                            onTap: () {
                                              {}
                                            },
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              width: 270,
                                              height: 125,
                                              imageUrl: state.bannerData
                                                  .results[index].image,
                                              // state
                                              //     .banner[index]
                                              //     .image
                                              //     .image,
                                              //     .image,
                                              placeholder: (context, url) =>
                                                  Center(
                                                      child: SizedBox(
                                                          height: 100,
                                                          child:
                                                              BottomLoader())),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Image.asset(
                                                      "images/logo_gray.png",
                                                      width: 270,
                                                      height: 125),
                                            ),
                                          );
                                        },

                                        // state.banner.length,
                                        // scale: 0.9,
                                        // viewportFraction: 0.8,

                                        autoplay: true,
                                        autoplayDelay: 3000,

                                        pagination: SwiperPagination(
                                            builder: DotSwiperPaginationBuilder(
                                                color: Colors.white,
                                                activeColor: Fins.finsColor,
                                                size: 5.0)),
                                      ),
                                    ),
                                  ),
                            currentId != 0
                                ? Container()
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 22,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8),
                                        child: Text(
                                          "Best Sellers",
                                          style: TextStyle(
                                              color: Fins.titleColor,
                                              fontSize: Fins.bigTitleSize,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        height: Fins.sizedBoxHeight,
                                      ),
                                      Container(
                                        height: 210,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: ListView.builder(
                                              physics:
                                                  AlwaysScrollableScrollPhysics(),
                                              itemCount:
                                                  state.bestSellersData.count,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return BestSellers(
                                                  bestSeller: state
                                                      .bestSellersData
                                                      .results[index],
                                                  homeBloc: homeBloc,
                                                );
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                            ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.homeCategoryProducts
                                    .categoryResults.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: state
                                            .homeCategoryProducts
                                            .categoryResults[index]
                                            .products
                                            .length,
                                        itemBuilder: (context, i) {
                                          return Column(
                                            children: [
                                              MenuItems(
                                                homeBloc: homeBloc,
                                                categoryId: state
                                                    .homeCategoryProducts
                                                    .categoryResults[index]
                                                    .categoryId,
                                                products: state
                                                    .homeCategoryProducts
                                                    .categoryResults[index]
                                                    .products[i],
                                              ),
                                              SizedBox(
                                                height: Fins.sizedBoxHeight,
                                              )
                                            ],
                                          );
                                        }),
                                  );
                                }),
                          ],
                        ),
                      ),
            // floatingActionButton: FloatingActionButton.extended(
            //   backgroundColor: Colors.black,
            //   splashColor: Colors.black,
            //   // focusColor: Colors.black,
            //   // focusColor: Colors.black,
            //   label: Row(
            //     children: [
            //       Icon(
            //         Icons.menu,
            //         color: Colors.white,
            //       ),
            //       Text(
            //         "Menu",
            //         style: TextStyle(color: Colors.white),
            //       )
            //     ],
            //   ),
            //   onPressed: () {
            //     changemenuStatus();
            //     _showMenu(state.homeCategoryProducts);
            //   },
            // ),
            bottomNavigationBar: (state.cartCount != "0" &&
                    state.userLocationInfo.accept &&
                    state.userLocationInfo.location)
                ? SizedBox(
                    height: 50,
                    child: Container(
                      decoration: BoxDecoration(color: Fins.finsColor),
                      child: Padding(
                        padding: EdgeInsets.all(Fins.commonPadding),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              "You added " + state.cartCount + " items",
                              style: TextStyle(
                                  height: Fins.textHeight,
                                  fontSize: Fins.textSize,
                                  color: Colors.white),
                            )),
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  primary: Colors.white,
                                  side: BorderSide(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MyCart()))
                                      .whenComplete(reFetchHome);
                                },
                                child: Text("View Cart",
                                    style: TextStyle(
                                        height: Fins.textHeight,
                                        fontSize: Fins.textSize,
                                        color: Colors.white)))
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(
                    height: 0,
                  ),
          );
        }
        return Container();
      })),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
