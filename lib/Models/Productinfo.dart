import 'ProductImage.dart';

class Productinfo {
 late int id;
 late String name;
 late String description;
late List<ProductImage> productImageIds;
 late int productType;

  Productinfo(
      {required this.id,
     required this.name,
     required this.description,
     required this.productImageIds,
     required this.productType});

  Productinfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    productImageIds = json['product_image_ids'];
    productType = json['product_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['product_image_ids'] = this.productImageIds;
    data['product_type'] = this.productType;
    return data;
  }
}