class BestSellersData {
  late int count;
  late String next;
  late String previous;
  late List<BestSeller> results;

  BestSellersData(
      {required this.count,
      required this.next,
      required this.previous,
      required this.results});

  BestSellersData.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <BestSeller>[];
      json['results'].forEach((v) {
        results.add(new BestSeller.fromJson(v));
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

class BestSeller {
  late int selected_count;
  late int without_discount;
  late int id;
  late int productType;
  late int price;
  late int weight;
  late int statusId;
  late int inStock;
  late String name;
  late String description;
  late int discount;
  late String discountStartDate;
  late String discountEndDate;
  late bool isRoot;
  late bool hasChildren;
  late String date;
  late String createdOn;
  late String lastModified;
  late int foodType;
  late String productImageIds;
  late int storeId;
  late String productQuantityTitle;
  late int categoryId;
  late int createdBy;

  BestSeller(
      {required this.selected_count,
      required this.without_discount,
      required this.id,
      required this.productType,
      required this.price,
      required this.weight,
      required this.statusId,
      required this.inStock,
      required this.name,
      required this.description,
      required this.discount,
      required this.discountStartDate,
      required this.discountEndDate,
      required this.isRoot,
      required this.hasChildren,
      required this.date,
      required this.createdOn,
      required this.lastModified,
      required this.foodType,
      required this.productImageIds,
      required this.storeId,
      required this.productQuantityTitle,
      required this.categoryId,
      required this.createdBy});

  BestSeller.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    selected_count = json['selected_count'];

    without_discount = json['without_discount'];
    productType = json['product_type'];
    price = json['price'];
    weight = json['weight'];
    statusId = json['status_id'];
    inStock = json['in_stock'];
    name = json['name'];
    description = json['description'];
    discount = json['discount'];
    discountStartDate = json['discount_start_date'];
    discountEndDate = json['discount_end_date'];
    isRoot = json['isRoot'];
    hasChildren = json['hasChildren'];
    date = json['date'];
    createdOn = json['created_on'];
    lastModified = json['last_modified'];
    foodType = json['food_type'];
    productImageIds = json['product_image_ids'];
    storeId = json['store_id'];
    productQuantityTitle = json['product_quantity_title'];
    categoryId = json['category_id'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['selected_count'] = this.selected_count;

    data['without_discount'] = this.without_discount;
    data['product_type'] = this.productType;
    data['price'] = this.price;
    data['weight'] = this.weight;
    data['status_id'] = this.statusId;
    data['in_stock'] = this.inStock;
    data['name'] = this.name;
    data['description'] = this.description;
    data['discount'] = this.discount;
    data['discount_start_date'] = this.discountStartDate;
    data['discount_end_date'] = this.discountEndDate;
    data['isRoot'] = this.isRoot;
    data['hasChildren'] = this.hasChildren;
    data['date'] = this.date;
    data['created_on'] = this.createdOn;
    data['last_modified'] = this.lastModified;
    data['food_type'] = this.foodType;
    data['product_image_ids'] = this.productImageIds;
    data['store_id'] = this.storeId;
    data['product_quantity_title'] = this.productQuantityTitle;
    data['category_id'] = this.categoryId;
    data['created_by'] = this.createdBy;
    return data;
  }
}
