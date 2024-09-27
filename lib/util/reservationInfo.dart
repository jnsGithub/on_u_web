import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_u_web/global.dart';
import 'package:on_u_web/models/reservationList.dart';

class ReservationInfo{
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<ReservationList>> getReservationList() async {
    try {
      final snapshot = await db.collection('reservation').where('counselorId', isEqualTo: uid).orderBy('createDate', descending: false).get();
      List<ReservationList> reservationList = [];
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['documentId'] = doc.id;
        reservationList.add(ReservationList.fromJson(data));
      }
      return reservationList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> deleteReservation(String documentId) async {
    try {
      await db.collection('reservation').doc(documentId).delete();
    } catch (e) {
      print(e);
    }
  }

}