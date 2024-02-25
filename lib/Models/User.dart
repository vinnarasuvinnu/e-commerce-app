class User {
  late int id;
  late String username;
  late String firstName;
  late String email;
  late String avatar;
  late String mapAddress;
  late int gender;
  late String deliveryAddress;

  User(
      {required this.id,
      required this.username,
      required this.firstName,
      required this.email,
      required this.avatar,
      required this.mapAddress,
      required this.gender,
      required this.deliveryAddress});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    email = json['email'];
    avatar = json['avatar'];
    mapAddress = json['map_address'];
    gender = json['gender'];
    deliveryAddress = json['delivery_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['first_name'] = this.firstName;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    data['map_address'] = this.mapAddress;
    data['gender'] = this.gender;
    data['delivery_address'] = this.deliveryAddress;
    return data;
  }
}
