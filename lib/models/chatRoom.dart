import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  final String documentId;
  final String counselorId;
  final String userName;
  final String userId;
  String lastSenderId;
  bool isReadUser;
  bool isReadCounselor;
  DateTime lastChatDate;


  ChatRoom({
    required this.documentId,
    required this.counselorId,
    required this.userId,
    required this.lastSenderId,
    required this.isReadUser,
    required this.isReadCounselor,
    required this.lastChatDate,
    this.userName = '',
  });


  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      documentId:json['documentId'] ?? '',
      counselorId:json['counselor'] ?? '',
      userId:json['sender'] ?? '',
      lastSenderId:json['lastSenderId'] ?? '',
      isReadUser:json['isReadUser'] ?? false,
      isReadCounselor:json['isReadCounselor'] ?? false,
      lastChatDate:json['lastChatDate'].toDate(),
      userName:json['userName'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentId'] = this.documentId;
    data['counselor'] = this.counselorId;
    data['sender'] = this.userId;
    data['lastSenderId'] = this.lastSenderId;
    data['isReadUser'] = this.isReadUser;
    data['isReadCounselor'] = this.isReadCounselor;
    data['lastChatDate'] = this.lastChatDate;
    data['userName'] = this.userName;
    return data;
  }
}
