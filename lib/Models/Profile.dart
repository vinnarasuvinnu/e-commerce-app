class Profile {
 late String name;
 late String mail;
 late String mobile;
  late String address;

  Profile({required this.name, required this.mail, required this.address,required this.mobile});

  Profile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mail = json['mail'];
    mobile =json['mobile'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mail'] = this.mail;
    data['mobile']=this.mobile;
    data['address'] = this.address;
    return data;
  }
}