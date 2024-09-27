import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationList {
  final String name;              // 사용자 이름
  final String hp;                // 전화번호
  final String request;           // 상담 요청 내용
  final DateTime createDate; // 예약 시간
  final String documentId;
  final String counselorId;
  final String userId;

  ReservationList({
    required this.name,
    required this.hp,
    required this.request,
    required this.createDate,
    required this.documentId,
    required this.counselorId,
    required this.userId,
  });

  // Firestore 데이터를 기반으로 Reservation 객체를 생성하는 팩토리 메서드
  factory ReservationList.fromJson(Map<String, dynamic> json) {
    return ReservationList(
      name: json['name'] ?? '',
      hp: json['hp']  ?? '',
      request: json['request'] ?? '',
      createDate: json['createDate'].toDate(),
      documentId: json['documentId'] ?? '',
      counselorId: json['counselorId'] ?? '',
      userId: json['userId'] ?? '',
    );
  }

  // Reservation 객체를 Firestore에 저장할 수 있는 JSON 형식으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'hp': hp,
      'request': request,
      'createDate': Timestamp.fromDate(createDate),  // DateTime을 Firestore의 Timestamp로 변환
      'documentId': documentId,
      'counselorId': counselorId,
      'userId': userId,
    };
  }
}
