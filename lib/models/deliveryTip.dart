import 'package:cloud_firestore/cloud_firestore.dart';

class DeliveryTip {
  final String id;
  final List tip;
  final Timestamp creatDate;

  DeliveryTip({required this.id,required this.tip ,required this.creatDate});

  factory DeliveryTip.fromJson(Map<String, dynamic> json) {
    return DeliveryTip(
      id: json["id"],
      tip: json["tip"],
      creatDate:json["creatDate"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "tip": tip,
      "creatDate":creatDate.toDate().toIso8601String(),
    };
  }
}

