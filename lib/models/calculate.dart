import 'package:cloud_firestore/cloud_firestore.dart';

class Calculate {
  final String documentId;
  final String storeId;
  final int pay;
  final int totalPay;
  final int coupon;
  final int tax;
  final int fee;
  final double feeData;
  final bool payment;
  final String calculateDate;
  final Timestamp creatDate;

  const Calculate({required this.fee,required this.coupon,required this.feeData,required this.tax,required this.totalPay,required this.storeId,required this.creatDate,required this.documentId,required this.pay,required this.payment,required this.calculateDate});

  factory Calculate.fromJson(Map<String, dynamic> json) {
    return Calculate(
      totalPay: json["totalPay"],
      coupon: json["coupon"],
      tax: json["tax"],
      feeData: json["feeData"],
      fee: json["fee"],
      documentId: json["documentId"],
      storeId: json["storeId"],
      pay: json["pay"],
      payment:json["payment"],
      calculateDate:json["calculateDate"],
      creatDate:json["creatDate"],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "totalPay": totalPay,
      "coupon": coupon,
      "tax": tax,
      "feeData": feeData,
      "fee": fee,
      "documentId": documentId,
      'storeId': storeId,
      "pay": pay,
      "payment":payment,
      "calculateDate":calculateDate,
      "creatDate":creatDate,
    };
  }
}
