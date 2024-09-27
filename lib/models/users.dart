import 'package:cloud_firestore/cloud_firestore.dart';

class Users{
  final String documentId;
  final String name;
  final String companyCode;
  final String companyName;
  final String email;

  Users({required this.documentId, required this.name, required this.companyCode, required this.companyName, required this.email});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      documentId: json['documentId'] ?? '',
      name: json['name'] ?? '',
      companyCode: json['companyCode'] ?? '',
      companyName: json['companyName'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentId'] = this.documentId;
    data['name'] = this.name;
    data['companyCode'] = this.companyCode;
    data['companyName'] = this.companyName;
    data['email'] = this.email;
    return data;
  }
}