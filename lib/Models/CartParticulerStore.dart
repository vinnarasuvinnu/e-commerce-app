import 'package:fins_user/Models/cartStore.dart';

class CartParticulerStore {
 late String result;
 late String resultCode;
 late CartStore description;

  CartParticulerStore({required this.result, required this.resultCode, required this.description});

  CartParticulerStore.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    resultCode = json['result_code'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['result_code'] = this.resultCode;
    data['description'] = this.description;
    return data;
  }
}