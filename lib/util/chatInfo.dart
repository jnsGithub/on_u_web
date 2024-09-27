import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_u_web/models/chat.dart';
import 'package:on_u_web/models/chatRoom.dart';

class ChatInfo{
  FirebaseFirestore db = FirebaseFirestore.instance;


  Future<List<ChatRoom>> getChatList(String userId) async {
    try {
      List<ChatRoom> chatRoomList = [];
      QuerySnapshot chatList = await db.collection('chatRoom').where('counselorId', isEqualTo: userId).orderBy('lastChatDate', descending: false).get();
      for (QueryDocumentSnapshot document in chatList.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        DocumentSnapshot users = await db.collection('user').doc(data['userId']).get();
        Map<String, dynamic> userData = users.data() as Map<String, dynamic>;
        data['documentId'] = document.id;
        data['userName'] = userData['name'];
        chatRoomList.add(ChatRoom.fromJson(data));
      }
      return chatRoomList;
    } catch (e) {
      print(e);
      return[];
    }
  }
  Future<List<Chat>> getChat(String chatRoomId) async {
    try {
      List<Chat> chatList = [];
      QuerySnapshot chat = await db.collection('chat').where('chatRoomId', isEqualTo: chatRoomId).orderBy('date', descending: false).get();
      for (QueryDocumentSnapshot document in chat.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        data['documentId'] = document.id;
        chatList.add(Chat.fromJson(data));
      }
      return chatList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> sendChat(String chatRoomId, String chat, String uid) async {
    try {
      await db.collection('chat').add({
        'chatRoomId' : chatRoomId,
        'chat': chat,
        'senderId': uid,
        'createDate': DateTime.now(),
      });
      await db.collection('chatRoom').doc(chatRoomId).update({
        'lastSenderId': uid,
        'lastChatDate': DateTime.now(),
        'lastChat': chat,
        'isReadUser': false,
        'isReadCounselor': true,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}