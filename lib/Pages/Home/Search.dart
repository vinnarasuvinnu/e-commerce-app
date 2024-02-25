import 'package:cached_network_image/cached_network_image.dart';
import 'package:fins_user/Bloc/search_bloc/searchBloc.dart';
import 'package:fins_user/Bloc/search_bloc/searchEvent.dart';
import 'package:fins_user/Bloc/search_bloc/searchState.dart';
import 'package:fins_user/LoadingListPage.dart';
import 'package:fins_user/Pages/Loader/bottomLoader.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchItems extends StatefulWidget {
  const SearchItems({Key? key}) : super(key: key);

  @override
  _SearchItemsState createState() => _SearchItemsState();
}

class _SearchItemsState extends State<SearchItems> {
  late SearchBloc searchBloc;

  final searchController = TextEditingController();

  var itemCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchBloc = SearchBloc(SearchLoading());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Search",
          style: TextStyle(
            color: Fins.titleColor,
            fontSize: Fins.titleSize,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: Fins.commonPadding,
                      right: Fins.commonPadding,
                      bottom: Fins.commonPadding),
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      onChanged: (value) {
                        if (value.length > 1) {
                          searchBloc
                              .add(SearchUserEvent(searchController: value));
                        }
                      },
                      cursorColor: Fins.finsColor,
                      controller: searchController,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          suffixIcon: Icon(
                            Icons.search_outlined,
                            color: Fins.finsColor,
                          ),
                          hintText: "Search",
                          hintStyle: TextStyle(
                              height: Fins.textHeight, fontSize: Fins.textSize),
                          contentPadding: EdgeInsets.all(8),
                          border: OutlineInputBorder()),
                      autofocus: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocProvider(
        create: (BuildContext context) {
          return searchBloc;
        },
        child: BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
          if (state is SearchUninitialized) {
            return LoadingListPage();
          }
          if (state is SearchLoading) {
            return SingleChildScrollView(
              child: Container(
                child: Center(child: Image.asset("images/search.png")),
              ),
            );
          }
          if (state is SearchError) {
            return SingleChildScrollView(
              child: Container(
                child: Center(child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text("Product not found"),
                    ),
                    Image.asset("images/notFound.png"),
                  ],
                )),
              ),
            );
          }
          if (state is SearchSuccess) {
            if (state.searchData.results.isEmpty) {
              return SingleChildScrollView(
                child: Container(
                  child: Center(child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text("Search not found"),
                      ),
                      Image.asset("images/notFound.png"),
                    ],
                  )),
                ),
              );
            }

            return ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: state.searchData.results.length,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      // SizedBox(
                      //   height:8,
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 170,
                                      width: MediaQuery.of(context).size.width,
                                      child: CachedNetworkImage(
                                        imageUrl: state.searchData.results[i]
                                            .productImageIds,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          height: 170,
                                          width:
                                              MediaQuery.of(context).size.width,
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
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                          "images/logo_gray.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    (state.searchData.results[i]
                                                .without_discount !=
                                            state.searchData.results[i].price)
                                        ? Positioned(
                                            bottom: 0,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Fins.finsColor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  10))),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0,
                                                    right: 8,
                                                    top: 4,
                                                    bottom: 4),
                                                child: Text(
                                                  // widget.products.discount.toString() +
                                                  state.searchData.results[i]
                                                          .discount
                                                          .toString() +
                                                      " % Offer",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container()
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)),
                                    border:
                                        Border.all(color: Color(0xffe0e0e0))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    state.searchData.results[i]
                                                        .name,
                                                    style: TextStyle(
                                                      height: Fins.textHeight,
                                                      fontSize: Fins.textSize,
                                                    )),
                                                Text(
                                                    state.searchData.results[i]
                                                        .description,
                                                    style: TextStyle(
                                                        height: Fins.textHeight,
                                                        fontSize:
                                                            Fins.textSmallSize,
                                                        color: Fins
                                                            .secondaryTextColor)),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              // mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                    child: (state
                                                                .searchData
                                                                .results[i]
                                                                .selected_count ==
                                                            0)
                                                        ? SizedBox(
                                                            height: 30,
                                                            width: 90,
                                                            child: (state.searchData.results[i].inStock==0)?ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                primary: Colors.grey,

                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(
                                                                        Fins.buttonRadius)),
                                                              ),
                                                              onPressed: null,
                                                              child: Text("ADD"),
                                                            ):TextButton(
                                                              style: TextButton
                                                                  .styleFrom(
                                                                primary: Colors
                                                                    .white,
                                                                backgroundColor:
                                                                    Fins.finsColor,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            Fins.buttonRadius)),
                                                              ),
                                                              onPressed: () {
                                                                setState(() {
                                                                  searchBloc.add(AddSearchProduct(
                                                                      productId: state
                                                                          .searchData
                                                                          .results[
                                                                              i]
                                                                          .id
                                                                          .toString()));
                                                                });
                                                              },
                                                              child:
                                                                  Text("ADD"),
                                                            ),
                                                          )
                                                        : Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5),
                                                            child: SizedBox(
                                                                height: 30,
                                                                width: 90,
                                                                child: Row(
                                                                  children: [
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          searchBloc
                                                                              .add(SubtractSearchProduct(productId: state.searchData.results[i].id.toString()));
                                                                          1;
                                                                        });
                                                                      },
                                                                      child:
                                                                          AnimatedContainer(
                                                                        duration:
                                                                            Duration(milliseconds: 1000),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Fins.finsColor,
                                                                            borderRadius: BorderRadius.circular(5)),
                                                                        height:
                                                                            30,
                                                                        width:
                                                                            30,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          30,
                                                                      width: 30,
                                                                      child: Center(
                                                                          child: Text(
                                                                        state
                                                                            .searchData
                                                                            .results[i]
                                                                            .selected_count
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Fins.finsColor),
                                                                      )),
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          searchBloc
                                                                              .add(AddSearchProduct(productId: state.searchData.results[i].id.toString()));
                                                                        });
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Fins.finsColor,
                                                                            borderRadius: BorderRadius.circular(5)),
                                                                        height:
                                                                            30,
                                                                        width:
                                                                            30,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .add,
                                                                          color:
                                                                              Colors.white,
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
                                                state.searchData.results[i]
                                                        .weight
                                                        .toString() +
                                                    state.searchData.results[i]
                                                        .productQuantityTitle,
                                                style: TextStyle(
                                                    height: Fins.textHeight,
                                                    fontSize: Fins.textSize,
                                                    color: Fins
                                                        .secondaryTextColor)),
                                          ),
                                          (state.searchData.results[i]
                                                      .without_discount ==
                                                  state.searchData.results[i]
                                                      .price)
                                              ? SizedBox(
                                                  width: 90,
                                                  child: Text(
                                                    "₹" +
                                                        state
                                                            .searchData
                                                            .results[i]
                                                            .without_discount
                                                            .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: Fins.textSize,
                                                        height: Fins.textHeight,
                                                        color: Fins.textColor),
                                                  ),
                                                )
                                              : Row(
                                                  children: [
                                                    Text(
                                                      "₹" +
                                                          state
                                                              .searchData
                                                              .results[i]
                                                              .without_discount
                                                              .toString(),
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          fontSize:
                                                              Fins.textSize,
                                                          height:
                                                              Fins.textHeight,
                                                          color: Fins
                                                              .secondaryTextColor),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          Fins.sizedBoxHeight,
                                                    ),
                                                    Text(
                                                      "₹" +
                                                          state.searchData
                                                              .results[i].price
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontSize:
                                                              Fins.textSize,
                                                          height:
                                                              Fins.textHeight,
                                                          color:
                                                              Fins.textColor),
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
                        ),
                      ),
                    ],
                  );
                });
          }
          return Container();
        }),
      ),
    );
  }
}
