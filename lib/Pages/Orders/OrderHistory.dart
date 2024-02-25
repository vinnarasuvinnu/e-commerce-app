// import 'package:fins_user/Pages/Cart/MyCart.dart';
// import 'package:fins_user/Pages/Orders/MyOrders.dart';
// import 'package:fins_user/utils/finsStandard.dart';
// import 'package:flutter/material.dart';

// class OrderHistory extends StatefulWidget {
//   const OrderHistory({ Key? key }) : super(key: key);

//   @override
//   _OrderHistoryState createState() => _OrderHistoryState();
// }

// class _OrderHistoryState extends State<OrderHistory> {
//   @override
//   Widget build(BuildContext context) {
  
//     return DefaultTabController(length: 2, child:Scaffold(
//       appBar: AppBar(title: TabBar(
//           labelStyle: TextStyle(height: Fins.textHeight,fontSize:Fins.textSize),
//               indicatorColor: Fins.finsColor,
//               labelColor: Fins.finsColor,
//               unselectedLabelColor: Fins.secondaryTextColor,
          

//         tabs: [
//            Tab(text: "My Cart",),
//           Tab(text:"My Orders"),
         

//         ],
//       ),),
//       body: TabBarView(
//         physics: NeverScrollableScrollPhysics(),
//         children: [
//        MyCart(),
//         MyOrders(),
//       ],),
      
//       ),
//     );
   
//   }
// }