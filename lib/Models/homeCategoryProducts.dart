class HomeCategoryProducts {
  late List<CategoryResults> categoryResults;

  HomeCategoryProducts({required this.categoryResults});

  HomeCategoryProducts.fromJson(Map<String, dynamic> json) {
    if (json['category_results'] != null) {
      categoryResults = <CategoryResults>[];
      json['category_results'].forEach((v) {
        categoryResults.add(new CategoryResults.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categoryResults != null) {
      data['category_results'] =
          this.categoryResults.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryResults {
  late int categoryId;
  late String categoryName;
  late int count;
  late List<Products> products;

  CategoryResults(
      {required this.categoryId,
      required this.categoryName,
      required this.count,
      required this.products});

  CategoryResults.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    count = json['count'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['count'] = this.count;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  late int without_discount;
  late String name;
  late int id;
  late int selected_count;
  late int price;
  late int weight;
  late String description;
  late String image;
  late String quantity;
  late int inStock;
  late int discount;

  Products(
      {required this.selected_count,
        required this.without_discount,
        required this.name,
      required this.id,
      required this.price,
      required this.weight,
      required this.description,
      required this.image,
      required this.inStock,required this.discount,required this.quantity});

  Products.fromJson(Map<String, dynamic> json) {
    without_discount = json['without_discount'];
    name = json['name'];
    selected_count = json['selected_count'];

    id = json['id'];
    price = json['price'];
    weight = json['weight'];
    description = json['description'];
    image = json['image'];
    inStock = json['in_stock'];
    discount = json['discount'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['selected_count'] = this.selected_count;

    data['without_discount'] = this.without_discount;
    data['id'] = this.id;
    data['price'] = this.price;
    data['weight'] = this.weight;
    data['description'] = this.description;
    data['image'] = this.image;
    data['in_stock'] = this.inStock;
    data['discount'] = this.discount;
    data['quantity'] = this.quantity;
    return data;
  }
}
