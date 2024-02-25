class OrderStore {
 late int id;
 late String storeName;
 late int storeType;
 late String storePlace;
 late int storeId;
 late String storeLogo;
 late int numberOfItems;
 late int total;
 late bool storeCategory;

  OrderStore(
      {required this.id,
      required this.storeName,
     required this.storeType,
     required this.storePlace,
     required this.storeId,
     required this.storeLogo,
     required this.numberOfItems,
     required this.total,
     required this.storeCategory});

  OrderStore.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeName = json['store_name'];
    storeType = json['store_type'];
    storePlace = json['store_place'];
    storeId = json['store_id'];
    storeLogo = json['store_logo'];
    numberOfItems = json['numberOfItems'];
    total = json['total'];
    storeCategory = json['store_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_name'] = this.storeName;
    data['store_type'] = this.storeType;
    data['store_place'] = this.storePlace;
    data['store_id'] = this.storeId;
    data['store_logo'] = this.storeLogo;
    data['numberOfItems'] = this.numberOfItems;
    data['total'] = this.total;
    data['store_category'] = this.storeCategory;
    return data;
  }
}
