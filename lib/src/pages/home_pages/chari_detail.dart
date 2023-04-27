// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import '../../../models/chari.dart';
// import 'add_edit_chari.dart';

// class ChariDetailPage extends StatelessWidget {
//   final Chari chari;
//   const ChariDetailPage(this.chari, {Key? key}) : super(key: key);

//   Future<void> deleteChari(String id) async {
//     final doc = FirebaseFirestore.instance.collection('chari').doc(id);
//     await doc.delete();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(chari.brand),
//           actions: <Widget>[
//             IconButton(
//               icon: const Icon(Icons.edit_note_rounded),
//               onPressed: () {
//                 showModalBottomSheet(
//                     context: context,
//                     builder: (context) {
//                       return SafeArea(
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             ListTile(
//                               onTap: () {
//                                 Navigator.pop(context);
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => AddEditChariPage(
//                                               currentChari: chari,
//                                             )));
//                               },
//                               leading: const Icon(Icons.edit),
//                               title: const Text('編集'),
//                             ),
//                             ListTile(
//                               onTap: () async {
//                                 await deleteChari(chari.id);
//                                 Navigator.pop(context);
//                               },
//                               leading: const Icon(Icons.delete),
//                               title: const Text('削除'),
//                             ),
//                           ],
//                         ),
//                       );
//                     });
//               },
//             ),
//           ],
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 'chari詳細',
//                 style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//               ),
//               Text(chari.frame),
//             ],
//           ),
//         ));
//   }
// }
