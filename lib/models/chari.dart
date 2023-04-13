import 'package:cloud_firestore/cloud_firestore.dart';

class Chari {
  String id;
  String brand;
  String frame;
  String? detail;
  Timestamp createdDate;
  Timestamp? updatedDate;

  Chari(
      {required this.id,
      required this.brand,
      required this.frame,
      this.detail,
      required this.createdDate,
      this.updatedDate});
}
