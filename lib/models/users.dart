import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String username;
  String id;
  Timestamp createdDate;
  Timestamp? updatedDate;

  Users(
      {required this.username,
      required this.id,
      required this.createdDate,
      this.updatedDate});
}
