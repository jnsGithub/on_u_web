import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_u_web/models/reservationList.dart';

class Counselor {
  final String documentId;
  final String name;
  final String body;
  final String photoURL;
  final String profileURL;
  final String info;
  final String title;
  final List<DateTime> holyDate;
  final Map<String, dynamic> possibleTime;
  final List<ReservationList> reservationList;
  final DateTime date;



  Counselor({
    required this.documentId,
    required this.name,
    required this.body,
    required this.photoURL,
    required this.info,
    required this.title,
    required this.date,
    required this.profileURL,
    required this.possibleTime,
    required this.holyDate,
    required this.reservationList,
  });


  factory Counselor.fromJson(Map<String, dynamic> json) {
    List<DateTime> date = [];
    List<ReservationList> reservation = [];
    if(json['holyDate'] != null){
      for (var i in json['holyDate']){
        Timestamp b = i;
        date.add(b.toDate());
      }
    }
    if(json['reservationList'] != null){
      for (var i in json['reservationList']){
        reservation.add(ReservationList.fromJson(i));
      }
    }
      return Counselor(
        documentId:json['documentId'] ?? '',
        name:json['name'] ?? '',
        body:json['body'] ?? '',
        photoURL:json['photoURL'] ?? '',
        profileURL:json['profileURL'] ?? '',
        info: json['info'] ?? '',
        title:json['title'] ?? '',
        date:json['date'].toDate(),
        possibleTime:json['possibleTime'] ?? [],
        holyDate: date ?? [],
        reservationList: reservation ?? [],
      );

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentId'] = this.documentId;
    data['name'] = this.name;
    data['body'] = this.body;
    data['photoURL'] = this.photoURL;
    data['profileURL'] = this.profileURL;
    data['info'] = this.info;
    data['title'] = this.title;
    data['date'] = this.date;
    data['possibleTime'] = this.possibleTime;
    data['holyDate'] = this.holyDate;
    data['reservationList'] = this.reservationList;
    return data;
  }
}
