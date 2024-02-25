class DeliveryAddress {
 late int id;
late  String flatNumber;
 late String landMark;
 late String latitude;
 late String longitude;
 late String mapAddress;
 late String addressType;
 late int user; 

  DeliveryAddress(
      {required this.id,
     required  this.flatNumber,
     required  this.landMark,
     required  this.latitude,
     required  this.longitude,
     required  this.mapAddress,
     required  this.addressType,
     required  this.user});

  DeliveryAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    flatNumber = json['flat_number'];
    landMark = json['landMark'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    mapAddress = json['map_address'];
    addressType = json['address_type'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['flat_number'] = this.flatNumber;
    data['landMark'] = this.landMark;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['map_address'] = this.mapAddress;
    data['address_type'] = this.addressType;
    data['user'] = this.user;
    return data;
  }
}