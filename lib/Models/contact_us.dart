class ContactUs {
  late String phone;
  late String mail;

  ContactUs({required this.phone, required this.mail});

  ContactUs.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    mail = json['mail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['mail'] = this.mail;
    return data;
  }
}