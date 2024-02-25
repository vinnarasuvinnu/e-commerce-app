class CartStore {
 late String name;
 late int id;
 late String city;
 late int orders;
 late int price;
 late int discount;
 late int weight;
 late bool cashOnDelivery;
late  int deliveryCharge;
 late int packingCharge;
 late double distance;
 late String deliveryMinutes;
 late int minimumCharge;
late String razorPay;
 late int amountPaid;
late String phone;
 late String email;

  CartStore(
      {required this.name,
     required this.id,
     required this.city,
     required this.orders,
     required this.price,
    required  this.discount,
    required  this.weight,
    required  this.cashOnDelivery,
    required  this.deliveryCharge,
     required this.packingCharge,
     required this.distance,
     required this.deliveryMinutes,
     required this.minimumCharge,
     required this.razorPay,
     required this.amountPaid,
     required  this.phone,
    required  this.email
     });

  CartStore.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    city = json['city'];
    orders = json['orders'];
    price = json['price'];
    discount = json['discount'];
    weight = json['weight'];
    cashOnDelivery = json['cash_on_delivery'];
    deliveryCharge = json['deliveryCharge'];
    packingCharge = json['packingCharge'];
    distance = json['distance'];
    deliveryMinutes = json['deliveryMinutes'];
    minimumCharge = json['minimum_charge'];
      razorPay = json['razor_pay'];
    amountPaid = json['amount_paid'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['city'] = this.city;
    data['orders'] = this.orders;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['weight'] = this.weight;
    data['cash_on_delivery'] = this.cashOnDelivery;
    data['deliveryCharge'] = this.deliveryCharge;
    data['packingCharge'] = this.packingCharge;
    data['distance'] = this.distance;
    data['deliveryMinutes'] = this.deliveryMinutes;
    data['minimum_charge'] = this.minimumCharge;
    data['razor_pay'] = this.razorPay;
    data['amount_paid'] = this.amountPaid;
     data['phone'] = this.phone;
    data['email'] = this.email;
    return data;
  }
}






//class CartStore {
//  late String name;
//  late int id;
//  late String city;
// late  int orders;
//  late int price;
//  late int weight;
//  late int discount;
//  late String logo;
// late  int storeType;
// late  int deliveryPacking;
// late  bool cashOnDelivery;
// late  bool deliveryCharge;
// late  bool packingCharge;
// late  double distance;
//  late String deliveryMinutes;
//  late int minimumCharge;
//  late int freeDeliveryCost;
//  late bool deliveryTax;
// late  int freeDeliveryMax;

//   CartStore(
//       {required this.name,
//      required this.id,
//      required this.city,
//      required this.orders,
//      required this.price,
//       required this.weight,
//     required  this.discount,
//      required this.logo,
//      required this.storeType,
//      required this.deliveryPacking,
//      required this.cashOnDelivery,
//      required this.deliveryCharge,
//     required  this.packingCharge,
//      required this.distance,
//      required this.deliveryMinutes,
//      required this.minimumCharge,
//      required this.freeDeliveryCost,
//      required this.deliveryTax,
//      required this.freeDeliveryMax});

//   CartStore.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     id = json['id'];
//     city = json['city'];
//     orders = json['orders'];
//     price = json['price'];
//     weight = json['weight'];
//     discount = json['discount'];
//     logo = json['logo'];
//     storeType = json['store_type'];
//     deliveryPacking = json['delivery_packing'];
//     cashOnDelivery = json['cash_on_delivery'];
//     deliveryCharge = json['deliveryCharge'];
//     packingCharge = json['packingCharge'];
//     distance = json['distance'];
//     deliveryMinutes = json['deliveryMinutes'];
//     minimumCharge = json['minimum_charge'];
//     freeDeliveryCost = json['free_delivery_cost'];
//     deliveryTax = json['deliveryTax'];
//     freeDeliveryMax = json['free_delivery_max'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['id'] = this.id;
//     data['city'] = this.city;
//     data['orders'] = this.orders;
//     data['price'] = this.price;
//     data['weight'] = this.weight;
//     data['discount'] = this.discount;
//     data['logo'] = this.logo;
//     data['store_type'] = this.storeType;
//     data['delivery_packing'] = this.deliveryPacking;
//     data['cash_on_delivery'] = this.cashOnDelivery;
//     data['deliveryCharge'] = this.deliveryCharge;
//     data['packingCharge'] = this.packingCharge;
//     data['distance'] = this.distance;
//     data['deliveryMinutes'] = this.deliveryMinutes;
//     data['minimum_charge'] = this.minimumCharge;
//     data['free_delivery_cost'] = this.freeDeliveryCost;
//     data['deliveryTax'] = this.deliveryTax;
//     data['free_delivery_max'] = this.freeDeliveryMax;
//     return data;
//   }
// }