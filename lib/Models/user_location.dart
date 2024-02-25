class UserLocationInfo {
  late bool location;
  late String address;
  late bool accept;

  UserLocationInfo({required this.location, required this.address, required this.accept});

  UserLocationInfo.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    address = json['address'];
    accept = json['accept'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = this.location;
    data['address'] = this.address;
    data['accept'] = this.accept;
    return data;
  }
}