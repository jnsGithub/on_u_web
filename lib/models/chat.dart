import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String documentId;
  final String chatRoomId;
  final DateTime createDate;
  final String senderId;
  final String chat;

  Chat({
    required this.documentId,
    required this.chatRoomId,
    required this.createDate,
    required this.senderId,
    required this.chat,
  });


  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      documentId:json['documentId'] ?? '',
      chatRoomId:json['chatRoomId'] ?? '',
      createDate:json['createDate'].toDate(),
      senderId:json['senderId'] ?? '',
      chat:json['chat'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentId'] = this.documentId;
    data['chatRoomId'] = this.chatRoomId;
    data['createDate'] = this.createDate;
    data['senderId'] = this.senderId;
    data['chat'] = this.chat;
    return data;
  }
}
