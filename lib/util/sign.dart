import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:on_u_web/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sign{
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<bool> signIn(String id, String pw) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var a = await db.collection('counselor').where('id', isEqualTo: id).get();
      if(a.docs.isNotEmpty) {
        if(a.docs[0]['pw'] == pw) {
          print('로그인 성공');
          FirebaseAuth.instance.signInAnonymously();
          prefs.setString('uid', a.docs[0].id);
          uid = a.docs[0].id;
          print('로그인 할 때 : ${uid}');
          return true;
        } else {
          print('비밀번호가 틀립니다.');
          return false;
        }
      } else {
        print('아이디가 존재하지 않습니다.');
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}