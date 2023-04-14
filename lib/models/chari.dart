import 'package:cloud_firestore/cloud_firestore.dart';

class Chari {
  String category;
  String id;
  String brand;
  String frame;
  String? detail;
  Timestamp createdDate;
  Timestamp? updatedDate;

  Chari(
      {required this.category,
      required this.id,
      required this.brand,
      required this.frame,
      this.detail,
      required this.createdDate,
      this.updatedDate});
}
