// import 'Order_store.dart';

class Order {
late  int count;
 late String next;
 late String previous;
late  List<ToOrderList> results;

  Order({required this.count, required this.next, required this.previous, required this.results});

  Order.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results =  <ToOrderList>[];
      json['results'].forEach((v) {
        results.add(new ToOrderList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ToOrderList {
 late int id;
late String storeName;

late List<OrderedItems> orderedItems;
late int totalItems;
 late String mapAddress;
late  String latitude;
late  String longitude;
 late double price;
 late double amountPaid;
 late int quantity;
 late String orderDate;
 late String paymentId;
  late int statusId;
 late  String lastModified;
  late double deliveryCharges;
 late double discount;
 late int paymentType;
 late double packingCharge;
late  String adminInstruction;
 late int userId;
  late int orderedStores;

  ToOrderList(
      {required this.id,
     required this.mapAddress,
     required this.storeName,
     required this.orderedItems,
     required this.totalItems,
      required this.latitude,
     required this.longitude,
     required this.price,
     required this.amountPaid,
     required this.quantity,
     required this.orderDate,
     required this.paymentId,
     required this.statusId,
     required this.lastModified,
     required this.deliveryCharges,
     required this.discount,
     required this.paymentType,
     required this.packingCharge,
     required this.adminInstruction,
    required  this.userId,
     required this.orderedStores});

  ToOrderList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeName=json['store_name'];
    // orderedItems=json['ordered_items'];
     if (json['ordered_items'] != null) {
      orderedItems = <OrderedItems>[];
      json['ordered_items'].forEach((v) {
        orderedItems.add(new OrderedItems.fromJson(v));
      });
    }
    totalItems=json['total_items'];
    mapAddress = json['map_address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    price = json['price'];
    amountPaid = json['amount_paid'];
    quantity = json['quantity'];
    orderDate = json['order_date'];
    paymentId = json['payment_id'];
    statusId = json['status_id'];
    lastModified = json['last_modified'];
    deliveryCharges = json['deliveryCharges'];
    discount = json['discount'];
    paymentType = json['payment_type'];
    packingCharge = json['packingCharge'];
    adminInstruction = json['admin_instruction'];
    userId = json['user_id'];
    orderedStores = json['ordered_stores'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data ['store_name']=this.storeName;
    data ['ordered_items']=this.orderedItems;
    data['total_items']=this.totalItems;
    data['map_address'] = this.mapAddress;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['price'] = this.price;
    data['amount_paid'] = this.amountPaid;
    data['quantity'] = this.quantity;
    data['order_date'] = this.orderDate;
    data['payment_id'] = this.paymentId;
    data['status_id'] = this.statusId;
    data['last_modified'] = this.lastModified;
    data['deliveryCharges'] = this.deliveryCharges;
    data['discount'] = this.discount;
    data['payment_type'] = this.paymentType;
    data['packingCharge'] = this.packingCharge;
    data['admin_instruction'] = this.adminInstruction;
    data['user_id'] = this.userId;
    data['ordered_stores'] = this.orderedStores;
    return data;
  }
}
class OrderedItems {
late  String productName;
 late String quantityTitle;
 late int quantity;
 late double price;

  OrderedItems(
      {required this.productName, required this.quantityTitle, required this.quantity, required this.price});

  OrderedItems.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    quantityTitle = json['quantity_title'];
    quantity = json['quantity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['quantity_title'] = this.quantityTitle;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    return data;
  }
}





// class Order {

//  late  int id;
// late List<OrderStore>orderedStores;
//  late String mapAddress;
//  late String latitude;
//  late String longitude;
//  late int price;
//  late int amountPaid;
//  late int quantity;
//  late String orderDate;
//  late String paymentId;
//  late int statusId;
//  late String lastModified;
//  late int deliveryCharges;
//  late int packingCharge;
//  late int tax;
//  late int discount;
//  late int paymentType;
//  late int userId;
//  late Null addressId;
//  late Null productId;
//  late Null deliveryPersonName;
//  late Null deliveryPersonPhone;
//  late String deliveryPersonImage;

//   Order(
//     {required this.id,
//      required this.orderedStores,
//      required this.mapAddress,
//      required this.latitude,
//      required this.longitude,
//      required this.price,
//      required this.amountPaid,
//      required this.quantity,
//      required this.orderDate,
//      required this.paymentId,
//      required this.statusId,
//      required this.lastModified,
//      required this.deliveryCharges,
//      required  this.packingCharge,
//      required  this.tax,
//      required  this.discount,
//      required this.paymentType,
//      required this.userId,
//      required this.addressId,
//      required this.productId,
//      required this.deliveryPersonName,
//      required this.deliveryPersonPhone,
//      required this.deliveryPersonImage});

//    Order.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     orderedStores = json['ordered_stores'];
//     mapAddress = json['map_address'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     price = json['price'];
//     amountPaid = json['amount_paid'];
//     quantity = json['quantity'];
//     orderDate = json['order_date'];
//     paymentId = json['payment_id'];
//     statusId = json['status_id'];
//     lastModified = json['last_modified'];
//     deliveryCharges = json['deliveryCharges'];
//     packingCharge = json['packingCharge'];
//     tax = json['tax'];
//      discount = json['discount'];
//     paymentType = json['payment_type'];
//     userId = json['user_id'];
//     addressId = json['address_id'];
//     productId = json['product_id'];
//     deliveryPersonName = json['deliveryPersonName'];
//     deliveryPersonPhone = json['deliveryPersonPhone'];
//     deliveryPersonImage = json['deliveryPersonImage'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['ordered_stores'] = this.orderedStores;
//     data['map_address'] = this.mapAddress;
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     data['price'] = this.price;
//     data['amount_paid'] = this.amountPaid;
//     data['quantity'] = this.quantity;
//     data['order_date'] = this.orderDate;
//     data['payment_id'] = this.paymentId;
//     data['status_id'] = this.statusId;
//     data['last_modified'] = this.lastModified;
//     data['deliveryCharges'] = this.deliveryCharges;
//     data['packingCharge'] = this.packingCharge;
//     data['tax'] = this.tax;
//     data['discount'] = this.discount;
//     data['payment_type'] = this.paymentType;
//     data['user_id'] = this.userId;
//     data['address_id'] = this.addressId;
//     data['product_id'] = this.productId;
//     data['deliveryPersonName'] = this.deliveryPersonName;
//     data['deliveryPersonPhone'] = this.deliveryPersonPhone;
//     data['deliveryPersonImage'] = this.deliveryPersonImage;
//     return data;
//   }
// }