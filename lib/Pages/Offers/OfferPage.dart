import 'package:fins_user/Bloc/HomeBloc/home_state.dart';
import 'package:fins_user/Bloc/offersBloc/offersBloc.dart';
import 'package:fins_user/Bloc/offersBloc/offersEvent.dart';
import 'package:fins_user/Bloc/offersBloc/offersState.dart';
import 'package:fins_user/Pages/Cart/MyCart.dart';
import 'package:fins_user/Pages/Offers/OfferItems.dart';
import 'package:fins_user/utils/NetWordError.dart';
import 'package:fins_user/utils/NoOffer.dart';
import 'package:fins_user/utils/NoOrders.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../LoadingListPage.dart';

class OfferPage extends StatefulWidget {
  const OfferPage({Key? key}) : super(key: key);

  @override
  _OfferPageState createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {

  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  late OfferBloc offerBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    offerBloc = OfferBloc(OfferUninitialized());
    retrieveData();
  }
  retrieveData(){
    offerBloc.add(FetchOffers());

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: Fins.titleTextPadding,
        title: Text(
          "Offers",
          style: TextStyle(color: Fins.titleColor, fontSize: Fins.titleSize),
        ),
        // actions: [InkWell(
        //   onTap: (){
        //     Navigator.push(context, MaterialPageRoute(builder: (context)=>MyCart()));
        //   },
        //   child: Text("data",  style: TextStyle(color: Fins.titleColor, fontSize: Fins.titleSize),))],
      ),
      body: BlocProvider<OfferBloc>(create: (BuildContext context) {
        return offerBloc;
      },
        child: BlocBuilder<OfferBloc,OfferState>(builder: (context, state) {
          if(state is OfferUninitialized){
            return LoadingListPage();
          }
          if(state is OfferError){
            return NetworkError();
          }

          if(state is OfferLoaded){
            if(state.offersData.results.isEmpty){
              return NoOffer();
            }

            return RefreshIndicator(
              color: Fins.finsColor,
              onRefresh: ()async{
                retrieveData();
              },
              child: ListView(
                children: [
                  SizedBox(
                    height: Fins.sizedBoxHeight,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(Fins.commonPadding),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.offersData.count,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              OfferItems(offerBloc: offerBloc,offers: state.offersData.results[index],),
                              SizedBox(
                                height: Fins.sizedBoxHeight,
                              )
                            ],
                          );
                        }),
                  ),
                ],
              ),
            );
          }
          return Container();


        }
        ),
      ),
    );
  }
}
