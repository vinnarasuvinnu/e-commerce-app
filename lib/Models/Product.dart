import 'package:fins_user/Models/Productinfo.dart';

class Product {
 late int id;
late  String productQuantityTitle;
late  int price;
late  Productinfo product;
 late int weight;
 late int statusId;
 late int discount;
 late int withoutDiscount;
 late int selectedQuantity;
 late bool hasChildren;
late  int storeId;
 late int categoryId;
 late String categoryName;
 late String storeName;
 late bool openStatus;

  Product(
      {required this.id,
     required this.productQuantityTitle,
     required this.price,
     required this.product,
     required this.weight,
     required this.statusId,
     required this.discount,
     required this.withoutDiscount,
     required this.selectedQuantity,
     required this.hasChildren,
     required this.storeId,
     required this.categoryId,
     required this.categoryName,
     required this.storeName,
     required this.openStatus});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productQuantityTitle = json['product_quantity_title'];
    price = json['price'];
    product = json['product'];
    weight = json['weight'];
    statusId = json['status_id'];
    discount = json['discount'];
    withoutDiscount = json['without_discount'];
    selectedQuantity = json['selected_quantity'];
    hasChildren = json['hasChildren'];
    storeId = json['store_id'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    storeName = json['store_name'];
    openStatus = json['open_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_quantity_title'] = this.productQuantityTitle;
    data['price'] = this.price;
    data['product'] = this.product;
    data['weight'] = this.weight;
    data['status_id'] = this.statusId;
    data['discount'] = this.discount;
    data['without_discount'] = this.withoutDiscount;
    data['selected_quantity'] = this.selectedQuantity;
    data['hasChildren'] = this.hasChildren;
    data['store_id'] = this.storeId;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['store_name'] = this.storeName;
    data['open_status'] = this.openStatus;
    return data;
  }
}