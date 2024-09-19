import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String email;
  final String name;
  final String address;
  final String postcode;
  final String addressDetail;
  final String fcmToken;
  final int memberLevel;
  final bool adultCertificationYn;
  final Timestamp creatDate;

  User({required this.id,required this.email,required this.fcmToken,required this.name,required this.address,required this.postcode,required this.addressDetail,required this.memberLevel ,required this.adultCertificationYn,required this.creatDate});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      email: json["email"],
      name:json["name"],
      address:json["address"],
      addressDetail:json["addressDetail"],
      fcmToken:json["fcmToken"],
      postcode:json["postcode"],
      memberLevel:json["memberLevel"],
      adultCertificationYn:json["adultCertificationYn"],
      creatDate:json["creatDate"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "name":name,
      "address":address,
      "postcode":postcode,
      "fcmToken":fcmToken,
      "addressDetail":addressDetail,
      "memberLevel":memberLevel,
      "adultCertificationYn":adultCertificationYn,
      "creatDate":creatDate,
    };
  }
}

