import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:on_u_web/models/counselor.dart';

class CounselorInfo{
  FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<Counselor> getCounselorInfo(String uid) async {
    try {
      final snapshot = await db.collection('counselor').doc(uid).get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      data['documentId'] = snapshot.id;
      return Counselor.fromJson(data);
    } catch (e) {
      print(e);
      return Counselor(
        documentId: '',
        name: '',
        body: '',
        photoURL: '',
        profileURL: '',
        info: '',
        title: '',
        date: DateTime.now(),
        possibleTime: {
          'morning': [],
          'afternoon': [],
        },
        holyDate: [],
        reservationList: [],
      );
    }
  }
  Future<String?> uploadImageAndGetUrl(Rx<Uint8List?> image, String fileName) async {
    try {
      // 이미지가 null일 경우 처리
      if (image.value == null) {
        print('No image selected.');
        return null;
      }

      // Firebase Storage에 업로드할 파일 경로 지정 (예: images 폴더에 저장)
      final Reference ref = _storage.ref().child('images/${DateTime.now().toString() + fileName}.png');

      // Firebase에 업로드
      UploadTask uploadTask = ref.putData(image.value!);

      // 업로드 완료 후 다운로드 URL을 얻기
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      String downloadUrl = await snapshot.ref.getDownloadURL();

      print('Download URL: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> updateCounselorInfo(String uid, String? name, String? info, String? photoURL, List<String?> possibleAfternoon, List<String?> possibleMorning) async {
    try {
      await db.collection('counselor').doc(uid).update({
        'name': name ?? FieldOverrideIndex(queryScope: 'name'),
        'body': info ?? FieldOverrideIndex(queryScope: 'body'),
        'possibleTime': {
          'afternoon' : possibleAfternoon,
          'morning' : possibleMorning,
        },
        if(photoURL != null) 'photoURL': photoURL,
      });
    } catch (e) {
      print(e);
    }
  }

  List<String?> convertList(List<String?> possibleTime , List<String> totalTime) {
    List<String> result = [];
    result.addAll(totalTime);
    for(int i = 0; i < possibleTime.length; i++) {
      for (String time in totalTime) {
        if(possibleTime[i] == time) {
          result.remove(time);
        }
      }
    }
    print(result);
    return result;
  }

  Future<void> setHolyDate(String uid, DateTime holyDate, bool isHolday) async {
    try {
      print('휴일 설정 중');
      await db.collection('counselor').doc(uid).update({
        'holyDate': isHolday ? FieldValue.arrayUnion([holyDate]) : FieldValue.arrayRemove([holyDate]),


      });
      print('${holyDate}휴일 설정 완료');
    } catch (e) {
      print(e);
    }
  }
}