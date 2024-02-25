class CouponsList {
  late int count;
  late String next;
  late String previous;
  late List<Coupons> results;

  CouponsList({required this.count, required this.next, required this.previous, required this.results});

  CouponsList.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Coupons>[];
      json['results'].forEach((v) {
        results.add(new Coupons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['coupons'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Coupons {
  late String shopName;
  late int shopId;
  late String image;
  late double distance;
  late double rating;
  late String afford;
  late String offer;
  late String special;
  late int status;
  late int time;
  late String storeOpensTime;

  Coupons(
      {required this.shopName,
        required this.shopId,
        required this.image,
        required this.distance,
        required this.rating,
        required this.afford,
        required this.offer,
        required this.special,
        required this.status,
        required this.time,
        required this.storeOpensTime});

  Coupons.fromJson(Map<String, dynamic> json) {
    shopName = json['shop_name'];
    shopId = json['shop_id'];
    image = json['image'];
    distance = json['distance'];
    rating = json['rating'];
    afford = json['afford'];
    offer = json['offer'];
    special = json['special'];
    status = json['status'];
    time = json['time'];
    storeOpensTime = json['store_opens_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shop_name'] = this.shopName;
    data['shop_id'] = this.shopId;
    data['image'] = this.image;
    data['distance'] = this.distance;
    data['rating'] = this.rating;
    data['afford'] = this.afford;
    data['offer'] = this.offer;
    data['special'] = this.special;
    data['status'] = this.status;
    data['time'] = this.time;
    data['store_opens_time'] = this.storeOpensTime;
    return data;
  }
}