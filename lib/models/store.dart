class Store {
  final String storeId;
  final String storeName;
  final List storeImage;
  final String storeDescription;
  final List deliveryTip;
  final int shippingTip;
  final List storeType;
  final String storeAddress;
  final String storeAddressDetail;
  final String storePostalCode;
  final String storeLatitude;
  final String storeLongitude;
  final String openTime;
  final String closeTime;
  final List coupon;
  final List deliveryCategory;
  final List category;
  Store(
      {required this.storeId,
        required this.storeName,
        required this.storeImage,
        required this.storeDescription,
        required this.deliveryTip,
        required this.shippingTip,
        required this.storeType,
        required this.storeAddress,
        required this.storeAddressDetail,
        required this.storePostalCode,
        required this.storeLatitude,
        required this.storeLongitude,
        required this.openTime,
        required this.closeTime,
        required this.coupon,
        required this.deliveryCategory,
        required this.category
      });


  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      storeId : json['storeId'],
      storeName : json['storeName'],
      storeImage : json['storeImage'],
      storeDescription : json['storeDescription'],
      deliveryTip : json['deliveryTip'],
      shippingTip : json['shippingTip'],
      storeType : json['storeType'],
      storeAddress : json['storeAddress'],
      storeAddressDetail : json['storeAddressDetail'],
      storePostalCode : json['storePostalCode'],
      storeLatitude : json['storeLatitude'],
      storeLongitude : json['storeLongitude'],
      openTime : json['openTime'],
      closeTime : json['closeTime'],
      coupon : json['coupon'],
      deliveryCategory:json['deliveryCategory'],
      category: json['category'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
    'storeId' : storeId,
    'storeName' : storeName,
    'storeImage' : storeImage,
    'storeDescription' : storeDescription,
    'deliveryTip' : deliveryTip,
    'shippingTip' : shippingTip,
    'storeType' : storeType,
    'storeAddress' : storeAddress,
    'storeAddressDetail' : storeAddressDetail,
    'storePostalCode' : storePostalCode,
    'storeLatitude' : storeLatitude,
    'storeLongitude' : storeLongitude,
    'openTime' : openTime,
    'closeTime' : closeTime,
    'coupon' : coupon, 'deliveryCategory':deliveryCategory,
    'category' : category,
    };
  }
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   data['storeId'] = storeId;
  //   data['storeName'] = storeName;
  //   data['storeImage'] = storeImage;
  //   data['storeDescription'] = storeDescription;
  //   data['deliveryTip'] = deliveryTip;
  //   data['shippingTip'] = shippingTip;
  //   data['storeType'] = storeType;
  //   data['storeAddress'] = storeAddress;
  //   data['storeAddressDetail'] = storeAddressDetail;
  //   data['storePostalCode'] = storePostalCode;
  //   data['storeLatitude'] = storeLatitude;
  //   data['storeLongitude'] = storeLongitude;
  //   data['openTime'] = openTime;
  //   data['closeTime'] = closeTime;
  //   data['coupon'] = coupon;
  //   data['category'] = category;
  //   return data;
  // }
}
