import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_u_web/models/users.dart';

class UserInfo{
  final db = FirebaseFirestore.instance;

  Future<Users> getUserInfo(String uid) async{
    try {
      DocumentSnapshot snapshot = await db.collection('users').doc(uid).get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      data['documentId'] = snapshot.id;
      return Users.fromJson(data);
    } catch (e) {
      print('유저 정보 가져올때 걸림');
      print(e);
      return Users(documentId: '', name: '탈퇴 회원입니다.', companyCode: '', companyName: '탈퇴한 회원입니다.', email: '');
    }
  }
}