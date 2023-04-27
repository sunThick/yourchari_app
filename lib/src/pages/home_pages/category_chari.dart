// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import '../../../models/chari.dart';
// import 'chari_detail.dart';

// class CategoryChari extends StatefulWidget {
//   final String category;
//   const CategoryChari({Key? key, required this.category}) : super(key: key);
//   @override
//   State<CategoryChari> createState() => _CategoryChariState();
// }

// class _CategoryChariState extends State<CategoryChari> {
//   @override
//   Widget build(BuildContext context) {
//     // 即時関数でallの場合は全て表示、カテゴリーの場合はカテゴリーに絞る
//     final chariCollection = () {
//       if (widget.category == 'all') {
//         return FirebaseFirestore.instance.collection('chari');
//       } else {
//         return FirebaseFirestore.instance
//             .collection('chari')
//             .where('category', isEqualTo: widget.category);
//       }
//     }();

//     return StreamBuilder<QuerySnapshot>(
//       stream: chariCollection.snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         }
//         if (!snapshot.hasData) {
//           return const Center(child: Text('no data'));
//         }

//         final docs = snapshot.data!.docs;

//         return ListView.builder(
//           itemCount: docs.length,
//           itemBuilder: (contet, index) {
//             Map<String, dynamic> data =
//                 docs[index].data() as Map<String, dynamic>;
//             final Chari fetchChari = Chari(
//               id: docs[index].id,
//               category: data['category'],
//               brand: data['brand'],
//               frame: data['frame'],
//               detail: data['detail'],
//               createdDate: data['createdDate'],
//               updatedDate: data['updatedDate'],
//             );
//             return ListTile(
//               title: Text(fetchChari.brand),
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ChariDetailPage(
//                               fetchChari,
//                             )));
//               },
//             );
//           },
//         );
//       },
//     );
//   }
// }
