import 'package:cloud_firestore/cloud_firestore.dart';

class Coupon {
  final String couponId;
  final String storeId;
  final String couponName;
  final int discount;
  final int minPrice;
  final List getUser;
  final List useUser;
  final List type;
  final Timestamp creatDate;

  Coupon({
    required this.couponName,
    required this.couponId,
    required this.storeId,
    required this.discount,
    required this.minPrice,
    required this.getUser,
    required this.useUser,
    required this.type,
    required this.creatDate,
  });
  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      couponId: json["couponId"],
      couponName: json["couponName"],
      storeId:json["storeId"],
      discount: json["discount"],
      minPrice: json["minPrice"],
      getUser: json["getUser"],
      useUser: json["useUser"],
      type: json["type"],
      creatDate: json["creatDate"],
    );
  }
    Map<String, dynamic> toJson() {
      return {
        'couponId': couponId,
        'discount': discount,
        'couponName': couponName,
        'storeId':storeId,
        'minPrice': minPrice,
        'getUser': getUser,
        'useUser': useUser,
        'type': type,
        'creatDate': creatDate,
      };
    }
}
