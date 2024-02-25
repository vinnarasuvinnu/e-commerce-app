import 'package:fins_user/Bloc/authenticationBloc/authenticationBloc.dart';
import 'package:fins_user/Pages/Account/password_Change_OTP.dart';
import 'package:fins_user/Pages/intro_screen.dart';
import 'package:fins_user/repository/userRepository.dart';
import 'package:fins_user/swiper.dart';
import 'package:fins_user/utils/shimmer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/authenticationBloc/authenticationEvent.dart';
import 'Bloc/authenticationBloc/authenticationState.dart';
import 'Pages/Account/Change_Password.dart';
import 'Pages/Account/Login.dart';
import 'initial_Screen.dart';

late AuthenticationBloc _authenticationBloc;

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onChange(Cubit cubit, Change change) {
    print(change);
    super.onChange(cubit, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(cubit, error, stackTrace);
  }
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance
      .setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  Bloc.observer = SimpleBlocObserver();
  final userRepository = UserRepository();
  _authenticationBloc = AuthenticationBloc(AuthenticationUninitialized());
  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) {
      return _authenticationBloc
        ..add(AppStarted());
    },
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          splashColor: Colors.red[100],
          accentColor: Colors.red[100],
          // primaryColor: Fins.finsColor,


          fontFamily: "Roboto",
          primaryTextTheme: TextTheme(
              subtitle1: TextStyle(color: Color(0xfff2c2c2c), fontSize: 18)),
          appBarTheme: AppBarTheme(
            titleSpacing: 0,
            backgroundColor: Colors.white,
            // color: Colors.black,
            titleTextStyle: TextStyle(color: Colors.black),
            iconTheme: IconThemeData(color: Colors.black),

// color: Colors.white,

// titleTextStyle: TextStyle(
//     color: Colors.red,
//     fontSize: 18)
          )),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new Login(),
        '/changePassword': (BuildContext contex) => new ChangePassword(),
        '/passwordotp': (BuildContext contex) => new PasswordOTP(),
      },
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (BuildContext context, AuthenticationState state) {
        if (state is AuthenticationUninitialized) {
          return LoadingListPage();
        }
        if (state is AuthenticationInitialized) {
          return SwipePage();
        }
        if (state is AuthenticationHomeScreen) {
          return InitialScreen();
        }
        return Container();
      }),

// routes: {'/':(context)=> InitialScreen()},
    ),
  ));
}
// class MyApp extends StatefulWidget {
//   const MyApp({ Key? key }) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     super.initState();
//   _naviagat();
//   }

//   _naviagat(){
//     Navigator.push(context, MaterialPageRoute(builder: (context)=>InitialScreen()));
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child:_naviagat()

//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // return MaterialApp(
//     //   title: 'Flutter Demo',
//     //   // theme: ThemeData(

//     //   //   primarySwatch: Colors.blue,
//     //   // ),
//     //   home: MyHomePage(title: 'Flutter Demo Home Page'),
//     // );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key,}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   // int _counter = 0;

//   // void _incrementCounter() {
//   //   setState(() {

//   //     _counter++;
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       appBar: AppBar(

//         title: Text(widget.title),
//       ),
//       body: Center(

//         child: Column(

//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
