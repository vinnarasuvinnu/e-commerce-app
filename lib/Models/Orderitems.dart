


 

class OrderItems {
 late int id;
 late int productQuantityType;
 late String productName;
 late int productPrice;
 late int productQuantity;
late  String productQuantityTitle;
 late String weight;
late  String productImage;
 late int storeId;
 late int orderId;

  OrderItems(
      {required this.id,
      required this.productQuantityType,
     required this.productName,
     required this.productPrice,
     required this.productQuantity,
     required this.productQuantityTitle,
     required this.weight,
     required this.productImage,
     required this.storeId,
     required this.orderId});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productQuantityType = json['product_quantity_type'];
    productName = json['product_name'];
    productPrice = json['product_price'];
    productQuantity = json['product_quantity'];
    productQuantityTitle = json['product_quantity_title'];
    weight = json['weight'];
    productImage = json['product_image'];
    storeId = json['store_id'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_quantity_type'] = this.productQuantityType;
    data['product_name'] = this.productName;
    data['product_price'] = this.productPrice;
    data['product_quantity'] = this.productQuantity;
    data['product_quantity_title'] = this.productQuantityTitle;
    data['weight'] = this.weight;
    data['product_image'] = this.productImage;
    data['store_id'] = this.storeId;
    data['order_id'] = this.orderId;
    return data;
  }
}