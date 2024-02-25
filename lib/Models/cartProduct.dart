

import 'package:fins_user/Models/Product.dart';



class CartProduct {
 late int count;
 late String next;
 late String previous;
 late List<ProductList> results;

  CartProduct({required this.count, required this.next, required this.previous, required this.results});

  CartProduct.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <ProductList>[];
      json['results'].forEach((v) {
        results.add(new ProductList.fromJson(v));
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

class ProductList {
 late int id;
 late String image;
 late String name;
late  int weight;
 late String productQuantityTitle;
 late int price;
 late int withoutDiscount;
 late int discount;
 late String createdOn;
 late int quantity;
late  int createdBy;
 late int productId;
late  int storeId;

  ProductList(
      {required this.id,
      required this.image,
      required this.name,
     required this.weight,
     required this.productQuantityTitle,
     required this.price,
     required this.withoutDiscount,
    required this.discount,
     required this.createdOn,
     required this.quantity,
     required this.createdBy,
      required  this.productId,
      required this.storeId});

  ProductList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
     name = json['name'];
    weight = json['weight'];
    productQuantityTitle = json['product_quantity_title'];
    price = json['price'];
    withoutDiscount = json['without_discount'];
       discount = json['discount'];
    createdOn = json['created_on'];
    quantity = json['quantity'];
    createdBy = json['created_by'];
    productId = json['product_id'];
    storeId = json['store_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
     data['name'] = this.name;
    data['weight'] = this.weight;
    data['product_quantity_title'] = this.productQuantityTitle;
    data['price'] = this.price;
    data['without_discount'] = this.withoutDiscount;
     data['discount'] = this.discount;
    data['created_on'] = this.createdOn;
    data['quantity'] = this.quantity;
    data['created_by'] = this.createdBy;
    data['product_id'] = this.productId;
    data['store_id'] = this.storeId;
    return data;
  }
}





// class CartProduct{
//  late  int id;
//  late Product productId;
//  late String createdOn;
//  late int quantity;
//  late int createdBy;
//  late int storeId;

//   CartProduct(
//       {required this.id,
//       required this.productId,
//      required this.createdOn,
//      required this.quantity,
//      required this.createdBy,
//      required this.storeId});

//   CartProduct.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     productId = json['product_id'];
//     createdOn = json['created_on'];
//     quantity = json['quantity'];
//     createdBy = json['created_by'];
//     storeId = json['store_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['product_id'] = this.productId;
//     data['created_on'] = this.createdOn;
//     data['quantity'] = this.quantity;
//     data['created_by'] = this.createdBy;
//     data['store_id'] = this.storeId;
//     return data;
//   }
// }