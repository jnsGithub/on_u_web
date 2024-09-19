import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  final String id;
  final String category;
  final String itemName;
  final String itemInfo;
  final String itemImage;
  final String itemInfoImage;
  final String storeId;
  final String itemType;
  final int price;
  final bool soldOut;
  final Timestamp creatDate;

  Item({required this.id,required this.category,required this.itemName,required this.itemInfo,required this.itemImage,required this.itemInfoImage,required this.itemType,required this.storeId,required this.price,required this.soldOut,required this.creatDate});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json["id"],
      category: json["category"],
      itemName:json["itemName"],
      itemInfo:json["itemInfo"],
      itemImage:json["itemImage"],
      itemInfoImage:json["itemInfoImage"],
      itemType:json["itemType"],
      storeId:json["storeId"],
      price:json["price"],
      soldOut:json["soldOut"],
      creatDate:json["creatDate"],
    );
  }
  factory Item.fromJson2(Map<String, dynamic> json) {
    return Item(
      id: json["id"],
      category: json["category"],
      itemName:json["itemName"],
      itemInfo:json["itemInfo"],
      itemImage:json["itemImage"],
      itemInfoImage:json["itemInfoImage"],
      itemType:json["itemType"],
      storeId:json["storeId"],
      price:json["price"],
      soldOut:json["soldOut"],
      creatDate:Timestamp.fromDate(DateTime.parse(json["creatDate"])),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "category": category,
      "itemName":itemName,
      "itemInfo":itemInfo,
      "itemImage":itemImage,
      "itemInfoImage":itemInfoImage,
      "itemType":itemType,
      "storeId":storeId,
      "price":price,
      "soldOut":soldOut,
      "creatDate":creatDate.toDate().toIso8601String(),
    };
  }
}

