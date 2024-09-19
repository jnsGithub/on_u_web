import 'package:cloud_firestore/cloud_firestore.dart';

class Payment {
  final String id;
  final String orderName;
  final String userName;
  final String userId;
  final String userHp;
  final String address;
  final String addressDetail;
  final String postcode;
  final String method;
  final String purchasedAt;
  final String memo;
  final String cardCompany;
  final String cardNo;
  final String itemType;
  final String status;
  final String storeName;
  final String storeId;
  final String couponId;
  final List itemList;
  final int coupon;
  final int tip;
  final int price;
  final Timestamp creatDate;

  Payment({
    required this.coupon,
    required this.couponId,
    required this.id,
    required this.orderName,
    required this.userName,
    required this.userId,
    required this.userHp,
    required this.address,
    required this.addressDetail,
    required this.postcode,
    required this.method,
    required this.purchasedAt,
    required this.memo,
    required this.cardCompany,
    required this.cardNo,
    required this.itemType,
    required this.itemList,
    required this.status,
    required this.storeName,
    required this.storeId,
    required this.tip,
    required this.price,
    required this.creatDate,
  });

  // fromMap factory constructor for creating an Order instance from a map
  factory Payment.fromMap(Map<String, dynamic> data) {
    return Payment(
      id: data['id'] ?? '',
      orderName: data['orderName'] ?? '',
      userName:data['userName']??'',
      userId: data['userId'] ?? '',
      userHp: data['userHp'] ?? '',
      address: data['address'] ?? '',
      addressDetail: data['addressDetail'] ?? '',
      postcode: data['postcode'] ?? '',
      method: data['method'] ?? '',
      purchasedAt: data['purchasedAt'] ?? '',
      memo: data['memo'] ?? '',
      cardCompany: data['cardCompany'] ?? '',
      cardNo: data['cardNo'] ?? '',
      itemType: data['itemType'] ?? '',
      status:data['status']??'',
      storeName:data['storeName']??'',
      storeId:data['storeId']??'',
      couponId: data['couponId'] ?? '',
      itemList: data['itemList'] ?? [],
      coupon: data['coupon'] ?? 0,
      tip: data['tip'] ?? 0,
      price: data['price'] ?? 0,
      creatDate: data['creatDate'] ?? Timestamp.now(),
    );
  }
  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'] ?? '',
      orderName: json['orderName'] ?? '',
      userName:json['userName']??'',
      userId: json['userId'] ?? '',
      userHp: json['userHp'] ?? '',
      address: json['address'] ?? '',
      addressDetail: json['addressDetail'] ?? '',
      postcode: json['postcode'] ?? '',
      method: json['method'] ?? '',
      purchasedAt: json['purchasedAt'] ?? '',
      memo: json['memo'] ?? '',
      cardCompany: json['cardCompany'] ?? '',
      cardNo: json['cardNo'] ?? '',
      itemType: json['itemType'] ?? '',
      status:json['status']??'',
      storeName:json['storeName']??'',
      storeId:json['storeId']??'',
      couponId: json['couponId'] ?? '',
      itemList: json['itemList'] ?? [],
      coupon: json['coupon'] ?? 0,
      tip: json['tip'] ?? 0,
      price: json['price'] ?? 0,
      creatDate: json['creatDate'] ?? Timestamp.now(),
    );
  }
  // toMap method for converting an Order instance to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderName': orderName,
      'userName':userName,
      'userId': userId,
      'userHp': userHp,
      'address': address,
      'addressDetail': addressDetail,
      'postcode': postcode,
      'method': method,
      'purchasedAt': purchasedAt,
      'memo': memo,
      'cardCompany': cardCompany,
      'cardNo': cardNo,
      'itemType': itemType,
      'status':status,
      'storeName':storeName,
      'storeId':storeId,
      'couponId': couponId,
      'itemList': itemList,
      'coupon': coupon,
      'tip': tip,
      'price': price,
      'creatDate': creatDate,
    };
  }
}
