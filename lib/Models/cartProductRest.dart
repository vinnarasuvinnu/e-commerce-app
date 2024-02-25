import 'package:fins_user/Models/cartProduct.dart';

class CartProductRest {
 late int count;
late  String next;
late  String previous;
 late List<CartProduct> results;

  CartProductRest({required this.count, required this.next, required this.previous, required this.results});

  CartProductRest.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    results = json['results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    data['results'] = this.results;
    return data;
  }
}