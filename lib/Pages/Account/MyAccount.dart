import 'package:cached_network_image/cached_network_image.dart';
import 'package:fins_user/Bloc/Account/myAccountBloc.dart';
import 'package:fins_user/Bloc/Account/myAccountEvent.dart';
import 'package:fins_user/Bloc/Account/myAccountState.dart';
import 'package:fins_user/LoadingListPage.dart';
import 'package:fins_user/Models/Profile.dart';
import 'package:fins_user/Pages/Account/Edit_Account.dart';
import 'package:fins_user/Pages/Loader/bottomLoader.dart';
import 'package:fins_user/utils/NetWordError.dart';
import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  late MyAccountBloc _myAccountBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _myAccountBloc = MyAccountBloc(MyAccountStateUninitialized());
    retrieveData();
  }

  retrieveData() {
    _myAccountBloc.add(FetchMyAccountInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Account"),
        // actions: [
        //   InkWell(
        //     onTap: () {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) => EditAccount(myAcountBloc:_myAccountBloc)));
        //     },
        //     child: Center(
        //       child: Padding(
        //           padding: const EdgeInsets.only(right: 15.0),
        //           child: Text(
        //             "Edit",
        //             style: TextStyle(
        //                 height: Fins.textHeight,
        //                 fontSize: Fins.textSize,
        //                 color: Fins.finsColor),
        //           )),
        //     ),
        //   )
        // ],
      ),
      body: BlocProvider<MyAccountBloc>(
        create: (BuildContext context) {
          return _myAccountBloc;
        },
        child: BlocBuilder<MyAccountBloc, MyAccountState>(
            builder: (context, state) {
          if (state is MyAccountStateUninitialized ||state is  AccountUpdated) {
            return LoadingListPage();
          }
          if (state is MyAccountStateError) {
            return NetworkError();
          }
          if (state is MyAccountLoaded) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(Fins.commonPadding),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: Fins.sizedBoxHeight,
                      ),
                      CachedNetworkImage(
                        imageUrl: "https://london.northumbria.ac.uk/wp-content/uploads/2017/01/600x600-profile-silhouette-m.jpg",
                        imageBuilder: (context, imageProvider) => Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.fill,  )
                          ),
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(color: Fins.finsColor),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      SizedBox(
                        height: Fins.sizedBoxHeight,
                      ),
                      Text(state.profile.name,
                          style: TextStyle(
                              height: Fins.textHeight,
                              fontSize: Fins.textSize,
                              color: Fins.textColor,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: Fins.sizedBoxHeight,
                      ),
                      Text(
                        state.profile.mail,
                        style: TextStyle(
                            height: Fins.textHeight,
                            fontSize: Fins.textSize,
                            color: Fins.textColor),
                      ),
                      SizedBox(
                        height: Fins.sizedBoxHeight,
                      ),
                      Text(state.profile.mobile,
                          style: TextStyle(
                              height: Fins.textHeight,
                              fontSize: Fins.textSize,
                              color: Fins.textColor)),
                      Expanded(
                        child: SizedBox(
                          height: Fins.sizedBoxHeight,
                        ),
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Fins.finsColor,
                          ),
                          SizedBox(
                      height: Fins.sizedBoxHeight,
                      ),
                      Center(
                      child: Text(state.profile.address,textAlign: TextAlign.center,
                          style: TextStyle(
                              height: Fins.textHeight,
                              fontSize: Fins.textSize,
                              color: Fins.textColor)),
                      ),
                          SizedBox(
                      height: Fins.sizedBoxHeight,
                      ),
                        ],
                      ),
                      
                       
              
            
                    ],
                  ),
                ),
              ),
              bottomNavigationBar:  SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  style:ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Fins.finsColor)),
                  onPressed: (){
                  //  Navigator.of(context).pushReplacementNamed("/passwordotp");
                   Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditAccount(myAcountBloc:_myAccountBloc,profile:state.profile))).whenComplete(retrieveData);
                  }, child: Text("Edit",style:TextStyle(height: Fins.textHeight,fontSize:Fins.textSize,))),
              ),
            );
          }
          return Container();
        }),
      ),
    );
  }
}
