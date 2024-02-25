class BannerData {
  late int count;
  late String next;
  late String previous;
  late List<BannerItem> results;

  BannerData({required this.count, required this.next, required this.previous, required this.results});

  BannerData.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <BannerItem>[];
      json['results'].forEach((v) {
        results.add(new BannerItem.fromJson(v));
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

class BannerItem {
  late int id;
  late String image;
  late String title;
  late String latitude;
  late String longitude;
  late int rating;
  late bool bannerStatus;
  late String createdOn;
  late int storeUserId;

  BannerItem(
      {required this.id,
        required this.image,
        required this.title,
        required this.latitude,
        required this.longitude,
        required this.rating,
        required this.bannerStatus,
        required this.createdOn,
        required this.storeUserId});

  BannerItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    rating = json['rating'];
    bannerStatus = json['banner_status'];
    createdOn = json['created_on'];
    storeUserId = json['store_user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['title'] = this.title;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['rating'] = this.rating;
    data['banner_status'] = this.bannerStatus;
    data['created_on'] = this.createdOn;
    data['store_user_id'] = this.storeUserId;
    return data;
  }
}